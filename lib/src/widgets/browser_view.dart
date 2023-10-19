import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../models/markdown_file.dart';
import '../providers/content.dart';
import '../providers/current_file.dart';
import 'error_view.dart';
import 'markdown_view.dart';
import 'menu_view.dart';
import 'show_with_menu.dart';

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

class _BrowserView extends StatefulWidget {
  const _BrowserView({
    required this.data,
    required this.currentFile,
    required this.onExit,
  });
  final String data;
  final MarkDownFile currentFile;
  final void Function() onExit;

  @override
  State<StatefulWidget> createState() => _BrowserViewState();
}

class _BrowserViewState extends State<_BrowserView> {
  final TocController tocController = TocController();
  bool tocVisible = false;
  void onToggleTOCVisible() {
    setState(() {
      tocVisible = !tocVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShowWithMenu(
          mainWidget: MarkdownView(
              tocController: tocController,
              currentFile: widget.currentFile,
              data: widget.data,
              tocVisible: tocVisible),
          menuWidget: MenuView(
            onExit: widget.onExit,
            onToggleTOCVisible: onToggleTOCVisible,
          ),
        ),
      ],
    );
  }
}
