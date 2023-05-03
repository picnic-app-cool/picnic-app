import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/use_cases/log_out_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../features/analytics/mocks/analytics_mocks.dart';
import '../../features/push_notifications/mocks/push_notifications_mocks.dart';
import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late LogOutUseCase useCase;

  test(
    'cleans up all resources',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
      verify(() => Mocks.authTokenRepository.deleteAuthToken());
      verify(() => Mocks.localStoreRepository.saveCurrentUser(user: const PrivateProfile.anonymous()));
      verify(() => Mocks.sessionExpiredRepository.clearHandledTokens());
      verify(() => Mocks.cacheManagementRepository.cleanCache());
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LogOutUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    when(() => PushNotificationsMocks.pushNotificationRepository.clearToken())
        .thenAnswer((invocation) => successFuture(unit));
    when(
      () => Mocks.authTokenRepository.deleteAuthToken(),
    ).thenAnswer((invocation) => successFuture(unit));

    when(() => Mocks.cacheManagementRepository.cleanCache()).thenAnswer((invocation) => Future.value());
    when(
      () => Mocks.localStoreRepository.saveCurrentUser(user: const PrivateProfile.anonymous()),
    ).thenAnswer((invocation) => successFuture(unit));
    useCase = LogOutUseCase(
      Mocks.userStore,
      Mocks.localStoreRepository,
      Mocks.sessionExpiredRepository,
      PushNotificationsMocks.pushNotificationRepository,
      AnalyticsMocks.analyticsRepository,
      Mocks.cacheManagementRepository,
      Mocks.authTokenRepository,
    );
  });
}
