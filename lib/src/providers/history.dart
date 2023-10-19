import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/markdown_file.dart';

class HistoryNotifier extends StateNotifier<List<MarkDownFile>> {
  HistoryNotifier() : super([]);

  push(MarkDownFile file) {
    state = [...state, file];
  }

  MarkDownFile? pop() {
    if (state.isNotEmpty) {
      final file = state.last;

      state.removeLast();
      return file;
    }

    return null;
  }

  MarkDownFile? home() {
    if (state.isNotEmpty) {
      final file = state.first;

      state = [];
      return file;
    }

    return null;
  }
}

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<MarkDownFile>>((ref) {
  throw Exception(
      "historyProvider is available only inside the markdown_browser");
});
