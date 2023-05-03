import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/debug/domain/model/invalidate_token_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

class InvalidateTokenUseCase {
  const InvalidateTokenUseCase(
    this._authTokenRepository,
  );

  final AuthTokenRepository _authTokenRepository;

  Future<Either<InvalidateTokenFailure, Unit>> execute() async {
    final token = await _authTokenRepository.getAuthToken().asyncFold(
          (fail) => const AuthToken.empty(),
          (success) => success,
        );
    return _authTokenRepository
        .saveAuthToken(
          token.copyWith(
            ///adding date here to make sure we each time issue a unique token so that
            /// our logout handler does not treat this
            ///token as already handled
            accessToken: 'invalidToken${Random.secure().nextDouble()}',
          ),
        )
        .mapFailure(InvalidateTokenFailure.unknown);
  }
}
