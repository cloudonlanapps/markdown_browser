import 'package:flutter/material.dart';

enum MenuBarPosition {
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
  final MenuBarPosition animateFrom;
  final Widget child;
  final Curve? curve;
  final Color? backgroundColor;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    final endOffset = switch (animateFrom) {
      MenuBarPosition.top => const Offset(0.0, -1.0),
      MenuBarPosition.bottom => const Offset(0.0, 1.0),
      MenuBarPosition.left => const Offset(-1.0, 0.0),
      MenuBarPosition.right => const Offset(1.0, 0.0),
    };
    final borderSide = switch (animateFrom) {
      MenuBarPosition.top => Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
      MenuBarPosition.bottom => Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
      MenuBarPosition.left => Border(
          right: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
      MenuBarPosition.right => Border(
          left: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 0.25,
          ),
        ),
    };

    return SlideTransition(
      position: Tween<Offset>(
        end: endOffset,
        begin: Offset.zero,
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
