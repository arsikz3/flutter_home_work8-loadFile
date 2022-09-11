import 'package:flutter/services.dart';

Future<String> readFile(String assetsPath) async {
  try {
    final file = await rootBundle.loadString(assetsPath);
    return file.toString();
  } catch (_) {
    return 'Файл не найден!';
  }
}
