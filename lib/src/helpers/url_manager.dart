import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as tabs;
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class URLManager {
  final String url;

  URLManager(this.url);

  Future<bool> launch(BuildContext context);

  static URLManager getURLManager({required String url}) {
    URLManager dict;
    if (kIsWeb || io.Platform.isAndroid || io.Platform.isIOS) {
      dict = URLManagerMobile(url);
    } else {
      dict = URLManagerDesktop(url);
    }
    return dict;
  }
}

class URLManagerDesktop extends URLManager {
  URLManagerDesktop(super.url);

  @override
  Future<bool> launch(BuildContext context) async {
    final Uri url = Uri.parse(super.url);

    try {
      if (!await launchUrl(url, webOnlyWindowName: "_self")) {
        throw 'Could not launch $url';
      }
    } on Exception {
      return false;
    }
    return true;
  }
}

class URLManagerMobile extends URLManager {
  URLManagerMobile(super.url);
  @override
  Future<bool> launch(BuildContext context) async {
    try {
      await tabs.launch(
        url,
        customTabsOption: tabs.CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: tabs.CustomTabsSystemAnimation.slideIn(),
        ),
        safariVCOption: tabs.SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: tabs.SafariViewControllerDismissButtonStyle.close,
        ),
      );
      return true;
    } on Exception {
      // An exception is thrown if browser app is not installed on Android device.
      return false;
    }
  }
}
