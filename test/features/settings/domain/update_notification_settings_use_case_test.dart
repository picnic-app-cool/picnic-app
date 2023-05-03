import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/model/notification_settings.dart';
import 'package:picnic_app/features/settings/domain/use_cases/update_notification_settings_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late UpdateNotificationSettingsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(notificationSettings: const NotificationSettings.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateNotificationSettingsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = UpdateNotificationSettingsUseCase(Mocks.privateProfileRepository);

    when(
      () => Mocks.privateProfileRepository.updateNotificationSettings(
        notificationSettings: const NotificationSettings.empty(),
      ),
    ).thenAnswer((_) => successFuture(unit));
  });
}
