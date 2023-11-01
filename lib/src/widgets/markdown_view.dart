import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';

import '../helpers/latex.dart';
import '../helpers/url_manager.dart';
import '../models/markdown_file.dart';
import '../providers/current_file.dart';
import '../providers/history.dart';

class MarkdownView extends ConsumerWidget {
  const MarkdownView({
    super.key,
    required this.tocController,
    required this.currentFile,
    required this.data,
    required this.tocVisible,
  });

  final TocController tocController;

  final MarkDownFile currentFile;
  final String data;
  final bool tocVisible;
  Widget buildTocWidget() => TocWidget(controller: tocController);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter, child: buildTocWidget())),
          Expanded(
            flex: tocVisible ? 3 : 150,
            child: buildMarkdownWidget(ref, context),
          ),
        ],
      ),
    );
  }

  MarkdownWidget buildMarkdownWidget(WidgetRef ref, BuildContext context) {
    return MarkdownWidget(
      selectable: true,
      tocController: tocController,
      data: data,
      markdownGenerator: MarkdownGenerator(
          generators: [latexGenerator], inlineSyntaxList: [LatexSyntax()]),
      config: MarkdownConfig(configs: [
        LinkConfig(
          style: const TextStyle(
            color: Colors.red,
            decoration: TextDecoration.underline,
          ),
          onTap: (url) async {
            /* if (context.mounted) {
              ref.read(menuVisibilityProvider.notifier).holdMore();
            } */
            // If the url contains the base url, remove it.
            if (url.startsWith('${currentFile.urlBase}/')) {
              url = url.replaceFirst('${currentFile.urlBase}/', "");
            }

            if (url.startsWith('/')) {
              url.replaceFirst('/', '');
            }
            if (url.startsWith('http://') || url.startsWith('https://')) {
              // External URL, use url launcher
              if (!await URLManager.getURLManager(url: url).launch(context)) {
                throw Exception('Could not launch $url');
              }
              return;
            }

            final split = url.split('#');
            final currentSection = split.length > 1 ? split[1] : null;
            ref.read(historyProvider.notifier).push(currentFile);
            ref
                .read(currentFileProvider.notifier)
                .newPage(landingPage: split[0], currentSection: currentSection);
          },
        )
      ]),
    );
  }
}
