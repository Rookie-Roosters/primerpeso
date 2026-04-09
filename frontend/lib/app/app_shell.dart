import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/green_tokens.dart';
import '../core/theme/typography.dart';
import '../core/ui/gradient_background.dart';

/// Bottom shell: tracker · agent · score.
///
/// Floating pill nav matching the reference: three line icons in a row,
/// no permanent labels. The active tab gets a filled `primaryGreen` square
/// behind the icon and surfaces its label below.
///
/// Each branch screen is responsible for wrapping itself in
/// `WarmGradientBackground` (same convention used by secondary screens that
/// push on top of the root navigator).
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // The gradient lives at the shell level so it extends seamlessly behind
    // the floating nav pill. Branch screens (tracker / chat / score) no
    // longer paint their own gradient — that produced a visible seam where
    // the inner gradient ended above the nav bar.
    return WarmGradientBackground(
      child: Column(
        children: [
          Expanded(child: navigationShell),
          SafeArea(
            top: false,
            child: _NavBar(
              selectedIndex: navigationShell.currentIndex,
              onTap: _goBranch,
            ),
          ),
        ],
      ),
    );
  }

  void _goBranch(int i) => navigationShell.goBranch(
    i,
    initialLocation: i == navigationShell.currentIndex,
  );
}

class _NavBar extends StatelessWidget {
  const _NavBar({required this.selectedIndex, required this.onTap});

  final int selectedIndex;
  final void Function(int) onTap;

  static const _items = <_NavItem>[
    _NavItem(icon: FIcons.wallet, label: 'Dinero'),
    _NavItem(icon: FIcons.bot, label: 'Peso'),
    _NavItem(icon: FIcons.gauge, label: 'Score'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: cardShadowSoft,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < _items.length; i++)
                _NavTab(
                  item: _items[i],
                  selected: i == selectedIndex,
                  onTap: () => onTap(i),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _NavTab extends StatelessWidget {
  const _NavTab({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? primaryGreen : const Color(0x00000000),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 20, color: selected ? surface : inkMuted),
            AnimatedSize(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: selected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        item.label,
                        style: PTypography.label.copyWith(
                          color: surface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
