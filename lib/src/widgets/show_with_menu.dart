import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/menu_visibility.dart';

class ShowWithMenu extends ConsumerStatefulWidget {
  final Widget mainWidget;
  final Widget menuWidget;

  const ShowWithMenu({
    super.key,
    required this.mainWidget,
    required this.menuWidget,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShowMarkdownState();
}

class _ShowMarkdownState extends ConsumerState<ShowWithMenu> {
  @override
  Widget build(BuildContext context) {
    final bool isVisible = ref.watch(menuVisibilityProvider);
    return Listener(
      onPointerSignal: (PointerSignalEvent pointerSignal) {
        if (pointerSignal is PointerScrollEvent) {
          // do something when scrolled

          if (pointerSignal.scrollDelta.dy < 0.0) {
            if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).holdMore();
            }
          } else {
            if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).hide();
            }
          }
        }
      },
      onPointerMove: (event) {
        if (event.delta.dy > 0) {
          if (context.mounted) {
            ref.read(menuVisibilityProvider.notifier).holdMore();
          }
        } else if (event.delta.dy < 0) {
          if (context.mounted) {
            ref.read(menuVisibilityProvider.notifier).hide();
          }
        }
      },
      child: Stack(
        children: [
          widget.mainWidget,
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(seconds: 1),
              child: widget.menuWidget,
            ),
          )
        ],
      ),
    );
  }
}
