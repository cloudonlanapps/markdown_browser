import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuVisibiltiyNotifier extends StateNotifier<bool> {
  Timer? timer;
  MenuVisibiltiyNotifier({bool isVisible = true}) : super(true) {
    showWithTimeOut(const Duration(seconds: 10));
  }

  showWithTimeOut(Duration duration) {
    timer?.cancel();
    state = true;
    timer = Timer(duration, () {
      state = false;
    });
  }

  hide() {
    timer?.cancel();
    state = false;
  }

  holdMore() => showWithTimeOut(const Duration(seconds: 10));
  onDispose() {
    timer?.cancel();
  }
}

final menuVisibilityProvider =
    StateNotifierProvider<MenuVisibiltiyNotifier, bool>((ref) {
  throw Exception(
      "menuVisibilityProvider is available only inside the markdown_browser");
});
