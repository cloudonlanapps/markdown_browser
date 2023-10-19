import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/markdown_file.dart';
import 'providers/current_file.dart';
import 'providers/downloader.dart';
import 'providers/history.dart';
import 'providers/menu_visibility.dart';
import 'widgets/browser_view.dart';

class MarkdownBrowser extends StatelessWidget {
  const MarkdownBrowser({
    super.key,
    required this.urlBase,
    this.landingPage,
    this.onGetMarkDownCB,
    required this.onExitCB,
  });

  final String urlBase;
  final String? landingPage;
  final Future<String> Function(String path)? onGetMarkDownCB;
  final void Function() onExitCB;

  @override
  Widget build(BuildContext context) {
    final MarkDownFile pageDescriptor =
        MarkDownFile(urlBase: urlBase, landingPage: landingPage ?? "index.md");
    return ProviderScope(
      overrides: [
        menuVisibilityProvider.overrideWith((ref) => MenuVisibiltiyNotifier()),
        currentFileProvider
            .overrideWith((ref) => CurrentFileNotifier(pageDescriptor, ref)),
        if (onGetMarkDownCB != null)
          markdownLoaderProvider.overrideWith((ref) => onGetMarkDownCB!),
        historyProvider.overrideWith((ref) => HistoryNotifier()),
        menuVisibilityProvider.overrideWith((ref) => MenuVisibiltiyNotifier())
      ],
      child: BrowserView(
        onExit: onExitCB,
      ),
    );
  }
}
