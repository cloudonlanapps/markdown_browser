import 'package:flutter/material.dart';

import 'menu_item.dart';

/// An approach to standardize the menu icons usage.
/// Collect all the icons in one place, and name it with label.
/// Use it by overwriding onTap()
class AvailableActions {
  static final Map<String, CLMenuItem> _availableActions = {
    /* "bookmark": CLMenuItem(
        "Bookmark",
        ResponsiveSvgIconData({
          9999: 'assets/bookmark-outline.svg',
        })),
    "share": CLMenuItem(
        "Share",
        ResponsiveSvgIconData({
          9999: 'assets/bookmark-outline.svg',
        })), */
    "back": CLMenuItem("Back", const Icon(Icons.arrow_back)),
    "home": CLMenuItem("Home", Icons.home),
    "search": CLMenuItem("Search", Icons.search),
    "profile": CLMenuItem("Profile", Icons.person),
  };

  static List<CLMenuItem> getActions(List<String> labels) => labels
      .map((e) => _availableActions[e] ?? _availableActions["back"]!)
      .toList();
}

/*
final bottmMenuItems =
        AvailableActions.getActions(["home", "search", "profile"]);
*/