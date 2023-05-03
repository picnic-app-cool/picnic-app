import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/get_auth_token_failure.dart';
import 'package:picnic_app/core/domain/model/save_auth_token_failure.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

/// receives token updates from the main isolate
class IsolateAuthTokenRepository implements AuthTokenRepository {
  AuthToken _token = const AuthToken.empty();
  final _streamController = StreamController<AuthToken>.broadcast();

  @override
  Future<Either<SaveAuthTokenFailure, Unit>> deleteAuthToken() async {
    return _saveToken(const AuthToken.empty());
  }

  @override
  Future<Either<GetAuthTokenFailure, AuthToken>> getAuthToken() async {
    return success(_token);
  }

  @override
  Stream<AuthToken> listenAuthToken() {
    return _streamController.stream;
  }

  @override
  Future<Either<SaveAuthTokenFailure, Unit>> saveAuthToken(AuthToken token) async {
    return _saveToken(token);
  }

  Either<SaveAuthTokenFailure, Unit> _saveToken(AuthToken token) {
    if (token == _token) {
      return success(unit);
    }
    _token = token;
    _streamController.add(token);
    return success(unit);
  }
}
