import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/save_auth_token_failure.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class SaveAuthTokenUseCase {
  const SaveAuthTokenUseCase(
    this._authTokenRepository,
  );

  final AuthTokenRepository _authTokenRepository;

  Future<Either<SaveAuthTokenFailure, Unit>> execute({
    required AuthToken? authToken,
  }) async {
    return authToken == null ? _authTokenRepository.deleteAuthToken() : _authTokenRepository.saveAuthToken(authToken);
  }
}
