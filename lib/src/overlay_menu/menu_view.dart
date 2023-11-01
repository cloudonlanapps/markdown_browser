import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'menu_item.dart';
import 'menu_visibility.dart';

class MenuView extends ConsumerWidget {
  const MenuView({
    super.key,
    this.menuItems,
    this.menuItemSpecialLeft,
    this.mainAxisAlignment,
    this.closeButton = true,
  });

  final List<CLMenuItem>? menuItems;
  final CLMenuItem? menuItemSpecialLeft;
  final MainAxisAlignment? mainAxisAlignment;
  final bool closeButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if ((menuItems == null) && (menuItemSpecialLeft == null)) {
      throw Exception(
          "Either menuItems or onExitMenuItem or both must be provided");
    }
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          if (menuItemSpecialLeft != null) ...[
            Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: CLMenuButton(menuItemSpecialLeft?.insertHook(
                      pre: ref.read(menuVisibilityProvider.notifier).hide))),
            ),
            const VerticalDivider(),
          ],
          if (closeButton || (menuItems != null))
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: mainAxisAlignment ??
                    ((menuItemSpecialLeft == null)
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.end),
                children: [
                  if (menuItems != null)
                    ...menuItems!
                        .map((e) => CLMenuButton(e.insertHook(pre: () {
                              ref
                                  .read(menuVisibilityProvider.notifier)
                                  .holdMore();
                            })))
                        .toList(),
                  if (closeButton)
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
