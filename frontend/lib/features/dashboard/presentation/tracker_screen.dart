import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/app_scope.dart';
import '../../../core/formatting/money_format.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/bar_chart.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/pill_button.dart';
import '../../../core/ui/pill_stat.dart';
import '../../../core/ui/screen_header.dart';
import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;

/// Cash management home — monthly summary, categories, and planning slots.
class TrackerScreen extends StatefulWidget {
  const TrackerScreen({super.key});

  @override
  State<TrackerScreen> createState() => _TrackerScreenState();
}

class _TrackerScreenState extends State<TrackerScreen> {
  final ImagePicker _picker = ImagePicker();

  bool _isUploading = false;
  String? _uploadError;

  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    final n = DateTime.now();
    _visibleMonth = DateTime(n.year, n.month);
  }

  void _shiftMonth(int delta) {
    setState(() {
      _visibleMonth = DateTime(_visibleMonth.year, _visibleMonth.month + delta);
    });
  }

  Future<void> _startUpload() async {
    final receiptRepository = AppScope.of(context).receiptRepository;

    final source = await showModalBottomSheet<_TrackerAttachmentSource>(
      context: context,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(FIcons.camera),
              title: const Text('Tomar foto'),
              onTap: () =>
                  Navigator.of(context).pop(_TrackerAttachmentSource.camera),
            ),
            ListTile(
              leading: const Icon(FIcons.image),
              title: const Text('Elegir de galería'),
              onTap: () =>
                  Navigator.of(context).pop(_TrackerAttachmentSource.gallery),
            ),
            ListTile(
              leading: const Icon(FIcons.file),
              title: const Text('Subir PDF'),
              onTap: () =>
                  Navigator.of(context).pop(_TrackerAttachmentSource.pdf),
            ),
          ],
        ),
      ),
    );
    if (source == null) return;

    setState(() {
      _isUploading = true;
      _uploadError = null;
    });

    try {
      final payload = await _pickPayload(source);
      if (payload == null) {
        if (mounted) {
          setState(() => _isUploading = false);
        }
        return;
      }

      final response = await receiptRepository.uploadReceipt(
        content: payload.bytes,
        filename: payload.filename,
        mimeType: payload.mimeType,
      );
      if (!mounted) return;
      if (_needsClarification(response)) {
        await context.push('/receipt-review', extra: response.draft);
      } else {
        AppScope.ledgerRefreshOf(context).markChanged();
        final draft = response.draft;
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Gasto registrado'),
            content: Text(
              '${draft.merchantName} por ${formatMxMoneyInt64(draft.total.units)} ${draft.total.currencyCode}.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      setState(() => _uploadError = error.toString());
    } finally {
      if (mounted) {
        setState(() => _isUploading = false);
      }
    }
  }

  Future<_TrackerPayload?> _pickPayload(_TrackerAttachmentSource source) async {
    if (source == _TrackerAttachmentSource.pdf) {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: const ['pdf'],
        withData: true,
      );
      if (result == null ||
          result.files.isEmpty ||
          result.files.first.bytes == null) {
        return null;
      }
      return _TrackerPayload(
        bytes: result.files.first.bytes!,
        filename: result.files.first.name,
        mimeType: 'application/pdf',
      );
    }

    final image = await _picker.pickImage(
      source: source == _TrackerAttachmentSource.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      imageQuality: 92,
    );
    if (image == null) return null;
    final bytes = await image.readAsBytes();
    return _TrackerPayload(
      bytes: bytes,
      filename: image.name,
      mimeType: _mimeTypeForPath(image.path),
    );
  }

  void _askPesoForSavings() {
    AppScope.of(context).pendingChatMessage.value =
        '¿Qué puedo ahorrar este mes?';
    context.go('/chat');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ScreenHeader(
            title: 'Hola',
            subtitle: 'PrimerPeso administra tu dinero',
            trailing: _IconChip(
              icon: FIcons.clock,
              onTap: () => context.push('/history'),
            ),
          ),
          const SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _MonthSelector(
              visibleMonth: _visibleMonth,
              onPrevious: () => _shiftMonth(-1),
              onNext: () => _shiftMonth(1),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: AnimatedBuilder(
              animation: AppScope.ledgerRefreshOf(context),
              builder: (context, _) {
                return FutureBuilder<List<financev1.Expense>>(
                  key: ValueKey(AppScope.ledgerRefreshOf(context).revision),
                  future: AppScope.of(
                    context,
                  ).financeRepository.listExpenses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: FAlert(
                          variant: FAlertVariant.destructive,
                          title: const Text('No pude cargar movimientos'),
                          subtitle: Text(snapshot.error.toString()),
                        ),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: primaryGreen,
                          ),
                        ),
                      );
                    }
                    final all = snapshot.data ?? const <financev1.Expense>[];
                    final filtered = _expensesInMonth(all, _visibleMonth);
                    return _TrackerBody(
                      expenses: filtered,
                      uploadError: _uploadError,
                      isUploading: _isUploading,
                      onScan: _startUpload,
                      onAiInsightTap: _askPesoForSavings,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ── Body composition ─────────────────────────────────────────────────────────

class _TrackerBody extends StatelessWidget {
  const _TrackerBody({
    required this.expenses,
    required this.uploadError,
    required this.isUploading,
    required this.onScan,
    required this.onAiInsightTap,
  });

  final List<financev1.Expense> expenses;
  final String? uploadError;
  final bool isUploading;
  final VoidCallback onScan;
  final VoidCallback onAiInsightTap;

  @override
  Widget build(BuildContext context) {
    final stats = _summaryFromExpenses(expenses);
    final categories = _categoriesFromExpenses(expenses);

    // Reserve enough room at the bottom of the scroll area so the last
    // section never tucks under the floating "Escanear o registrar" CTA.
    // Button height ~56 + 16 top breathing room + 24 base padding ≈ 110.
    const floatingClearance = 110.0;

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, floatingClearance),
          children: [
            _BalanceCard(stats: stats, onAskPeso: onAiInsightTap),
            const SizedBox(height: 28),
            Text('Gastos por categoría', style: PTypography.subtitle),
            const SizedBox(height: 14),
            if (categories.isEmpty)
              _EmptyFeatureBlock(
                message:
                    'Sin gastos registrados este mes. Escanea un ticket para empezar.',
              )
            else
              HeroCard(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
                child: MonthBarChart(
                  bars: categories
                      .map(
                        (c) => MonthBar(label: c.shortLabel, percent: c.percent),
                      )
                      .toList(),
                  height: 170,
                ),
              ),
            const SizedBox(height: 28),
            Text('Apartados', style: PTypography.subtitle),
            const SizedBox(height: 12),
            const _EmptyFeatureBlock(
              message:
                  'Aquí podrás ver y administrar tus apartados cuando la función esté disponible.',
            ),
            const SizedBox(height: 28),
            Text('Metas financieras', style: PTypography.subtitle),
            const SizedBox(height: 12),
            const _EmptyFeatureBlock(
              message:
                  'Podrás definir metas y seguir tu avance cuando activemos esta sección.',
            ),
            const SizedBox(height: 28),
            Text(
              'Recordatorios y pagos recurrentes',
              style: PTypography.subtitle,
            ),
            const SizedBox(height: 12),
            const _EmptyFeatureBlock(
              message:
                  'Te avisaremos de pagos recurrentes y recordatorios cuando esté listo.',
            ),
            if (uploadError != null) ...[
              const SizedBox(height: 16),
              FAlert(
                variant: FAlertVariant.destructive,
                title: const Text('No pude subir el ticket'),
                subtitle: Text(uploadError!),
              ),
            ],
          ],
        ),
        // Floating CTA: pinned over the scroll list so registering an
        // expense is always one tap away. A short gradient veil under it
        // keeps the content readable as it scrolls behind the button.
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: IgnorePointer(
            child: SizedBox(
              height: 60,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      gradientEnd.withValues(alpha: 0),
                      gradientEnd.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          bottom: 16,
          child: PillButton.primary(
            label: isUploading ? 'Subiendo ticket…' : 'Escanear o registrar',
            icon: FIcons.plus,
            busy: isUploading,
            onPressed: onScan,
          ),
        ),
      ],
    );
  }
}

