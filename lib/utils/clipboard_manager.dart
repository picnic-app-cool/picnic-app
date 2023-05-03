import 'package:flutter/services.dart';

class ClipboardManager {
  Future<String> getText() async {
    final data = await Clipboard.getData("text/plain");
    return data?.text ?? '';
  }

  Future<void> saveText(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
