import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
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
          title: const Text('Gasto confirmado'),
          content: Text(
            'Tu score actualizado es ${response.scoreSummary.score}.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
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
    return ColoredBox(
      color: warmSurface,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FButton.icon(
                onPress: () => context.pop(),
                child: const Icon(FIcons.arrowLeft),
              ),
              const SizedBox(height: 24),
              const Text(
                'Revisa la extracción',
                style: TextStyle(
                  color: ink,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.draft.redactedRawText.isEmpty
                    ? 'Subimos el ticket y dejamos listo el borrador.'
                    : 'Antes de pasarlo al ledger, valida comercio, monto y categoría.',
                style: const TextStyle(
                  color: inkMuted,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              if (_errorMessage != null) ...[
                FAlert(
                  variant: FAlertVariant.destructive,
                  title: const Text('No pude confirmar el gasto'),
                  subtitle: Text(_errorMessage!),
                ),
                const SizedBox(height: 12),
              ],
              _ReviewField(label: 'Comercio', controller: _merchantController),
              const SizedBox(height: 12),
              _ReviewField(label: 'Título', controller: _titleController),
              const SizedBox(height: 12),
              _ReviewField(label: 'Categoría', controller: _categoryController),
              const SizedBox(height: 12),
              _ReviewField(
                label: 'Monto (MXN)',
                controller: _amountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderSubtle),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Texto redaccionado',
                        style: TextStyle(
                          color: ink,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.draft.redactedRawText.isEmpty
                            ? 'No llegó texto OCR en esta captura; puedes confirmar de todos modos.'
                            : widget.draft.redactedRawText,
                        style: const TextStyle(
                          color: inkMuted,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FButton(
                  onPress: _isSubmitting ? null : _confirm,
                  child: Text(
                    _isSubmitting ? 'Confirmando…' : 'Confirmar gasto',
                  ),
                ),
              ),
            ],
          ),
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
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
