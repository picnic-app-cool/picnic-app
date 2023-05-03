import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LogInWithAppleAction {
  const LogInWithAppleAction(
    this._firebaseProvider,
  );

  final FirebaseProvider? _firebaseProvider;

  Future<Either<LogInFailure, UserCredential>> signIn(
    LogInCredentials credentials,
  ) async {
    final auth = _firebaseProvider?.auth;
    if (auth == null) {
      return failure(const LogInFailure.unknown("No FirebaseAuth available"));
    }
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = _sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      final result = await auth.signInWithCredential(credential);
      return success(result);
    } catch (ex, stack) {
      logError(
        ex,
        stack: stack,
      );
      if (ex is SignInWithAppleAuthorizationException && ex.code == AuthorizationErrorCode.canceled) {
        return failure(LogInFailure.canceled(ex));
      }
      return failure(LogInFailure.unknown(ex));
    }
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
