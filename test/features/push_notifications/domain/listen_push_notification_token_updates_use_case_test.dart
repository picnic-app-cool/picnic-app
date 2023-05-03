import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/push_notifications/domain/use_cases/listen_device_token_updates_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/push_notifications_mocks.dart';

void main() {
  late ListenDeviceTokenUpdatesUseCase useCase;

  test(
    'should register token if logged in',
    () async {
      // GIVEN
      when(() => Mocks.userStore.isUserLoggedIn).thenReturn(true);

      // WHEN
      await useCase.execute();

      // THEN
      verifyInOrder([
        () => PushNotificationsMocks.pushNotificationRepository.getDeviceToken(),
        () => PushNotificationsMocks.updateDeviceTokenUseCase.execute(token: any(named: "token")),
        () => PushNotificationsMocks.pushNotificationRepository.setDeviceTokenUpdateListener(any()),
      ]);
    },
  );

  test(
    'should not register token if logged out',
    () async {
      // GIVEN
      when(() => Mocks.userStore.isUserLoggedIn).thenReturn(false);

      // WHEN
      await useCase.execute();

      // THEN
      verifyInOrder([
        () => PushNotificationsMocks.pushNotificationRepository.getDeviceToken(),
        () => PushNotificationsMocks.pushNotificationRepository.setDeviceTokenUpdateListener(any()),
      ]);
      verifyNever(
        () => PushNotificationsMocks.updateDeviceTokenUseCase.execute(token: any(named: "token")),
      );
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ListenDeviceTokenUpdatesUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = ListenDeviceTokenUpdatesUseCase(
      PushNotificationsMocks.pushNotificationRepository,
      PushNotificationsMocks.updateDeviceTokenUseCase,
      Mocks.userStore,
    );
    when(() => PushNotificationsMocks.pushNotificationRepository.getDeviceToken()).thenSuccess((_) => 'mockToken');
    when(() => PushNotificationsMocks.updateDeviceTokenUseCase.execute(token: any(named: 'token')))
        .thenSuccess((_) => unit);
  });
}
