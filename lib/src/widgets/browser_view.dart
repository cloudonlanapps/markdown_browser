import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../models/markdown_file.dart';
import '../providers/content.dart';
import '../providers/current_file.dart';
import '../providers/history.dart';
import 'error_view.dart';
import 'markdown_view.dart';
import '../overlay_menu/menu_item.dart';
import '../overlay_menu/show_with_menu.dart';

class BrowserView extends ConsumerWidget {
  const BrowserView({
    super.key,
    required this.onExit,
  });
  final void Function() onExit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MarkDownFile currentFile = ref.watch(currentFileProvider);
    final AsyncValue<String> content =
        ref.watch(markdownFileProvider(currentFile.path));

    return content.when(
        data: (String data) => _BrowserView(
              data: data,
              currentFile: currentFile,
              onExit: onExit,
            ),
        error: (error, _) => ErrorView(
              errorString: error.toString(),
              onExit: onExit,
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class _BrowserView extends ConsumerStatefulWidget {
  const _BrowserView({
    required this.data,
    required this.currentFile,
    required this.onExit,
  });
  final String data;
  final MarkDownFile currentFile;
  final void Function() onExit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BrowserViewState();
}

class _BrowserViewState extends ConsumerState<_BrowserView> {
  final TocController tocController = TocController();
  bool tocVisible = false;

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(historyProvider);
    return OverlayMenu(
      mainWidget: MarkdownView(
          tocController: tocController,
          currentFile: widget.currentFile,
          data: widget.data,
          tocVisible: tocVisible),
      topMenuItemSpecial: CLMenuItem(
        "Exit",
        MdiIcons.arrowLeftBold,
        showTitle: true,
        onTap: () {
          widget.onExit();
        },
      ),
      topMenuItems: [
        CLMenuItem("Previous", MdiIcons.arrowLeft,
            onTap: history.isEmpty
                ? null
                : () {
                    final file = ref.read(historyProvider.notifier).pop();
                    if (file != null) {
                      ref.read(currentFileProvider.notifier).newPage(
                          landingPage: file.landingPage,
                          currentSection: file.currentSection);
                    }
                  }),
        CLMenuItem("Home", MdiIcons.home,
            onTap: history.isEmpty
                ? null
                : () {
                    final home = ref.read(historyProvider.notifier).home();

                    if (home != null && mounted) {
                      ref.read(currentFileProvider.notifier).newPage(
                          landingPage: home.landingPage,
                          currentSection: home.currentSection);
                    }
                  }),
        CLMenuItem("ToC", MdiIcons.tableOfContents, onTap: () {
          setState(() {
            tocVisible = !tocVisible;
          });
        })
      ],
    );
  }
}
