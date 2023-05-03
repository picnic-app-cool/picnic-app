import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path_lib;
import 'package:template_utils/feature_templates.dart';
import 'package:template_utils/template_utils.dart';

extension FileUtils on File {
  String get fileNameWithExtension => path.fileNameWithExtension;

  String get fileNameWithoutExtension => path.fileNameWithoutExtension;

  String relativePathTo(String path) => this.absolute.path.relativePathTo(path);
}

/// all dart files in lib and test directories
Stream<File> allProjectDartFiles({required String rootDir}) {
  return StreamGroup.merge([
    allFilesInDir(rootDir.libDir),
    allFilesInDir(rootDir.testDir),
  ]).where((event) => event.path.endsWith(".dart"));
}

/// all files in given [path] and subdirectories
Stream<File> allFilesInDir(String path) {
  return Directory(path)
      .list(recursive: true) //
      .where((event) => event is File)
      .map((event) => event as File);
}

extension StringUtils on String {
  String get fileNameWithExtension => substring(lastIndexOf(Platform.pathSeparator) + 1);

  String get fileNameWithoutExtension => fileNameWithExtension.removedFileExtension;

  String suffixed(String suffix) {
    if (endsWith(suffix)) {
      return this;
    } else {
      return "${this}$suffix";
    }
  }

  String prefixed(String prefix) {
    if (startsWith(prefix)) {
      return this;
    } else {
      return "$prefix${this}";
    }
  }

  String importPath(String rootPath, {required String appPackage}) {
    if (contains(rootPath.libDir)) {
      return "$appPackage/${rootPath.libDir.relativePathTo(this)}";
    } else if (contains(rootPath.testDir)) {
      return "$appPackage/${rootPath.testDir.relativePathTo(this)}";
    } else {
      throw "'$this' is not inside either lib(${rootPath.libDir}) or test(${rootPath.testDir}) folder";
    }
  }

  String get classNameFromFile => File(this).fileNameWithoutExtension.pascalCase;

  String get libDir => path_lib.absolute(path_lib.join(projectRootDir(this), "lib"));

  String get testDir => path_lib.absolute(path_lib.join(projectRootDir(this), "test"));

  String get removedFileExtension => substring(0, lastIndexOf("."));

  String get featureName {
    var absolute = path_lib.absolute(this);
    return absolute.contains("lib/features") ? RegExp("lib/features/(.+?)/").firstMatch(absolute)?.group(1) ?? "" : "";
  }

  String relativePathTo(String path) {
    return path_lib.relative(path, from: this);
  }
}

extension DartFilesInDir on Directory {
  Stream<File> get allDartFiles =>
      this.list(recursive: true).where((it) => it is File && it.path.endsWith(".dart")).map((event) => event as File);
}

String featureComponentFilePath({
  required String? feature,
  required String rootDir,
}) =>
    ((feature?.isEmpty ?? true) || feature == 'core') //
        ? '$rootDir/lib/dependency_injection/app_component.dart'
        : '$rootDir/lib/features/$feature/dependency_injection/feature_component.dart';

String mockDefinitionsFilePath({
  required String? feature,
  required String rootDir,
}) =>
    ((feature?.isEmpty ?? true) || feature == 'core') //
        ? '$rootDir/test/mocks/mock_definitions.dart'
        : '$rootDir/test/features/$feature/mocks/${feature}_mock_definitions.dart';

String mocksFilePath({
  required String? feature,
  required String rootDir,
}) =>
    ((feature?.isEmpty ?? true) || feature == 'core') //
        ? '$rootDir/test/mocks/mocks.dart'
        : '$rootDir/test/features/$feature/mocks/${feature}_mocks.dart';

String pagesTestConfigPath(String feature) => 'test/features/$feature/pages/flutter_test_config.dart';

/// makes sure the feature-specific getIt registration index file is created,
/// if its not, creates one and registers in master `app_component.dart` file
Future<void> ensureFeatureComponentFile({
  required String appPackage,
  required String? feature,
  required String rootDir,
}) async {
  var featurePath = featureComponentFilePath(feature: feature, rootDir: rootDir);
  var filePackage = featurePath.replaceAll("$rootDir/lib/features/", "");
  final featureFile = File(featurePath);
  final coreFile = File(featureComponentFilePath(rootDir: rootDir, feature: null));
  if (!await featureFile.exists()) {
    await featureFile.create(recursive: true);
    await writeToFile(filePath: featureFile.path, text: featureComponentTemplate(appPackage));
    await replaceAllInFileLineByLine(
      filePath: coreFile.path,
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE APP_COMPONENT_IMPORTS",
          text: "${templateImport("$appPackage/features/$filePackage", as: feature ?? '')}",
        ),
      ],
    );
    await replaceAllInFileLineByLine(
      filePath: coreFile.path,
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE FEATURE_COMPONENT_INIT",
          text: "$feature.configureDependencies();",
        ),
      ],
    );
  }
}

