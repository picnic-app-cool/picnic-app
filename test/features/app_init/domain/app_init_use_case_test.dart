import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/app_init_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../push_notifications/mocks/push_notifications_mocks.dart';

void main() {
  late AppInitUseCase useCase;
  final user = Stubs.privateProfile;

  setUp(() {
    useCase = AppInitUseCase(
      [],
      Mocks.localStoreRepository,
      Mocks.userStore,
      Mocks.getFeatureFlagsUseCase,
      PushNotificationsMocks.listenDeviceTokenUpdatesUseCase,
      AnalyticsMocks.analyticsRepository,
      Mocks.setAppInfoUseCase,
      Mocks.unreadCountersStore,
      ChatMocks.getUnreadChatsUseCase,
    );

    when(() => Mocks.localStoreRepository.getCurrentUser()).thenAnswer((invocation) => successFuture(user));
    when(() => Mocks.getFeatureFlagsUseCase.execute()).thenAnswer((_) => successFuture(unit));
    when(() => PushNotificationsMocks.listenDeviceTokenUpdatesUseCase.execute()).thenAnswer((_) => successFuture(unit));
    when(() => Mocks.setAppInfoUseCase.execute()).thenAnswer((_) => successFuture(unit));
    when(() => ChatMocks.getUnreadChatsUseCase.execute()).thenAnswer((_) => successFuture([Stubs.unreadChat]));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      when(() => Mocks.userStore.isUserLoggedIn).thenAnswer((invocation) => true);
      final result = await useCase.execute();

      // THEN
      verifyInOrder([
        () => Mocks.localStoreRepository.getCurrentUser(),
        () => Mocks.userStore.privateProfile = user,
        () => ChatMocks.getUnreadChatsUseCase.execute(),
        () => PushNotificationsMocks.listenDeviceTokenUpdatesUseCase.execute(),
      ]);
      expect(result.isRight(), true);
    },
  );

  test(
    "getIt resolves successfully",
    () async {
      final useCase = getIt<AppInitUseCase>();
      expect(useCase, isNotNull);
    },
  );
}
