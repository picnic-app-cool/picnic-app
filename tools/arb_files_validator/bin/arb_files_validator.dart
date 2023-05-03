import 'dart:io';

Future<void> main(List<String> arguments) async {
  var directory = Directory(arguments[0]);
  var arbFiles = directory
      .list() //
      .where((entity) => entity.existsSync() && entity.path.endsWith(".arb"));
  var hasDuplicates = false;
  print("checking arb files validity...");
  await for (final file in arbFiles) {
    print("checking '${file.path}'");
    final duplicates = _findDuplicateKeys(File(file.path).readAsStringSync());
    if (duplicates.isNotEmpty) {
      hasDuplicates = true;
      print("\n## ERROR: duplicates found! [${duplicates.join(",")}]\n");
    }
  }
  if (hasDuplicates) {
    print("duplicates were found in arb file(s) - see logs above\n");
  } else {
    print("no duplicates found, yay! :)");
  }
  exit(hasDuplicates ? 1 : 0);
}

List<String> _findDuplicateKeys(String readAsStringSync) {
  final allElems = _extractStringKeys(readAsStringSync);

  final tempList = <String>[];
  final duplicates = <String>[];
  for (final item in allElems) {
    if (tempList.contains(item)) {
      duplicates.add(item);
    } else {
      tempList.add(item);
    }
  }

  return duplicates;
}

List<String> _extractStringKeys(String json) {
  var temp = json.trim().replaceFirst("{", "").trim();
  temp = temp
      .substring(0, temp.lastIndexOf("}"))
      .replaceAll(RegExp(": \"[^\"]*\""), ": \"\"")
      .split("\n") //
      .map((e) => e.trim())
      .join("")
      .trim();
  var trimmed = temp;

  do {
    temp = trimmed;
    trimmed = _removeNestedObjects(temp);
  } while (trimmed != temp);
  final keys = trimmed
      .split(",")
      .map((e) {
        var match = RegExp("[\\'\\\"](.*?)[\\'\\\"]\\s?:\\s?[\\'\\\"](.*?)[\\'\\\"]").firstMatch(e);
        if ((match?.groupCount ?? 0) >= 2) {
          return match?.group(1)?.trim();
        } else {
          return null;
        }
      })
      .whereType<String>()
      .toList();
  return keys;
}

String _removeNestedObjects(String replaceAll) {
  return replaceAll.replaceAll(RegExp("{[^{}]*}"), "\"\"");
}
