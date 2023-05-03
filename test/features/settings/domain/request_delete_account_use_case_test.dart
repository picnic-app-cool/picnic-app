import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason_input.dart';
import 'package:picnic_app/features/settings/domain/use_cases/request_delete_account_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late RequestDeleteAccountUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(deleteAccountReasonInput: const DeleteAccountReasonInput.empty());
      verify(
        () => Mocks.privateProfileRepository.requestDeleteAccount(
          deleteAccountReasonInput: const DeleteAccountReasonInput.empty(),
        ),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RequestDeleteAccountUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = RequestDeleteAccountUseCase(Mocks.privateProfileRepository);

    when(
      () => Mocks.privateProfileRepository
          .requestDeleteAccount(deleteAccountReasonInput: const DeleteAccountReasonInput.empty()),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => SettingsMocks.requestDeleteAccountUseCase
          .execute(deleteAccountReasonInput: const DeleteAccountReasonInput.empty()),
    ).thenAnswer((_) => successFuture(unit));
  });
}
