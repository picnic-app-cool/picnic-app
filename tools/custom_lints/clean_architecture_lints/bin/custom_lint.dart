import 'dart:isolate';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

import 'lints/domain_data_folder_structure_lint.dart';
import 'lints/domain_entity_json.dart';
import 'lints/domain_entity_missing_copy_with_method_lint.dart';
import 'lints/domain_entity_missing_empty_constructor_lint.dart';
import 'lints/domain_entity_missing_equatable_lint.dart';
import 'lints/domain_entity_missing_props_items_lint.dart';
import 'lints/domain_entity_non_final_fields_lint.dart';
import 'lints/domain_entity_nullable_fields_lint.dart';
import 'lints/domain_entity_too_many_public_members_lint.dart';
import 'lints/dont_use_datetime_now_lint.dart';
import 'lints/forbidden_import_in_domain_lint.dart';
import 'lints/forbidden_import_in_presentation_lint.dart';
import 'lints/invalid_naming_lint.dart';
import 'lints/page_too_many_widgets.dart';
import 'lints/presentation_model_non_final_field_lint.dart';
import 'lints/presentation_model_structure_lint.dart';
import 'lints/use_case_multiple_accessors_lint.dart';

void main(List<String> args, SendPort sendPort) {
  startPlugin(sendPort, _IndexPlugin());
}

class _IndexPlugin extends PluginBase {
  final lints = [
    DomainEntityJsonLint(),
    InvalidNamingLint(),
    ForbiddenImportInPresentationLint(),
    ForbiddenImportInDomainLint(),
    PresentationModelNonFinalFieldLint(),
    DomainEntityNonFinalFields(),
    UseCaseMultipleAccessorsLint(),
    DomainEntityMissingCopyWithMethodLint(),
    DomainEntityMissingEquatableLint(),
    DomainEntityNullableFieldsLint(),
    DomainEntityMissingPropsItemsLint(),
    DomainEntityMissingEmptyConstructorLint(),
    DomainEntityTooManyPublicMembersLint(),
    DomainDataFolderStructureLint(),
    PageTooManyWidgetsLint(),
    DontUseDateTimeNowLint(),
    PresentationModelStructureLint(),
  ];

  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    if (unit.path.contains(".symlinks") || unit.path.contains(".fvm")) {
      //hack to make intellij not report problems in fvm and symlinks subdirs
      return;
    }
    for (final lint in lints) {
      yield* lint.getLints(unit);
    }
  }
}
