import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/downloader.dart';

final markdownLoaderProvider =
    StateProvider<Future<String> Function(String path)>((ref) {
  return getMarkdownFile;
});
