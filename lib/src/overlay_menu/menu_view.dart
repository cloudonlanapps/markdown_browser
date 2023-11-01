import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'menu_item.dart';
import 'menu_visibility.dart';

class MenuView extends ConsumerWidget {
  const MenuView({
    super.key,
    required this.menuItems,
    this.onExitMenuItem,
    this.mainAxisAlignment,
  });

  final List<CLMenuItem> menuItems;
  final CLMenuItem? onExitMenuItem;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = Border(
      bottom: BorderSide(
        color: Theme.of(context).colorScheme.onSurface,
        width: 0.25,
      ),
    );

    return Container(
      decoration: BoxDecoration(
          border: border, color: Theme.of(context).colorScheme.surface),
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          if (onExitMenuItem != null) ...[
            Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CLMenuButton(onExitMenuItem?.insertHook(
                      pre: ref.read(menuVisibilityProvider.notifier).hide))),
            ),
            const VerticalDivider(),
          ],
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: mainAxisAlignment ??
                  ((onExitMenuItem == null)
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end),
              children: [
                ...menuItems
                    .map((e) => CLMenuButton(e.insertHook(pre: () {
                          ref.read(menuVisibilityProvider.notifier).holdMore();
                        })))
                    .toList(),
                CLMenuButton(CLMenuItem("Hide", MdiIcons.close, onTap: () {
                  ref.read(menuVisibilityProvider.notifier).hide();
                }))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
