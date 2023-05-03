import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:recase/recase.dart';

import '../utils/lint_codes.dart';
import '../utils/lint_utils.dart';

/// checks if domain entity class has only one public member (class,enum, mixin etc.)
class DomainEntityTooManyPublicMembersLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    final library = unit.libraryElement;
    if (!library.isDomainEntityFile || library.isFailureFile) {
      return;
    }
    final entitiesPublicMembers = library.topLevelElements.whereType<ClassElement>().where(
          (it) => [
            !it.name.endsWith("Failure"),
            it.isPublic,
            !library.source.shortName.startsWith(it.name.snakeCase),
          ].every((it) => it),
        );

    for (final clazz in entitiesPublicMembers) {
      yield Lint(
        code: LintCodes.tooManyPublicMembers,
        message: "Domain entity's file contains more than one public top level element "
            "or the element does not match the file name precisely: ${clazz.name}",
        location: clazz.nameLintLocation!,
        severity: LintSeverity.error,
        correction: "extract ${clazz.name} to separate file",
      );
    }
  }
}
