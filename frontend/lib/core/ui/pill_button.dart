import 'package:flutter/material.dart';

import '../theme/green_tokens.dart';
import '../theme/typography.dart';

enum _PillVariant { primary, surface }

/// Stadium-shaped tap target shared across the revamped UI.
///
/// Three flavors:
///   * [PillButton.primary] — filled `primaryGreen`, white label.
///     Used for the main CTA on every screen ("Comenzar", "Confirmar gasto",
///     "Escanear o registrar", etc.).
///   * [PillButton.surface] — white surface with a subtle border, ink label.
///     Used for secondary actions and chat suggestion chips.
///   * [PillButton.icon] — circular 44×44, icon-only. Used for chat composer
///     attach/send and inline header actions.
class PillButton extends StatelessWidget {
  const PillButton.primary({
    required this.label,
    this.icon,
    this.trailing,
    this.onPressed,
    this.busy = false,
    this.expand = true,
    super.key,
  }) : _variant = _PillVariant.primary;

  const PillButton.surface({
    required this.label,
    this.icon,
    this.trailing,
    this.onPressed,
    this.busy = false,
    this.expand = false,
    super.key,
  }) : _variant = _PillVariant.surface;

  final String label;
  final IconData? icon;
  final IconData? trailing;
  final VoidCallback? onPressed;
  final bool busy;
  final bool expand;
  final _PillVariant _variant;

  @override
  Widget build(BuildContext context) {
    final isPrimary = _variant == _PillVariant.primary;
    final enabled = !busy && onPressed != null;

    final background = isPrimary ? primaryGreen : surface;
    final foreground = isPrimary ? surface : ink;
    final borderColor = isPrimary ? null : borderSubtle;

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (busy)
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(foreground),
            ),
          )
        else if (icon != null)
          Icon(icon, size: 18, color: foreground),
        if ((busy || icon != null)) const SizedBox(width: 10),
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: PTypography.bodyStrong.copyWith(color: foreground),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          Icon(trailing, size: 16, color: foreground),
        ],
      ],
    );

    return Opacity(
      opacity: enabled ? 1 : 0.55,
      child: GestureDetector(
        onTap: enabled ? onPressed : null,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(999),
            border: borderColor != null
                ? Border.all(color: borderColor, width: 1.2)
                : null,
            boxShadow: isPrimary
                ? const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: content,
          ),
        ),
      ),
    );
  }
}

/// Round 44×44 icon-only button used by the chat composer (attach, send)
/// and other compact actions.
class PillIconButton extends StatelessWidget {
  const PillIconButton({
    required this.icon,
    required this.onPressed,
    this.filled = false,
    this.busy = false,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final enabled = !busy && onPressed != null;
    final background = filled
        ? (enabled ? primaryGreen : warmSurface)
        : (enabled ? surface : warmSurface);
    final foreground = filled
        ? (enabled ? surface : inkMuted)
        : (enabled ? ink : inkMuted);
    final border = filled ? null : Border.all(color: borderSubtle, width: 1.2);

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: border,
          boxShadow: filled && enabled
              ? const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: busy
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(foreground),
                  ),
                )
              : Icon(icon, size: 18, color: foreground),
        ),
      ),
    );
  }
}
