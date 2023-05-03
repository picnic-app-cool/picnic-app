import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/push_notifications/domain/model/update_device_token_failure.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/update_device_token_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/push_notifications_mocks.dart';

void main() {
  late UpdateDeviceTokenUseCase useCase;

  test(
    'should get current token if no token was provided',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
      verify(() => PushNotificationsMocks.pushNotificationRepository.getDeviceToken());
      verify(() => PushNotificationsMocks.pushNotificationRepository.sendDeviceTokenToBackend(token: 'mockToken'));
    },
  );

  test(
    'should use provided token',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(token: 'providedToken');

      // THEN
      expect(result.isSuccess, true);
      verifyNever(() => PushNotificationsMocks.pushNotificationRepository.getDeviceToken());
      verify(() => PushNotificationsMocks.pushNotificationRepository.sendDeviceTokenToBackend(token: 'providedToken'));
    },
  );

  test(
    'should fail if not logged in',
    () async {
      // GIVEN
      when(() => Mocks.userStore.isUserLoggedIn).thenReturn(false);
      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isFailure, true);
      expect(result.getFailure()!.type, UpdateDeviceTokenFailureType.unauthenticated);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateDeviceTokenUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    when(() => PushNotificationsMocks.pushNotificationRepository.getDeviceToken()).thenSuccess((_) => 'mockToken');
    when(() => PushNotificationsMocks.pushNotificationRepository.sendDeviceTokenToBackend(token: any(named: 'token')))
        .thenSuccess((p0) => unit);
    when(() => Mocks.userStore.isUserLoggedIn).thenReturn(true);
    useCase = UpdateDeviceTokenUseCase(
      PushNotificationsMocks.pushNotificationRepository,
      Mocks.userStore,
    );
  });
}
