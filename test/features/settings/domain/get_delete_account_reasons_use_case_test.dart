import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_delete_account_reasons_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late GetDeleteAccountReasonsUseCase useCase;

  setUp(() {
    useCase = GetDeleteAccountReasonsUseCase(SettingsMocks.documentsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        documentEntityType: DocumentEntityType.deleteAccount,
      );

      // THEN
      verify(
        () => SettingsMocks.documentsRepository.getDeleteAccountReasons(
          documentEntityType: DocumentEntityType.deleteAccount,
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetDeleteAccountReasonsUseCase>();
    expect(useCase, isNotNull);
  });

  when(
    () => SettingsMocks.documentsRepository.getDeleteAccountReasons(
      documentEntityType: DocumentEntityType.deleteAccount,
    ),
  ).thenAnswer((_) => successFuture(Stubs.deleteAccountReasons));
}
