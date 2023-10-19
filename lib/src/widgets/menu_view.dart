import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../providers/current_file.dart';
import '../providers/history.dart';
import '../providers/menu_visibility.dart';

class MenuView extends ConsumerWidget {
  const MenuView({
    super.key,
    required this.onExit,
    required this.onToggleTOCVisible,
  });

  final void Function() onExit;
  final void Function() onToggleTOCVisible;

  gotoHomePage(WidgetRef ref) {
    ref.read(menuVisibilityProvider.notifier).holdMore();

    final home = ref.read(historyProvider.notifier).home();

    if (home != null) {
      ref.read(currentFileProvider.notifier).newPage(
          landingPage: home.landingPage, currentSection: home.currentSection);
    }
  }

  gotoPreviousPage(WidgetRef ref) {
    ref.read(menuVisibilityProvider.notifier).holdMore();

    final file = ref.read(historyProvider.notifier).pop();
    if (file != null) {
      ref.read(currentFileProvider.notifier).newPage(
          landingPage: file.landingPage, currentSection: file.currentSection);
    }
  }

  toggleTOC(WidgetRef ref) {
    ref.read(menuVisibilityProvider.notifier).holdMore();

    onToggleTOCVisible();
  }

  forceHideMenu(WidgetRef ref) {
    ref.read(menuVisibilityProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(historyProvider);

    return Container(
      color: Theme.of(context).colorScheme.surface.withAlpha(128),
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  ref.read(menuVisibilityProvider.notifier).hide();
                  onExit();
                },
                child: Transform.rotate(
                  angle: 3.14,
                  child: Icon(
                    MdiIcons.exitToApp,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:
                        (history.isEmpty) ? null : () => gotoPreviousPage(ref),
                    child: history.isEmpty
                        ? Container()
                        : Icon(
                            MdiIcons.arrowLeft,
                          )),
                GestureDetector(
                    onTap: () => toggleTOC(ref),
                    child: Icon(MdiIcons.tableOfContents)),
                GestureDetector(
                    onTap: () => gotoHomePage(ref), child: Icon(MdiIcons.home)),
                GestureDetector(
                  onTap: () => forceHideMenu(ref),
                  child: Icon(MdiIcons.close),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
