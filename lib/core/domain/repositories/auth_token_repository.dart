import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/get_auth_token_failure.dart';
import 'package:picnic_app/core/domain/model/save_auth_token_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

abstract class AuthTokenRepository {
  Stream<AuthToken> listenAuthToken();
  Future<Either<GetAuthTokenFailure, AuthToken>> getAuthToken();
  Future<Either<SaveAuthTokenFailure, Unit>> saveAuthToken(AuthToken token);

  Future<Either<SaveAuthTokenFailure, Unit>> deleteAuthToken();
}
