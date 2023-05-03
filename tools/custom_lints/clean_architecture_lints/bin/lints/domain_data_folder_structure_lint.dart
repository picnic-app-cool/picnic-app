import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks if domain and data folders are in proper subfolders:
/// lib/core/domain/ - ✅
/// lib/core/data/ - ✅
/// lib/features/circles/domain - ✅
/// lib/features/circles/data - ✅
/// lib/features/circles/settings/domain - 🛑 - because its not drectly in given feature's folder
/// lib/features/circles/settings/data - 🛑 - because its not drectly in given feature's folder
/// lib/core/domain/entity -🛑 - because we have all the lints assume that domain entities are in domain/model
/// lib/core/domain/entities -🛑 - because we have all the lints assume that domain entities are in domain/model
class DomainDataFolderStructureLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainFile && !library.isDataFile) {
      return;
    }
    if (library.topLevelElementNames.any((it) => it.contains('Repository') && !it.endsWith('Repository'))) {
      yield Lint(
        code: LintCodes.invalidName,
        message: 'repositories should not use suffixes in their names but prefixes, '
            '(i.e: GraphQlUsersRepository, not `UsersRepositoryGql',
        location: unit.lintLocationFromLines(startLine: 1, endLine: 1),
        severity: LintSeverity.error,
        correction: "use prefix in the name instead",
      );
    }
    final invalidModelPathMatch = RegExp(r"domain\/(entity|entities)").firstMatch(library.source.fullName);
    if (invalidModelPathMatch != null) {
      yield Lint(
        code: LintCodes.missingCopyWithMethod,
        message: 'domain models should be in `domain/model` and not in `${invalidModelPathMatch[0]}',
        location: unit.lintLocationFromLines(startLine: 1, endLine: 1),
        severity: LintSeverity.error,
        correction: "move all the file to `domain/model` instead",
      );
      return;
    }

    final validRepositoryPath = library.source.fullName.endsWith("domain/repositories/${library.source.shortName}");
    if (library.repositoriesInterfaces.isNotEmpty && !validRepositoryPath) {
      yield Lint(
        code: LintCodes.invalidFolderStructure,
        message: 'repository interfaces should lay inside `domain/repositories folder',
        location: unit.lintLocationFromLines(startLine: 1, endLine: 1),
        severity: LintSeverity.error,
        correction: "move all the file to `domain/repositories` instead",
      );
      return;
    }

    final removedPrefix =
        library.source.fullName.replaceAll(RegExp(r"^.*lib\/(?:features\/.+?(?=\/)|core)\/(?:domain|data)?"), "");
    if (removedPrefix == library.source.fullName) {
      print("NOT PREFIX: $removedPrefix");
      return;
    }
    if (RegExp(r".*\/(domain|data)\/.*").hasMatch(removedPrefix)) {
      yield Lint(
        code: LintCodes.missingCopyWithMethod,
        message:
            'domain and data folders can only be directly inside `lib/core/` or `lib/features/\$featureName/` and not nested any further down',
        location: unit.lintLocationFromLines(startLine: 1, endLine: 1),
        severity: LintSeverity.error,
        correction:
            "move the folder directly under the `lib/core` or `lib/features/\$featureName` without any subfolders inbetween",
      );
    }
  }
}
