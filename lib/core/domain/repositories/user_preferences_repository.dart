import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/user_preferences_failure.dart';

abstract class UserPreferencesRepository {
  Future<Either<UserPreferencesFailure, bool>> acceptAppTerms();

  Future<Either<UserPreferencesFailure, bool>> hasUserAgreedToAppTerms();

  Future<Either<UserPreferencesFailure, bool>> setAppBadgeCount(int count);

  Future<Either<UserPreferencesFailure, int>> getAppBadgeCount();

  Future<Either<UserPreferencesFailure, bool>> saveShouldUseShortLivedAuthTokens({required bool shouldUse});

  Future<Either<UserPreferencesFailure, bool>> shouldUseShortLivedAuthTokens();

  Future<Either<UserPreferencesFailure, bool>> saveShouldShowCirclesSelection({required bool shouldShow});

  Future<Either<UserPreferencesFailure, bool>> shouldShowCirclesSelection();
}
