import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/use_cases/update_privacy_settings_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late UpdatePrivacySettingsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(onlyDMFromFollowed: true);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdatePrivacySettingsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = UpdatePrivacySettingsUseCase(Mocks.privateProfileRepository);

    when(() => Mocks.privateProfileRepository.updatePrivacySettings(onlyDMFromFollowed: true)) //
        .thenAnswer((_) => successFuture(unit));
  });
}
