// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'custom_icon.dart';

class CLMenuItem {
  final String title;
  final dynamic iconData;
  final bool showTitle;
  final void Function()? onTap;
  CLMenuItem(this.title, this.iconData, {this.onTap, this.showTitle = true});

  CLMenuItem copyWith({
    bool? showTitle,
    void Function()? onTap,
  }) {
    return CLMenuItem(
      title,
      iconData,
      showTitle: showTitle ?? this.showTitle,
      onTap: onTap ?? this.onTap,
    );
  }

  insertHook({
    Function()? pre,
    Function()? post,
  }) {
    if (onTap != null) {
      return copyWith(onTap: () {
        pre?.call();
        onTap?.call();
        post?.call();
      });
    }
    return this;
  }
}

class CLMenuButton extends StatelessWidget {
  final CLMenuItem menuItem;
  const CLMenuButton(
    this.menuItem, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromARGB(128, 255, 0, 0),
      onTap: menuItem.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomIcon(
              menuItem.iconData,
              size: 20,
              color:
                  menuItem.onTap == null ? Colors.grey.shade300 : Colors.black,
            ),
            if (menuItem.showTitle)
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: Text(
                  menuItem.title,
                  style: TextStyle(
                      color: menuItem.onTap == null
                          ? Colors.grey.shade300
                          : Colors.black,
                      fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
