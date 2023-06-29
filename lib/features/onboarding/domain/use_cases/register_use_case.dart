import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/join_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_auth_token_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/analytics/domain/repositories/analytics_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/domain/model/register_failure.dart';
import 'package:picnic_app/features/onboarding/domain/validators/onboarding_form_validator.dart';

class RegisterUseCase {
  const RegisterUseCase(
    this._authRepository,
    this._userStore,
    this._validator,
    this._localStorageRepository,
    this._saveAuthTokenUseCase,
    this._analyticsRepository,
    this._joinCirclesUseCase,
  );

  final AuthRepository _authRepository;
  final UserStore _userStore;
  final OnboardingFormValidator _validator;
  final LocalStorageRepository _localStorageRepository;
  final SaveAuthTokenUseCase _saveAuthTokenUseCase;
  final AnalyticsRepository _analyticsRepository;
  final JoinCirclesUseCase _joinCirclesUseCase;

  Future<Either<RegisterFailure, PrivateProfile>> execute({
    required OnboardingFormData formData,
  }) async {
    final validationFailure = _validator.validate(formData).getFailure();
    if (validationFailure != null) {
      return failure(RegisterFailure.validationError(validationFailure));
    }
    return _authRepository
        .register(formData: formData)
        .chainOnSuccess(
          (result) => _saveUserInfo(
            result.privateProfile,
          ),
        )
        .chainOnSuccess(
          (result) => _saveAuthToken(
            result.authToken,
          ),
        )
        .chainOnSuccess(
          (result) => _joinCircles(formData.circles),
        )
        .doOn(success: (authInfo) => _setUserInAnalytics(authInfo.privateProfile.user))
        .mapSuccess((result) => result.privateProfile)
        .doOn(fail: (_) => _unauthenticateUser());
  }

  Future<Either<RegisterFailure, Unit>> _saveUserInfo(PrivateProfile user) async {
    _userStore.privateProfile = user;
    return _localStorageRepository
        .saveCurrentUser(user: user)
        .doOn(fail: (fail) => logError(fail))
        .mapFailure((fail) => RegisterFailure.unknown(fail));
  }

  Future<Either<RegisterFailure, Unit>> _saveAuthToken(AuthToken authToken) async {
    return _saveAuthTokenUseCase
        .execute(authToken: authToken) //
        .mapFailure((fail) => RegisterFailure.unknown(fail));
  }

  Future<Either<RegisterFailure, Unit>> _joinCircles(List<Id> circlesList) {
    return _joinCirclesUseCase
        .execute(circleIds: circlesList)
        .doOn(fail: (fail) => logError(fail))
        .mapFailure((fail) => RegisterFailure.unknown(fail))
        .mapSuccess((response) => unit);
  }

  void _unauthenticateUser() {
    _userStore.privateProfile = const PrivateProfile.anonymous();
    _saveAuthToken(const AuthToken.empty());
    _saveUserInfo(const PrivateProfile.anonymous());
    _setUserInAnalytics(const User.anonymous());
  }

  void _setUserInAnalytics(User user) {
    _analyticsRepository.setUser(user);
  }
}
