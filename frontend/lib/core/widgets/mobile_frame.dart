import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/widgets.dart';

import '../theme/green_tokens.dart';

/// On Android (or web at narrow widths) this is a transparent passthrough.
///
/// On the web build at widths above [mobileFrameBreakpoint] it centers a
/// fixed [mobileFrameSize] canvas with a soft drop shadow on a neutral page
/// background, so the mobile-first UI does not stretch on desktop browsers.
class MobileFrame extends StatelessWidget {
  const MobileFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return child;
    }
    final width = MediaQuery.sizeOf(context).width;
    if (width <= mobileFrameBreakpoint) {
      return child;
    }
    return ColoredBox(
      color: const Color(0xFFEEF1F0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(36),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x33000000),
                  blurRadius: 40,
                  spreadRadius: 2,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: SizedBox(
              width: mobileFrameSize.width,
              height: mobileFrameSize.height,
              child: ColoredBox(color: warmSurface, child: child),
            ),
          ),
        ),
      ),
    );
  }
}
