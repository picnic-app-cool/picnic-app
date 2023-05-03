import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_privacy_settings_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late GetPrivacySettingsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();
      verify(() => Mocks.privateProfileRepository.getPrivacySettings());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPrivacySettingsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetPrivacySettingsUseCase(Mocks.privateProfileRepository);

    when(() => Mocks.privateProfileRepository.getPrivacySettings()) //
        .thenAnswer((_) => successFuture(Stubs.privacySettings));

    when(() => SettingsMocks.getPrivacySettingsUseCase.execute())
        .thenAnswer((_) => successFuture(Stubs.privacySettings));
  });
}
