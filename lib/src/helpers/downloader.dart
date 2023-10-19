import 'dart:async';

import 'package:flutter/services.dart';
import 'package:http/http.dart';

Future<String> getMarkdownFile(String path) async {
  final nwFile = path.startsWith("http://") || path.startsWith("https://");
  if (!nwFile) {
    try {
      return await rootBundle.loadString(path);
    } on Exception {
      throw "Error loading asset  $path. error: e.toString()";
    }
  } else {
    final uri = Uri.parse(path);
    try {
      Response response = await get(uri).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw "Error Downloading $path. Error code: ${response.statusCode.toString()}";
      }
    } on TimeoutException catch (_) {
      throw "Error Downloading $path. Request timed out";
    } on Exception {
      throw "Error Downloading $path. error: e.toString()";
    }
  }
}
