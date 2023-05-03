import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/get_auth_token_failure.dart';
import 'package:picnic_app/core/domain/model/save_auth_token_failure.dart';
import 'package:picnic_app/core/domain/model/secure_local_storage_key.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/repositories/secure_local_storage_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/onboarding/domain/model/auth_token.dart';

// TODO add unit tests
class SecureStorageAuthTokenRepository implements AuthTokenRepository {
  SecureStorageAuthTokenRepository(
    this._secureLocalStorageRepository,
  );

  final SecureLocalStorageRepository _secureLocalStorageRepository;

  late final StreamController<AuthToken> _tokenStreamController = StreamController.broadcast(
    onListen: _onStartListening,
  );

  AuthToken? _authToken;
  Completer<void>? _initCompleter;

  @override
  Future<Either<SaveAuthTokenFailure, Unit>> deleteAuthToken() {
    return _saveAuthToken(authToken: null);
  }

  @override
  Future<Either<GetAuthTokenFailure, AuthToken>> getAuthToken() async {
    await _initTokenIfNecessary();
    return success(_authToken ?? const AuthToken.empty());
  }

  @override
  Stream<AuthToken> listenAuthToken() {
    return _tokenStreamController.stream;
  }

  @override
  Future<Either<SaveAuthTokenFailure, Unit>> saveAuthToken(AuthToken token) {
    return _saveAuthToken(authToken: token);
  }

  Future<void> _onStartListening() async {
    await _initTokenIfNecessary();
  }

  Future<void> _initTokenIfNecessary() async {
    if (_initCompleter == null) {
      _initCompleter = Completer<void>();
      final token = (await _readAuthTokenFromStorage()).getOrElse(() => const AuthToken.empty());
      _authToken = token;
      _tokenStreamController.add(token);
      _initCompleter?.complete();
    } else {
      return _initCompleter?.future;
    }
  }

  Future<Either<SaveAuthTokenFailure, Unit>> _saveAuthToken({required AuthToken? authToken}) async {
    _authToken = authToken;
    _tokenStreamController.add(authToken ?? const AuthToken.empty());
    final accessToken = authToken?.accessToken ?? '';
    final refreshToken = authToken?.refreshToken ?? '';
    return _secureLocalStorageRepository
        .write(
          key: SecureLocalStorageKey.gqlAccessToken,
          value: accessToken.isEmpty ? null : accessToken,
        )
        .flatMap(
          (a) => _secureLocalStorageRepository.write(
            key: SecureLocalStorageKey.gqlRefreshToken,
            value: refreshToken.isEmpty ? null : refreshToken,
          ),
        )
        .mapFailure(SaveAuthTokenFailure.unknown);
  }

  Future<Either<GetAuthTokenFailure, AuthToken>> _readAuthTokenFromStorage() async {
    return _getStorageString(SecureLocalStorageKey.gqlAccessToken).flatMap(
      (accessToken) {
        return _getStorageString(SecureLocalStorageKey.gqlRefreshToken).mapSuccess(
          (refreshToken) {
            return AuthToken(
              accessToken: accessToken,
              refreshToken: refreshToken,
            );
          },
        );
      },
    );
  }

  Future<Either<GetAuthTokenFailure, String>> _getStorageString(SecureLocalStorageKey key) async {
    return _secureLocalStorageRepository
        .read<String>(key: key) //
        .mapFailure(GetAuthTokenFailure.unknown)
        .mapSuccess((token) => token ?? '');
  }
}