// ── Balance hero card ────────────────────────────────────────────────────────

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.stats, required this.onAskPeso});

  final _SummaryStats stats;
  final VoidCallback onAskPeso;

  @override
  Widget build(BuildContext context) {
    final spentPercent = stats.totalIncomeUnits == 0
        ? 0
        : ((stats.totalExpenseUnits / stats.totalIncomeUnits) * 100)
              .clamp(0, 999)
              .round();
    final isHealthy = stats.netBalanceUnits >= 0 || stats.totalIncomeUnits == 0;

    return HeroCard(
      padding: const EdgeInsets.fromLTRB(28, 26, 28, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tu balance este mes', style: PTypography.label),
          const SizedBox(height: 14),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              formatSignedMxMoney(stats.netBalanceUnits),
              style: PTypography.display,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${stats.expenseCount} gastos · ${stats.incomeCount} ingresos',
            style: PTypography.body.copyWith(color: inkMuted),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (isHealthy)
                const PillStat.success('Bien este mes')
              else
                const PillStat.danger('Cuidado este mes'),
              if (stats.totalIncomeUnits > 0)
                PillStat.neutral('$spentPercent% gastado'),
            ],
          ),
          const SizedBox(height: 18),
          // Inline divider keeps the insight row attached to the card so it
          // reads as part of the balance summary, not a separate callout.
          Container(height: 1, color: borderSubtle),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: onAskPeso,
            behavior: HitTestBehavior.opaque,
            child: Row(
              children: [
                const Icon(FIcons.sparkles, size: 16, color: primaryGreen),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Pregúntale a Peso qué puedes ahorrar',
                    style: PTypography.bodyStrong.copyWith(
                      color: primaryGreen,
                    ),
                  ),
                ),
                const Icon(
                  FIcons.arrowUpRight,
                  size: 16,
                  color: primaryGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Month selector ───────────────────────────────────────────────────────────

class _MonthSelector extends StatelessWidget {
  const _MonthSelector({
    required this.visibleMonth,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime visibleMonth;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = DateFormat.yMMMM('es_MX').format(visibleMonth);
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: borderSubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: onPrevious,
                icon: const Icon(FIcons.chevronLeft, size: 18, color: inkMuted),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  minimumSize: const Size(32, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(label, style: PTypography.bodyStrong),
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(
                  FIcons.chevronRight,
                  size: 18,
                  color: inkMuted,
                ),
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(4),
                  minimumSize: const Size(32, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Empty feature block ──────────────────────────────────────────────────────

class _EmptyFeatureBlock extends StatelessWidget {
  const _EmptyFeatureBlock({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return HeroCard.compact(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Text(message, style: PTypography.body.copyWith(color: inkMuted)),
    );
  }
}

// ── Trailing icon chip in header ─────────────────────────────────────────────

class _IconChip extends StatelessWidget {
  const _IconChip({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, size: 18, color: ink),
        ),
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

String _mimeTypeForPath(String path) {
  final lower = path.toLowerCase();
  if (lower.endsWith('.png')) {
    return 'image/png';
  }
  if (lower.endsWith('.webp')) {
    return 'image/webp';
  }
  return 'image/jpeg';
}

bool _needsClarification(documentsv1.UploadReceiptResponse response) {
  return response.decision ==
      documentsv1.ExtractionDecision.EXTRACTION_DECISION_NEEDS_CLARIFICATION;
}

enum _TrackerAttachmentSource { camera, gallery, pdf }

class _TrackerPayload {
  const _TrackerPayload({
    required this.bytes,
    required this.filename,
    required this.mimeType,
  });

  final Uint8List bytes;
  final String filename;
  final String mimeType;
}

class _SummaryStats {
  const _SummaryStats({
    required this.totalExpenseUnits,
    required this.totalIncomeUnits,
    required this.expenseCount,
    required this.incomeCount,
    required this.netBalanceUnits,
  });

  final int totalExpenseUnits;
  final int totalIncomeUnits;
  final int expenseCount;
  final int incomeCount;
  final int netBalanceUnits;
}

List<financev1.Expense> _expensesInMonth(
  List<financev1.Expense> all,
  DateTime yearMonth,
) {
  return all.where((e) {
    if (!e.hasOccurredAt()) return false;
    final d = e.occurredAt.toDateTime().toLocal();
    return d.year == yearMonth.year && d.month == yearMonth.month;
  }).toList();
}

_SummaryStats _summaryFromExpenses(List<financev1.Expense> expenses) {
  var expenseTotal = 0;
  var incomeTotal = 0;
  var expenseCount = 0;
  var incomeCount = 0;
  for (final expense in expenses) {
    final units = expense.amount.units.toInt();
    if (units < 0) {
      incomeTotal += units.abs();
      incomeCount += 1;
      continue;
    }
    expenseTotal += units;
    expenseCount += 1;
  }
  return _SummaryStats(
    totalExpenseUnits: expenseTotal,
    totalIncomeUnits: incomeTotal,
    expenseCount: expenseCount,
    incomeCount: incomeCount,
    netBalanceUnits: incomeTotal - expenseTotal,
  );
}

class _CategoryBar {
  const _CategoryBar({required this.shortLabel, required this.percent});
  final String shortLabel;
  final int percent;
}

List<_CategoryBar> _categoriesFromExpenses(List<financev1.Expense> expenses) {
  if (expenses.isEmpty) return const [];

  final totals = <String, int>{};
  var globalTotal = 0;
  for (final expense in expenses) {
    final units = expense.amount.units.toInt();
    if (units <= 0) continue;
    final key = expense.category.isEmpty ? 'general' : expense.category;
    totals[key] = (totals[key] ?? 0) + units;
    globalTotal += units;
  }
  if (totals.isEmpty) return const [];

  final sorted = totals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return sorted.take(5).map((entry) {
    final amount = entry.value;
    final percent = globalTotal <= 0
        ? 0
        : ((amount / globalTotal) * 100).round();
    return _CategoryBar(shortLabel: _shortLabel(entry.key), percent: percent);
  }).toList();
}

String _shortLabel(String key) {
  if (key.isEmpty) return 'Otro';
  final lower = key.toLowerCase();
  const map = {
    'food': 'Comida',
    'transport': 'Transp.',
    'groceries': 'Despensa',
    'entertainment': 'Ocio',
    'general': 'General',
    'subscriptions': 'Subs.',
    'health': 'Salud',
    'education': 'Educ.',
    'rent': 'Renta',
    'utilities': 'Servicios',
  };
  if (map.containsKey(lower)) return map[lower]!;
  if (lower.length <= 8) {
    return lower[0].toUpperCase() + lower.substring(1);
  }
  return '${lower[0].toUpperCase()}${lower.substring(1, 7)}.';
}
