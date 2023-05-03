import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/secure_local_storage_key.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/google_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/log_in_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../push_notifications/mocks/push_notifications_mocks.dart';
import '../../user_agreement/mocks/user_agreement_mocks.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late LogInUseCase useCase;

  setUp(() {
    useCase = LogInUseCase(
      Mocks.authRepository,
      Mocks.userStore,
      Mocks.localStoreRepository,
      PushNotificationsMocks.updateDeviceTokenUseCase,
      AnalyticsMocks.analyticsRepository,
      Mocks.setLanguageUseCase,
      OnboardingMocks.saveAuthTokenUseCase,
      ChatMocks.getUnreadChatsUseCase,
      Mocks.unreadCountersStore,
      UserAgreementMocks.acceptAppsTermsUseCase,
    );
    when(() => PushNotificationsMocks.updateDeviceTokenUseCase.execute()).thenAnswer((_) => successFuture(unit));
    when(() => OnboardingMocks.saveAuthTokenUseCase.execute(authToken: any(named: "authToken")))
        .thenSuccess((_) => unit);
    when(() => Mocks.localStoreRepository.saveCurrentUser(user: any(named: 'user')))
        .thenAnswer((_) => successFuture(unit));
    when(
      () => Mocks.secureLocalStoreRepository.write(
        key: SecureLocalStorageKey.gqlAccessToken,
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) => successFuture(unit));
    when(() => Mocks.setLanguageUseCase.execute(languagesCodes: any(named: 'languagesCodes')))
        .thenAnswer((_) => successFuture(unit));
    when(() => UserAgreementMocks.acceptAppsTermsUseCase.execute()).thenSuccess((_) => true);
    when(() => Mocks.unreadCountersStore.unreadChats).thenReturn([Stubs.unreadChat]);
    when(() => ChatMocks.getUnreadChatsUseCase.execute()).thenAnswer((_) => successFuture([Stubs.unreadChat]));
    when(() => UserAgreementMocks.acceptAppsTermsUseCase.execute()).thenSuccess((_) => true);
  });

  test(
    'signs in with google credentials',
    () async {
      // GIVEN
      // WHEN
      when(() => Mocks.authRepository.logIn(credentials: any(named: "credentials"))) //
          .thenAnswer(
        (_) => successFuture(
          AuthResult(
            userId: const Id("userId"),
            authToken: Stubs.authToken,
            privateProfile: const PrivateProfile.empty(),
          ),
        ),
      );

      final result = await useCase.execute(const GoogleLogInCredentials());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    "should logIn first, then save credentials in userStore and local Storage",
    () async {
      // GIVEN
      const credentials = PhoneLogInCredentials.empty();
      // WHEN

      when(() => Mocks.authRepository.logIn(credentials: any(named: "credentials"))) //
          .thenAnswer(
        (_) => successFuture(
          AuthResult(
            userId: const Id("userId"),
            authToken: Stubs.authToken,
            privateProfile: const PrivateProfile.empty(),
          ),
        ),
      );

      final result = await useCase.execute(credentials);

      // THEN
      verifyInOrder([
        () => Mocks.authRepository.logIn(credentials: credentials),
        () => Mocks.userStore.privateProfile = const PrivateProfile.empty(),
        () => Mocks.localStoreRepository.saveCurrentUser(user: const PrivateProfile.empty()),
        () => OnboardingMocks.saveAuthTokenUseCase.execute(
              authToken: any(named: "authToken"),
            ),
      ]);
      expect(result.isSuccess, true);
    },
  );

  test(
    "should save anonymous user on auth fail",
    () async {
      // GIVEN
      const credentials = PhoneLogInCredentials.empty();
      reset(UserAgreementMocks.acceptAppsTermsUseCase);

      when(() => Mocks.authRepository.logIn(credentials: any(named: "credentials"))) //
          .thenFailure((_) => const LogInFailure.unknown());

      // WHEN
      final result = await useCase.execute(credentials);

      // THEN
      verifyInOrder([
        () => Mocks.authRepository.logIn(credentials: credentials),
        () => Mocks.userStore.privateProfile = const PrivateProfile.anonymous(),
        () => OnboardingMocks.saveAuthTokenUseCase.execute(authToken: const AuthToken.empty()),
        () => Mocks.localStoreRepository.saveCurrentUser(user: const PrivateProfile.anonymous()),
        () => AnalyticsMocks.analyticsRepository.setUser(const User.anonymous()),
      ]);
      verifyZeroInteractions(UserAgreementMocks.acceptAppsTermsUseCase);
      expect(result.isFailure, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LogInUseCase>();
    expect(useCase, isNotNull);
  });
}
