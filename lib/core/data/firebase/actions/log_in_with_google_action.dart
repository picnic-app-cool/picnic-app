import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';

class LogInWithGoogleAction {
  const LogInWithGoogleAction(
    this._firebaseProvider,
    this._googleSignIn,
  );

  final FirebaseProvider? _firebaseProvider;
  final GoogleSignIn _googleSignIn;

  Future<Either<LogInFailure, UserCredential>> signIn(
    LogInCredentials credentials,
  ) async {
    final auth = _firebaseProvider?.auth;
    if (auth == null) {
      return failure(const LogInFailure.unknown("No FirebaseAuth available"));
    }
    try {
      // Trigger the authentication flow
      LogInFailure? loginFailure;
      final googleUser = await _googleSignIn.signIn().onError((ex, stack) {
        _logError(ex, stack);
        loginFailure = LogInFailure.unknown(ex);
        return null;
      });

      if (loginFailure != null) {
        return failure(loginFailure!);
      }

      // Obtain the auth details from the request
      if (googleUser == null) {
        return failure(const LogInFailure.canceled());
      }

      final googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final result = await auth.signInWithCredential(credential);
      return success(result);
    } catch (ex, stack) {
      _logError(ex, stack);
      return failure(LogInFailure.unknown(ex));
    }
  }

  void _logError(Object? exception, StackTrace stack) {
    logError(
      exception,
      stack: stack,
    );
  }
}
