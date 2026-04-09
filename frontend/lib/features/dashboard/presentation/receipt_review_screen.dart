import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/pill_button.dart';
import '../../../core/ui/screen_header.dart';
import '../../../gen/primerpeso/documents/v1/documents.pb.dart' as documentsv1;

class ReceiptReviewScreen extends StatefulWidget {
  const ReceiptReviewScreen({required this.draft, super.key});

  final documentsv1.ReceiptDraft draft;

  @override
  State<ReceiptReviewScreen> createState() => _ReceiptReviewScreenState();
}

class _ReceiptReviewScreenState extends State<ReceiptReviewScreen> {
  late final TextEditingController _merchantController;
  late final TextEditingController _titleController;
  late final TextEditingController _categoryController;
  late final TextEditingController _amountController;

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _merchantController = TextEditingController(
      text: widget.draft.merchantName,
    );
    _titleController = TextEditingController(
      text: widget.draft.merchantName.isEmpty
          ? 'Gasto confirmado'
          : 'Gasto en ${widget.draft.merchantName}',
    );
    _categoryController = TextEditingController(
      text: widget.draft.suggestedCategory,
    );
    _amountController = TextEditingController(
      text: widget.draft.total.units.toString(),
    );
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    final ledgerRefresh = AppScope.ledgerRefreshOf(context);
    final amountUnits = int.tryParse(_amountController.text.trim());
    if (amountUnits == null) {
      setState(() => _errorMessage = 'El monto debe ser un número entero.');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final response = await AppScope.of(context).financeRepository
          .confirmExpense(
            draft: widget.draft,
            merchantName: _merchantController.text.trim(),
            displayTitle: _titleController.text.trim(),
            category: _categoryController.text.trim(),
            amountUnits: amountUnits,
          );
      ledgerRefresh.markChanged();
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Gasto confirmado', style: PTypography.title),
          content: Text(
            'Tu score actualizado es ${response.scoreSummary.score}.',
            style: PTypography.body,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cerrar',
                style: PTypography.bodyStrong.copyWith(color: primaryGreen),
              ),
            ),
          ],
        ),
      );
      if (!mounted) return;
      context.go('/score');
    } catch (error) {
      if (!mounted) return;
      setState(() => _errorMessage = error.toString());
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ScreenHeader(
                title: 'Revisa la extracción',
                subtitle: widget.draft.redactedRawText.isEmpty
                    ? 'Subimos el ticket y dejamos listo el borrador.'
                    : 'Antes de pasarlo al ledger, valida comercio, monto y categoría.',
                leading: _BackButton(onTap: () => context.pop()),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_errorMessage != null) ...[
                      FAlert(
                        variant: FAlertVariant.destructive,
                        title: const Text('No pude confirmar el gasto'),
                        subtitle: Text(_errorMessage!),
                      ),
                      const SizedBox(height: 14),
                    ],
                    HeroCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _ReviewField(
                            label: 'Comercio',
                            controller: _merchantController,
                          ),
                          const SizedBox(height: 14),
                          _ReviewField(
                            label: 'Título',
                            controller: _titleController,
                          ),
                          const SizedBox(height: 14),
                          _ReviewField(
                            label: 'Categoría',
                            controller: _categoryController,
                          ),
                          const SizedBox(height: 14),
                          _ReviewField(
                            label: 'Monto (MXN)',
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    HeroCard.compact(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Texto redaccionado',
                            style: PTypography.bodyStrong,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.draft.redactedRawText.isEmpty
                                ? 'No llegó texto OCR en esta captura; puedes confirmar de todos modos.'
                                : widget.draft.redactedRawText,
                            style: PTypography.body.copyWith(
                              color: inkMuted,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    PillButton.primary(
                      label: _isSubmitting ? 'Confirmando…' : 'Confirmar gasto',
                      onPressed: _isSubmitting ? null : _confirm,
                      busy: _isSubmitting,
                    ),
                    const SizedBox(height: 10),
                    PillButton.surface(
                      label: 'Cancelar',
                      onPressed: _isSubmitting ? null : () => context.pop(),
                      expand: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          shape: BoxShape.circle,
          border: Border.all(color: borderSubtle, width: 1.2),
        ),
        child: const SizedBox(
          width: 44,
          height: 44,
          child: Center(child: Icon(FIcons.arrowLeft, size: 18, color: ink)),
        ),
      ),
    );
  }
}

class _ReviewField extends StatelessWidget {
  const _ReviewField({
    required this.label,
    required this.controller,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: PTypography.body,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: PTypography.label.copyWith(color: inkMuted),
        filled: true,
        fillColor: warmSurface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: primaryGreen, width: 1.4),
        ),
      ),
    );
  }
}
