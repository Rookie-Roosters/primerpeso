import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_scope.dart';
import '../../../core/formatting/money_format.dart';
import '../../../core/theme/green_tokens.dart';
import '../../../core/theme/typography.dart';
import '../../../core/ui/gradient_background.dart';
import '../../../core/ui/hero_card.dart';
import '../../../core/ui/screen_header.dart';
import '../../../gen/primerpeso/finance/v1/finance.pb.dart' as financev1;

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarmGradientBackground(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: 'Historial',
              subtitle: 'Movimientos confirmados por Peso',
              leading: _BackButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: AnimatedBuilder(
                animation: AppScope.ledgerRefreshOf(context),
                builder: (context, _) => FutureBuilder<List<financev1.Expense>>(
                  key: ValueKey(AppScope.ledgerRefreshOf(context).revision),
                  future: AppScope.of(context).financeRepository.listExpenses(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: FAlert(
                          variant: FAlertVariant.destructive,
                          title: const Text('No pude cargar el historial'),
                          subtitle: Text(snapshot.error.toString()),
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryGreen),
                      );
                    }
                    final expenses = snapshot.data!;
                    if (expenses.isEmpty) {
                      return Center(
                        child: Text(
                          'Aún no hay movimientos confirmados.',
                          style: PTypography.body.copyWith(color: inkMuted),
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                      itemCount: expenses.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 10),
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

class _ExpenseTile extends StatelessWidget {
  const _ExpenseTile({required this.expense});

  final financev1.Expense expense;

  @override
  Widget build(BuildContext context) {
    final units = expense.amount.units.toInt();
    final isIncome = units < 0;
    final amountText = isIncome
        ? '+${formatMxMoney(units.abs())}'
        : '-${formatMxMoney(units)}';

    return HeroCard.compact(
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: lightGreenTint,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SizedBox(
              width: 44,
              height: 44,
              child: Center(
                child: Icon(
                  isIncome ? FIcons.arrowDownLeft : FIcons.receipt,
                  size: 20,
                  color: primaryGreen,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.displayTitle.isEmpty
                      ? expense.merchantName
                      : expense.displayTitle,
                  style: PTypography.bodyStrong,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  expense.category.isEmpty ? 'general' : expense.category,
                  style: PTypography.label.copyWith(color: inkMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            amountText,
            style: PTypography.bodyStrong.copyWith(
              color: isIncome ? primaryGreen : ink,
            ),
          ),
        ],
      ),
    );
  }
}
