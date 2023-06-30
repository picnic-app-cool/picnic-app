import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/auth_result.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/save_auth_token_failure.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/register_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/validators/onboarding_form_validator.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/onboarding_mocks.dart';

void main() {
  late RegisterUseCase useCase;
  late final formData = const OnboardingFormData.empty().copyWith(
    username: "superUsername12",
    authResult: AuthResult(
      userId: Stubs.privateProfile.user.id,
      authToken: Stubs.authToken,
      privateProfile: Stubs.privateProfile,
    ),
    phoneVerificationData: const PhoneVerificationData.empty().copyWith(
      country: Stubs.countryUS,
      phoneNumber: "712712712",
    ),
    circles: List.generate(5, (index) => const Id.empty()),
  );

  setUp(() {
    useCase = RegisterUseCase(
      Mocks.authRepository,
      Mocks.userStore,
      OnboardingFormValidator(),
      Mocks.localStoreRepository,
      OnboardingMocks.saveAuthTokenUseCase,
      AnalyticsMocks.analyticsRepository,
      CirclesMocks.joinCirclesUseCase,
    );
    when(() => OnboardingMocks.saveAuthTokenUseCase.execute(authToken: any(named: 'authToken')))
        .thenSuccess((_) => unit);
    when(() => Mocks.localStoreRepository.saveCurrentUser(user: any(named: 'user')))
        .thenAnswer((_) => successFuture(unit));
    when(() => CirclesMocks.joinCirclesUseCase.execute(circleIds: any(named: 'circleIds')))
        .thenAnswer((_) => successFuture(unit));
  });

  test(
    'should return validation error on empty form',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(formData: const OnboardingFormData.empty());

      // THEN
      expect(result.getFailure()?.type, RegisterFailureType.validationError);
    },
  );

  test(
    'should clear user data in case of failure',
    () async {
      // GIVEN
      _mockSuccessRegister();
      when(() => OnboardingMocks.saveAuthTokenUseCase.execute(authToken: any(named: "authToken")))
          .thenFailure((p0) => const SaveAuthTokenFailure.unknown());

      // WHEN
      final result = await useCase.execute(formData: formData);

      // THEN
      expect(result.isFailure, true);
      verify(() => Mocks.userStore.privateProfile = const PrivateProfile.anonymous());
      verify(() => AnalyticsMocks.analyticsRepository.setUser(const User.anonymous()));
    },
  );

  test(
    'should successfully register user',
    () async {
      // GIVEN
      _mockSuccessRegister();

      // WHEN
      final result = await useCase.execute(
        formData: formData,
      );

      // THEN
      expect(result.isSuccess, true);
      expect(result.getSuccess(), Stubs.privateProfile);
      verifyInOrder([
        () => Mocks.authRepository.register(formData: formData),
        () => Mocks.userStore.privateProfile = Stubs.privateProfile,
        () => Mocks.localStoreRepository.saveCurrentUser(user: Stubs.privateProfile),
        () => OnboardingMocks.saveAuthTokenUseCase.execute(
              authToken: any(named: "authToken"),
            ),
        () => AnalyticsMocks.analyticsRepository.setUser(
              Stubs.privateProfile.user,
            ),
      ]);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<RegisterUseCase>();
    expect(useCase, isNotNull);
  });
}

void _mockSuccessRegister() {
  when(() => Mocks.authRepository.register(formData: any(named: "formData"))).thenAnswer(
    (_) => successFuture(
      AuthResult(
        userId: Stubs.privateProfile.user.id,
        authToken: Stubs.authToken,
        privateProfile: Stubs.privateProfile,
      ),
    ),
  );
}
