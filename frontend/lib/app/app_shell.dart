import 'package:flutter/widgets.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/green_tokens.dart';

/// Bottom shell: tracker · agent (center) · score.
///
/// A floating pill‐style bottom bar gives each branch a distinct selection
/// state; the center "Peso" tab uses a raised green tile to stay permanently
/// prominent regardless of selection.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: warmSurface,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(child: navigationShell),
            _NavBar(
              selectedIndex: navigationShell.currentIndex,
              onTap: _goBranch,
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: warmSurface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _SideTab(
                  icon: FIcons.wallet,
                  label: 'Tu dinero',
                  selected: selectedIndex == 0,
                  onTap: () => onTap(0),
                ),
              ),
              _CenterTab(selected: selectedIndex == 1, onTap: () => onTap(1)),
              Expanded(
                child: _SideTab(
                  icon: FIcons.gauge,
                  label: 'Score',
                  selected: selectedIndex == 2,
                  onTap: () => onTap(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideTab extends StatelessWidget {
  const _SideTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? lightGreenTint : const Color(0x00000000),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: selected ? primaryGreen : inkMuted,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: selected ? primaryGreen : inkMuted,
                letterSpacing: -0.1,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterTab extends StatelessWidget {
  const _CenterTab({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              width: 56,
              height: 42,
              decoration: BoxDecoration(
                color: selected ? primaryGreen : const Color(0xFFF0F4F2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  FIcons.bot,
                  size: 22,
                  color: selected ? surface : inkMuted,
                ),
              ),
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? primaryGreen : inkMuted,
                letterSpacing: -0.1,
              ),
              child: const Text('Peso'),
            ),
          ],
        ),
      ),
    );
  }
}
