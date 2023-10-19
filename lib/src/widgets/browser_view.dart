import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../models/markdown_file.dart';
import '../providers/content.dart';
import '../providers/current_file.dart';
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
        data: (String data) => _UserDocs(
              data: data,
              currentFile: currentFile,
              onExit: onExit,
            ),
        error: (error, _) => _UserDocs(
              data: error.toString(),
              currentFile: currentFile,
              onExit: onExit,
            ),
        loading: () => const CircularProgressIndicator());
  }
}

class _UserDocs extends StatefulWidget {
  const _UserDocs({
    required this.data,
    required this.currentFile,
    required this.onExit,
  });
  final String data;
  final MarkDownFile currentFile;
  final void Function() onExit;

  @override
  State<StatefulWidget> createState() => _UserDocsState();
}

class _UserDocsState extends State<_UserDocs> {
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
