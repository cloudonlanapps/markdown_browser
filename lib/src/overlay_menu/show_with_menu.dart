import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'menu_item.dart';
import 'menu_view.dart';
import 'menu_visibility.dart';

class OverlayMenu extends ConsumerWidget {
  const OverlayMenu({
    super.key,
    required this.mainWidget,
    required this.topMenuItems,
    this.topMenuItemSpecial,
  });
  final Widget mainWidget;
  final List<CLMenuItem> topMenuItems;
  final CLMenuItem? topMenuItemSpecial;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        menuVisibilityProvider.overrideWith((ref) {
          ref.onDispose(() {});

          return MenuVisibiltiyNotifier();
        }),
      ],
      child: ShowWithMenu(
        mainWidget: mainWidget,
        menuWidget: MenuView(
          onExitMenuItem: topMenuItemSpecial,
          menuItems: topMenuItems,
        ),
      ),
    );
  }
}

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
  late final SystemUiOverlayStyle? originalOverlayStyle;
  @override
  void initState() {
    // ignore: invalid_use_of_visible_for_testing_member
    originalOverlayStyle = SystemChrome.latestStyle;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).colorScheme.surface, // Set the desired color here
      statusBarIconBrightness:
          Brightness.dark, // Control the color of the icons (light/dark)
    ));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(originalOverlayStyle ??
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, // Set the desired color here
          statusBarIconBrightness:
              Brightness.light, // Control the color of the icons (light/dark)
        ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isVisible = ref.watch(menuVisibilityProvider);
    return SafeArea(
      child: Listener(
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
      ),
    );
  }
}