Future<void> ensureFeaturesFiles({
  required String appPackage,
  required String featureName,
  required String rootDir,
}) async {
  await ensureFeatureComponentFile(appPackage: appPackage, feature: featureName, rootDir: rootDir);
  await ensureMockDefinitionsFile(feature: featureName, rootDir: rootDir);
  await ensureMocksFile(feature: featureName, rootDir: rootDir);
}

/// makes sure the feature-specific mock definitions file is created, if its not, creates one
Future<void> ensureMockDefinitionsFile({
  HookContext? context,
  required String? feature,
  required String rootDir,
}) async {
  var featurePath = mockDefinitionsFilePath(feature: feature, rootDir: rootDir);
  final featureFile = File(featurePath).absolute;
  final coreFile = File(mockDefinitionsFilePath(feature: null, rootDir: rootDir)).absolute;
  context?.logger.write("feature mocks file: ${featureFile.path}");
  context?.logger.write("core file: ${coreFile.path}");
  if (!await featureFile.exists()) {
    await featureFile.create(recursive: true);
    await writeToFile(filePath: featureFile.path, text: featureMockDefinitionsTemplate);
  }
}

/// makes sure the feature-specific mocks file is created,
/// if its not, creates one and registers in master `mocks.dart` file
Future<void> ensureMocksFile({
  required String? feature,
  required String rootDir,
  HookContext? context,
}) async {
  var featurePath = mocksFilePath(feature: feature, rootDir: rootDir);
  var filePackage = featurePath.replaceAll("$rootDir/test/", "../");
  final featureFile = File(featurePath);
  final coreFile = File(mocksFilePath(feature: null, rootDir: rootDir));
  await _ensurePageTestConfigFile(rootDir, feature);
  if (!await featureFile.exists()) {
    await featureFile.create(recursive: true);
    await writeToFile(filePath: featureFile.path, text: featureMocksTemplate(feature!));
    await replaceAllInFileLineByLine(
      filePath: coreFile.path,
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE IMPORTS_MOCKS",
          text: templateImport(filePackage, relative: true),
        ),
      ],
    );
    await replaceAllInFileLineByLine(
      filePath: coreFile.path,
      replacements: [
        StringReplacement.prepend(
          before: "//DO-NOT-REMOVE FEATURE_MOCKS_INIT",
          text: "${feature.pascalCase}Mocks.init();",
        ),
      ],
    );
  }
}

Future<void> _ensurePageTestConfigFile(String rootDir, String? feature) async {
  if (feature == null || feature.isEmpty) {
    return;
  }
  final testConfigFile = File(path_lib.join(rootDir, pagesTestConfigPath(feature))).absolute;

  final exists = await testConfigFile.exists();
  if (!exists) {
    await testConfigFile.create(recursive: true);
    await writeToFile(filePath: testConfigFile.path, text: featurePageTestConfigTemplate);
  }
}

/// Replaces given text in file reading it at once and not line-by-line. this allows for multiline regexes to match
Future<void> replaceAllInFileAtOnce({
  required String filePath,
  required List<StringReplacement> replacements,
}) async {
  final tmpFilePath = "${filePath}_write_.tmp";
  final tmpFile = File(tmpFilePath);

  IOSink? writeSink;
  try {
    var fileContents = await File(filePath).readAsString();
    writeSink = tmpFile.openWrite();
    final foundReplacementsMap = Map.fromEntries(replacements.map((e) => MapEntry(e, false)));
    for (final rep in replacements) {
      if (fileContents.contains(rep.from)) {
        foundReplacementsMap[rep] = true;
        fileContents = fileContents.replaceAllMapped(rep.from, rep.to);
      }
    }
    writeSink.write(fileContents);
    final notFoundReplacements =
        foundReplacementsMap.entries.where((element) => element.key.failIfNotFound && !element.value);
    if (notFoundReplacements.isNotEmpty) {
      var notFoundReplacementsList = foundReplacementsMap.entries.map((entry) => entry.key.from).join("\n");
      throw "couldn't find following replacements: $notFoundReplacementsList\n in file: $filePath";
    }
  } catch (ex) {
    tmpFile.deleteSync();
    rethrow;
  } finally {
    await writeSink?.close();
  }

  await tmpFile.rename(filePath);
}

