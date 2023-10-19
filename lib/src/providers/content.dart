import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'downloader.dart';

final markdownFileProvider =
    FutureProvider.family<String, String>((ref, path) async {
  final downloader = ref.watch(markdownLoaderProvider);
  return downloader(path);
});
