import 'package:flutter/material.dart';

enum AnimateFrom {
  top,
  bottom,
  left,
  right,
}

class MenuAnimator extends StatelessWidget {
  const MenuAnimator({
    super.key,
    required this.animationController,
    this.isVisible = true,
    required this.animateFrom,
    required this.child,
    this.curve,
    this.backgroundColor,
    this.border,
  });

  final AnimationController animationController;
  final bool isVisible;
  final AnimateFrom animateFrom;
  final Widget child;
  final Curve? curve;
  final Color? backgroundColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final endOffset = switch (animateFrom) {
      AnimateFrom.top => const Offset(0.0, -1.0),
      AnimateFrom.bottom => const Offset(0.0, 1.0),
      AnimateFrom.left => const Offset(-1.0, 0.0),
      AnimateFrom.right => const Offset(1.0, 0.0),
    };
    final borderSide = switch (animateFrom) {
      AnimateFrom.top => Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
      AnimateFrom.bottom => Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
      AnimateFrom.left => Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
      AnimateFrom.right => Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
    };

    return SlideTransition(
      position: Tween<Offset>(
        begin: endOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animationController,
        curve: curve ?? Curves.easeInOut,
      )),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surface,
          border: border ?? borderSide,
        ),
        child: child,
      ),
    );
  }
}