/// performs multiple replacements in single file, convenient method so that you dont have to read file
/// multiple times to perform replacements.
///
/// replacements are performed line-by-line in the order they were specified in the list
///
/// IMPORTANT: Does not support multiline replacements as all replacements are applied on per-line basis
Future<void> replaceAllInFileLineByLine({
  required String filePath,
  required List<StringReplacement> replacements,
}) async {
  final tmpFilePath = "${filePath}_write_.tmp";
  final tmpFile = File(tmpFilePath);

  IOSink? writeSink;
  try {
    final readStream = readFileLines(filePath);
    writeSink = tmpFile.openWrite();
    final foundReplacementsMap = Map.fromEntries(replacements.map((e) => MapEntry(e, false)));
    await for (final line in readStream) {
      var newLine = line;
      for (final rep in replacements) {
        if (line.contains(rep.from)) {
          foundReplacementsMap[rep] = true;
          newLine = newLine.replaceAllMapped(rep.from, rep.to);
        }
      }
      writeSink.writeln(newLine);
    }
    final notFoundReplacements =
        foundReplacementsMap.entries.where((element) => element.key.failIfNotFound && !element.value);
    if (notFoundReplacements.isNotEmpty) {
      var notFoundReplacementsList = foundReplacementsMap.entries.map((entry) => entry.key.from).join("\n");
      throw "couldn't find following replacements: $notFoundReplacementsList\n in file: $filePath";
    }
  } catch (ex) {
    tmpFile.deleteSync();
    rethrow;
  } finally {
    await writeSink?.close();
  }

  await tmpFile.rename(filePath);
}

Future<void> writeToFile({
  required String filePath,
  required String text,
}) async {
  final tmpFilePath = "${filePath}_write_.tmp";
  final tmpFile = File(tmpFilePath);

  try {
    await tmpFile.writeAsString(text);
  } catch (ex) {
    tmpFile.deleteSync();
    rethrow;
  }

  await tmpFile.rename(filePath);
}

Stream<String> readFileLines(String path) =>
    File(path).openRead().transform(utf8.decoder).transform(const LineSplitter());

class StringReplacement {
  final Pattern from;
  final String Function(Match match) to;
  final bool failIfNotFound;

  const StringReplacement({
    required this.from,
    required this.to,
    this.failIfNotFound = true,
  });

  factory StringReplacement.string({
    required Pattern from,
    required String to,
    bool failIfNotFound = true,
  }) {
    return StringReplacement(
      from: from,
      to: (_) => to,
      failIfNotFound: failIfNotFound,
    );
  }

  factory StringReplacement.prepend({
    required Pattern before,
    required String text,
    bool failIfNotFound = true,
  }) {
    return StringReplacement(
      from: before,
      to: (_) => "$text\n$before",
      failIfNotFound: failIfNotFound,
    );
  }

  factory StringReplacement.append({
    required Pattern after,
    required String text,
    bool failIfNotFound = true,
  }) {
    return StringReplacement(
      from: after,
      to: (_) => "$after\n$text",
      failIfNotFound: failIfNotFound,
    );
  }
}

/// normalizes root dir of the project specified by [path]
String projectRootDir(String? path) {
  if (path == null) {
    throw "Path to project\'s root dir must be specified";
  }
  var absolutePath = path_lib.absolute(path);
  var directory = Directory(absolutePath);
  if (!directory.existsSync()) {
    throw "Path '$absolutePath' does not exist!";
  }
  return absolutePath;
}

/// returns relative path to the [rootDirPath] from Current working directory
String relativeRootDir(String rootDirPath) {
  return Directory.current.path.relativePathTo(rootDirPath);
}

/// retrieves app package by reading pubspec.yaml in the [rootPath]
Future<String> getAppPackage(String rootPath, {String pubspecFileName = "pubspec.yaml"}) async {
  var pubspecPath = "$rootPath${Platform.pathSeparator}$pubspecFileName";
  await for (final line in readFileLines(pubspecPath)) {
    var regExp = RegExp(r"\s*name:\s*(.*)");
    if (regExp.hasMatch(line)) {
      return regExp.firstMatch(line)![1]!.trim();
    }
  }
  throw "Could not find `name: .*` text in $pubspecPath";
}
