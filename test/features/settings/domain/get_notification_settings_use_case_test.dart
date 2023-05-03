import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_notification_settings_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late GetNotificationSettingsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      verify(() => Mocks.privateProfileRepository.getNotificationSettings());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetNotificationSettingsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetNotificationSettingsUseCase(Mocks.privateProfileRepository);
    when(() => Mocks.privateProfileRepository.getNotificationSettings()) //
        .thenAnswer((_) => successFuture(Stubs.notificationSettings));

    when(() => SettingsMocks.getNotificationSettingsUseCase.execute())
        .thenAnswer((_) => successFuture(Stubs.notificationSettings));
  });
}
