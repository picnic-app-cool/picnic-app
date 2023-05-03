import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/user_preferences_failure.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';

class HasUserAgreedToAppsTermsUseCase {
  const HasUserAgreedToAppsTermsUseCase(this._userPreferencesRepository);

  final UserPreferencesRepository _userPreferencesRepository;

  Future<Either<UserPreferencesFailure, bool>> execute() => _userPreferencesRepository.hasUserAgreedToAppTerms();
}
