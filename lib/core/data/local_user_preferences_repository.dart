import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/data/shared_preferences_provider.dart';
import 'package:picnic_app/core/domain/model/user_preferences_failure.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';

class LocalUserPreferencesRepository implements UserPreferencesRepository {
  LocalUserPreferencesRepository(this.sharedPreferencesProvider);

  final SharedPreferencesProvider sharedPreferencesProvider;

  static const _hasUserAgreedToTermsCacheKey = 'hasUserAgreedToTerms';
  static const _shouldUseShortLivedAuthTokensCacheKey = 'shouldUseShortLivedAuthTokens';
  static const _appBadgeCountCacheKey = 'appBadgeCount';
  static const _shouldShowCirclesSelection = 'shouldShowCirclesSelection';

  @override
  Future<Either<UserPreferencesFailure, bool>> acceptAppTerms() async {
    return _saveBool(key: _hasUserAgreedToTermsCacheKey, value: true);
  }

  @override
  Future<Either<UserPreferencesFailure, bool>> hasUserAgreedToAppTerms() async {
    return _getBool(key: _hasUserAgreedToTermsCacheKey);
  }

  @override
  Future<Either<UserPreferencesFailure, bool>> saveShouldUseShortLivedAuthTokens({required bool shouldUse}) {
    return _saveBool(key: _shouldUseShortLivedAuthTokensCacheKey, value: shouldUse);
  }

  @override
  Future<Either<UserPreferencesFailure, bool>> shouldUseShortLivedAuthTokens() {
    return _getBool(key: _shouldUseShortLivedAuthTokensCacheKey);
  }

  @override
  Future<Either<UserPreferencesFailure, bool>> setAppBadgeCount(int count) async {
    return _saveInt(key: _appBadgeCountCacheKey, value: count);
  }

  @override
  Future<Either<UserPreferencesFailure, int>> getAppBadgeCount() async {
    return _getInt(key: _appBadgeCountCacheKey);
  }

  @override
  Future<Either<UserPreferencesFailure, bool>> saveShouldShowCirclesSelection({required bool shouldShow}) {
    return _saveBool(key: _shouldShowCirclesSelection, value: shouldShow);
  }

  @override
  Future<Either<UserPreferencesFailure, bool>> shouldShowCirclesSelection() {
    return _getBool(key: _shouldShowCirclesSelection);
  }

  Future<Either<UserPreferencesFailure, bool>> _saveBool({required String key, required bool value}) async {
    try {
      final sharedPrefInstance = await sharedPreferencesProvider.sharedPreferences;
      return success(await sharedPrefInstance.setBool(key, value));
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(UserPreferencesFailure.unknown(ex));
    }
  }

  Future<Either<UserPreferencesFailure, bool>> _getBool({required String key}) async {
    try {
      final sharedPrefInstance = await sharedPreferencesProvider.sharedPreferences;
      return success(sharedPrefInstance.getBool(key) ?? false);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(UserPreferencesFailure.unknown(ex));
    }
  }

  Future<Either<UserPreferencesFailure, bool>> _saveInt({required String key, required int value}) async {
    try {
      final sharedPrefInstance = await sharedPreferencesProvider.sharedPreferences;
      return success(await sharedPrefInstance.setInt(key, value));
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(UserPreferencesFailure.unknown(ex));
    }
  }

  Future<Either<UserPreferencesFailure, int>> _getInt({required String key}) async {
    try {
      final sharedPrefInstance = await sharedPreferencesProvider.sharedPreferences;
      return success(sharedPrefInstance.getInt(key) ?? 0);
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(UserPreferencesFailure.unknown(ex));
    }
  }
}
