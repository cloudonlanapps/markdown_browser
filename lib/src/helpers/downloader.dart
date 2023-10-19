import 'dart:async';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

Future<String> getMarkdownFile(String path) async {
  final nwFile = path.startsWith("http://") || path.startsWith("https://");
  if (!nwFile) {
    try {
      return await rootBundle.loadString(path);
    } on Exception {
      throw Exception("Error loading asset  $path.\nCheck if file exists.");
    }
  } else {
    final uri = Uri.parse(path);

    Response response = await get(uri).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Error Downloading $path.\nError code: ${response.statusCode.toString()}."
          "\nCheck if the server is reachable\nand the file exists");
    }
  }
}
