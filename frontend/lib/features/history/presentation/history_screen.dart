import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: surface,
      child: SafeArea(
        child: Padding(
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
                'Historial',
                style: TextStyle(
                  color: ink,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Aquí verás cada gasto registrado por Peso y cómo movió tu criterio score.',
                style: TextStyle(color: inkMuted, fontSize: 15, height: 1.4),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: AnimatedBuilder(
                  animation: AppScope.ledgerRefreshOf(context),
                  builder: (context, _) =>
                      FutureBuilder<List<financev1.Expense>>(
                        key: ValueKey(
                          AppScope.ledgerRefreshOf(context).revision,
                        ),
                        future: AppScope.of(
                          context,
                        ).financeRepository.listExpenses(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return FAlert(
                              variant: FAlertVariant.destructive,
                              title: const Text('No pude cargar el historial'),
                              subtitle: Text(snapshot.error.toString()),
                            );
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: primaryGreen,
                              ),
                            );
                          }
                          final expenses = snapshot.data!;
                          if (expenses.isEmpty) {
                            return const Center(
                              child: Text(
                                'Aún no hay movimientos confirmados.',
                                style: TextStyle(color: inkMuted, fontSize: 14),
                              ),
                            );
                          }
                          return ListView.separated(
                            itemCount: expenses.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) =>
                                _ExpenseTile(expense: expenses[index]),
                          );
                        },
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

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({required this.expense});

  final financev1.Expense expense;

  @override
  Widget build(BuildContext context) {
    final units = expense.amount.units.toInt();
    final isIncome = units < 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Icon(
              isIncome ? FIcons.arrowUp : FIcons.receipt,
              size: 18,
              color: isIncome ? midGreen : primaryGreen,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.displayTitle.isEmpty
                        ? expense.merchantName
                        : expense.displayTitle,
                    style: const TextStyle(
                      color: ink,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    expense.category.isEmpty ? 'general' : expense.category,
                    style: const TextStyle(color: inkMuted, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              isIncome ? '+\$${units.abs()}' : '-\$$units',
              style: TextStyle(
                color: isIncome ? midGreen : ink,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
