import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/get_auth_token_failure.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class GetAuthTokenUseCase {
  const GetAuthTokenUseCase(
    this._authTokenRepository,
  );

  final AuthTokenRepository _authTokenRepository;

  Future<Either<GetAuthTokenFailure, AuthToken>> execute() async {
    return _authTokenRepository.getAuthToken();
  }
}
