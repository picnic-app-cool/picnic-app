import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  var file = File(".temp");
  if (file.existsSync()) {
    print("deleting temp file...");
    file.deleteSync();
  } else {
    throw ".temp file does not exist";
  }
}
