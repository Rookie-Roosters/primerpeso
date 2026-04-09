import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/green_tokens.dart';

// ── Placeholder data models ─────────────────────────────────────────────────

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

class _Account {
  const _Account({
    required this.name,
    required this.balance,
    required this.icon,
    required this.tint,
  });

  final String name;
  final String balance;
  final IconData icon;
  final Color tint;
}

const _categories = [
  _Category(
    name: 'Renta',
    percent: 38,
    amount: r'$5,700',
    icon: FIcons.house,
    bgColor: Color(0xFFE7F5EC),
    accentColor: Color(0xFF2FA366),
  ),
  _Category(
    name: 'Comida',
    percent: 27,
    amount: r'$4,050',
    icon: FIcons.shoppingCart,
    bgColor: Color(0xFFFFF3E0),
    accentColor: Color(0xFFE67E22),
  ),
  _Category(
    name: 'Transporte',
    percent: 18,
    amount: r'$2,700',
    icon: FIcons.car,
    bgColor: Color(0xFFE3F2FD),
    accentColor: Color(0xFF1E88E5),
  ),
  _Category(
    name: 'Otro',
    percent: 17,
    amount: r'$2,550',
    icon: FIcons.ellipsis,
    bgColor: Color(0xFFFCE4EC),
    accentColor: Color(0xFFE91E63),
  ),
];

const _accounts = [
  _Account(
    name: 'Efectivo',
    balance: r'$3,200',
    icon: FIcons.banknote,
    tint: Color(0xFFE7F5EC),
  ),
  _Account(
    name: 'BBVA Débito',
    balance: r'$8,500',
    icon: FIcons.creditCard,
    tint: Color(0xFFE3F2FD),
  ),
  _Account(
    name: 'Nómina',
    balance: r'$3,300',
    icon: FIcons.wallet,
    tint: Color(0xFFFFF3E0),
  ),
];

// ── Screen ──────────────────────────────────────────────────────────────────

/// Cash management home — monthly summary, categories and accounts.
class TrackerScreen extends StatelessWidget {
  const TrackerScreen({super.key});

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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: _MonthSelector(),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: _SummaryCard(),
            ),
            const SizedBox(height: 28),
            const _SectionHeader(title: 'Gastos por categoría', action: 'Ver todos'),
            const SizedBox(height: 12),
            const _CategoriesRow(),
            const SizedBox(height: 28),
            const _SectionHeader(title: 'Cuentas', action: 'Agregar'),
            const SizedBox(height: 12),
            const _AccountsRow(),
            const SizedBox(height: 28),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: _ScanButton(),
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
  const _MonthSelector();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderSubtle),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Abril 2026',
                style: TextStyle(
                  color: ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(width: 6),
              Icon(FIcons.chevronDown, size: 14, color: inkMuted),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Summary card ──────────────────────────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
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
            // Income / Expense row
            Row(
              children: [
                Expanded(
                  child: _FlowTile(
                    label: 'Gastos',
                    amount: r'-$15,000',
                    sub: '8 movimientos',
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
                    amount: r'$18,000',
                    sub: '1 movimiento',
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
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                    const Text(
                      r'$3,000',
                      style: TextStyle(
                        color: ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Ver más',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(FIcons.chevronRight, size: 14, color: primaryGreen),
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
  const _SectionHeader({required this.title, required this.action});

  final String title;
  final String action;

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
          const Spacer(),
          Text(
            action,
            style: const TextStyle(
              color: primaryGreen,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Categories row ────────────────────────────────────────────────────────────

class _CategoriesRow extends StatelessWidget {
  const _CategoriesRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _categories.length,
        separatorBuilder: (context, i) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _CategoryCard(category: _categories[i]),
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

// ── Accounts row ──────────────────────────────────────────────────────────────

class _AccountsRow extends StatelessWidget {
  const _AccountsRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _accounts.length,
        separatorBuilder: (context, i) => const SizedBox(width: 10),
        itemBuilder: (_, i) => _AccountCard(account: _accounts[i]),
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  const _AccountCard({required this.account});

  final _Account account;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderSubtle),
      ),
      child: SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: account.tint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(account.icon, size: 16, color: primaryGreen),
                ),
              ),
              const Spacer(),
              Text(
                account.name,
                style: const TextStyle(
                  color: inkMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                account.balance,
                style: const TextStyle(
                  color: ink,
                  fontSize: 14,
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
  const _ScanButton();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [primaryGreen, midGreen],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FIcons.plus, size: 18, color: surface),
            SizedBox(width: 8),
            Text(
              'Escanear o registrar',
              style: TextStyle(
                color: surface,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
