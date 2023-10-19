import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/markdown_file.dart';

class CurrentFileNotifier extends StateNotifier<MarkDownFile> {
  final List<MarkDownFile> history = [];
  final Ref ref;

  CurrentFileNotifier(MarkDownFile pageDescriptor, this.ref)
      : super(pageDescriptor);

  void newPage({required String landingPage, String? currentSection}) {
    state =
        state.newPage(landingPage: landingPage, currentSection: currentSection);
  }
}

final currentFileProvider =
    StateNotifierProvider<CurrentFileNotifier, MarkDownFile>((ref) {
  throw Exception(
      "currentFileProvider is available only inside the markdown_browser");
});
