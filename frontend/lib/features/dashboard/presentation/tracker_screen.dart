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
import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;

// ── Category model (live data only) ─────────────────────────────────────────

class _Category {
  const _Category({
    required this.name,
    required this.percent,
    required this.amount,
    required this.icon,
    required this.bgColor,
    required this.accentColor,
  });

  final String name;
  final int percent;
  final String amount;
  final IconData icon;
  final Color bgColor;
  final Color accentColor;
}

// ── Screen ──────────────────────────────────────────────────────────────────

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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: warmSurface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Header(onHistoryTap: () => context.push('/history')),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _MonthSelector(
                visibleMonth: _visibleMonth,
                onPrevious: () => _shiftMonth(-1),
                onNext: () => _shiftMonth(1),
              ),
            ),
            const SizedBox(height: 16),
            AnimatedBuilder(
              animation: AppScope.ledgerRefreshOf(context),
              builder: (context, _) {
                return FutureBuilder<List<financev1.Expense>>(
                  key: ValueKey(AppScope.ledgerRefreshOf(context).revision),
                  future: AppScope.of(context).financeRepository.listExpenses(),
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
                          child: CircularProgressIndicator(color: primaryGreen),
                        ),
                      );
                    }
                    final all = snapshot.data ?? const <financev1.Expense>[];
                    final filtered = _expensesInMonth(all, _visibleMonth);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _LiveSummaryCard(expenses: filtered),
                        ),
                        const SizedBox(height: 28),
                        const _SectionHeader(title: 'Gastos por categoría'),
                        const SizedBox(height: 12),
                        _LiveCategoriesRow(expenses: filtered),
                        const SizedBox(height: 28),
                        const _SectionHeader(title: 'Apartados'),
                        const SizedBox(height: 12),
                        const _EmptyFeatureBlock(
                          message:
                              'Aquí podrás ver y administrar tus apartados cuando la función esté disponible.',
                        ),
                        const SizedBox(height: 28),
                        const _SectionHeader(title: 'Metas financieras'),
                        const SizedBox(height: 12),
                        const _EmptyFeatureBlock(
                          message:
                              'Podrás definir metas y seguir tu avance cuando activemos esta sección.',
                        ),
                        const SizedBox(height: 28),
                        const _SectionHeader(
                          title: 'Recordatorios y pagos recurrentes',
                        ),
                        const SizedBox(height: 12),
                        const _EmptyFeatureBlock(
                          message:
                              'Te avisaremos de pagos recurrentes y recordatorios cuando esté listo.',
                        ),
                        const SizedBox(height: 28),
                      ],
                    );
                  },
                );
              },
            ),
            if (_uploadError != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FAlert(
                  variant: FAlertVariant.destructive,
                  title: const Text('No pude subir el ticket'),
                  subtitle: Text(_uploadError!),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _ScanButton(onTap: _startUpload, isBusy: _isUploading),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.onHistoryTap});

  final VoidCallback onHistoryTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tu dinero',
                style: TextStyle(
                  color: ink,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                  height: 1.0,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Finanzas personales',
                style: TextStyle(
                  color: inkMuted,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: onHistoryTap,
            behavior: HitTestBehavior.opaque,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x10000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(FIcons.clock, size: 18, color: inkMuted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Month selector ────────────────────────────────────────────────────────────

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
          borderRadius: BorderRadius.circular(10),
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
                child: Text(
                  label,
                  style: const TextStyle(
                    color: ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              IconButton(
                onPressed: onNext,
                icon: const Icon(FIcons.chevronRight, size: 18, color: inkMuted),
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

// ── Summary card ──────────────────────────────────────────────────────────────

class _LiveSummaryCard extends StatelessWidget {
  const _LiveSummaryCard({required this.expenses});

  final List<financev1.Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final stats = _summaryFromExpenses(expenses);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 12,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _FlowTile(
                    label: 'Gastos',
                    amount: formatSignedMxMoney(-stats.totalExpenseUnits),
                    sub: '${stats.expenseCount} movimientos',
                    isExpense: true,
                  ),
                ),
                Container(
                  width: 1,
                  height: 52,
                  color: borderSubtle,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                Expanded(
                  child: _FlowTile(
                    label: 'Ingresos',
                    amount: formatMxMoney(stats.totalIncomeUnits),
                    sub: stats.incomeCount == 0
                        ? 'Sin ingresos'
                        : '${stats.incomeCount} movimientos',
                    isExpense: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: warmSurface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Balance',
                      style: TextStyle(
                        color: inkMuted,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatSignedMxMoney(stats.netBalanceUnits),
                      style: const TextStyle(
                        color: ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowTile extends StatelessWidget {
  const _FlowTile({
    required this.label,
    required this.amount,
    required this.sub,
    required this.isExpense,
  });

  final String label;
  final String amount;
  final String sub;
  final bool isExpense;

  @override
  Widget build(BuildContext context) {
    final arrowColor = isExpense ? const Color(0xFFE53935) : midGreen;
    final arrowIcon = isExpense ? FIcons.arrowDown : FIcons.arrowUp;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: inkMuted,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(arrowIcon, size: 13, color: arrowColor),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: isExpense ? const Color(0xFFE53935) : ink,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          sub,
          style: const TextStyle(
            color: inkMuted,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Empty feature blocks ──────────────────────────────────────────────────────

class _EmptyFeatureBlock extends StatelessWidget {
  const _EmptyFeatureBlock({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderSubtle),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Text(
            message,
            style: const TextStyle(
              color: inkMuted,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Categories row ────────────────────────────────────────────────────────────

class _LiveCategoriesRow extends StatelessWidget {
  const _LiveCategoriesRow({required this.expenses});

  final List<financev1.Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final categories = _categoriesFromExpenses(expenses);
    if (categories.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sin gastos por categoría en este mes.',
            style: TextStyle(
              color: inkMuted,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: categories.length,
        separatorBuilder: (context, i) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _CategoryCard(category: categories[i]),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category});

  final _Category category;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: category.bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SizedBox(
        width: 88,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${category.percent}%',
                    style: TextStyle(
                      color: category.accentColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Icon(category.icon, size: 14, color: category.accentColor),
                ],
              ),
              const Spacer(),
              Text(
                category.name,
                style: const TextStyle(
                  color: ink,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                category.amount,
                style: const TextStyle(
                  color: ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Scan / add button ─────────────────────────────────────────────────────────

class _ScanButton extends StatelessWidget {
  const _ScanButton({required this.onTap, required this.isBusy});

  final VoidCallback onTap;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isBusy ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isBusy ? 0.72 : 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [primaryGreen, midGreen],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isBusy)
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(surface),
                    ),
                  )
                else
                  const Icon(FIcons.plus, size: 18, color: surface),
                const SizedBox(width: 8),
                Text(
                  isBusy ? 'Subiendo ticket…' : 'Escanear o registrar',
                  style: const TextStyle(
                    color: surface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

List<_Category> _categoriesFromExpenses(List<financev1.Expense> expenses) {
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

  return sorted.take(4).map((entry) {
    final amount = entry.value;
    final percent = globalTotal <= 0
        ? 0
        : ((amount / globalTotal) * 100).round();
    return _Category(
      name: _titleCase(entry.key),
      percent: percent,
      amount: formatMxMoney(amount),
      icon: _categoryIcon(entry.key),
      bgColor: _categoryBackground(entry.key),
      accentColor: _categoryAccent(entry.key),
    );
  }).toList();
}

String _titleCase(String value) {
  if (value.isEmpty) return value;
  return value[0].toUpperCase() + value.substring(1).toLowerCase();
}

IconData _categoryIcon(String key) {
  switch (key) {
    case 'food':
      return FIcons.utensils;
    case 'transport':
      return FIcons.car;
    case 'groceries':
      return FIcons.shoppingCart;
    case 'entertainment':
      return FIcons.popcorn;
    default:
      return FIcons.receipt;
  }
}

Color _categoryBackground(String key) {
  switch (key) {
    case 'food':
      return const Color(0xFFFFF3E0);
    case 'transport':
      return const Color(0xFFE3F2FD);
    case 'groceries':
      return const Color(0xFFE7F5EC);
    case 'entertainment':
      return const Color(0xFFF3E5F5);
    default:
      return const Color(0xFFFCE4EC);
  }
}

Color _categoryAccent(String key) {
  switch (key) {
    case 'food':
      return const Color(0xFFE67E22);
    case 'transport':
      return const Color(0xFF1E88E5);
    case 'groceries':
      return const Color(0xFF2FA366);
    case 'entertainment':
      return const Color(0xFF8E24AA);
    default:
      return const Color(0xFFE91E63);
  }
}
