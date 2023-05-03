import 'package:dartz/dartz.dart';
import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_google_action.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';

class DesktopLogInWithGoogleAction implements LogInWithGoogleAction {
  DesktopLogInWithGoogleAction(
    this._auth,
  );

  final _googleSignInArgs = GoogleSignInArgs(
    clientId: '199288137804-ei4gkbcgpvn7uunk40k3u98ui301ger7.apps.googleusercontent.com',
    redirectUri: 'https://amber-app-supercool.firebaseapp.com/__/auth/handler',
    scope: 'email',
  );

  final FirebaseAuth? _auth;

  @override
  Future<Either<LogInFailure, UserCredential>> signIn(
    LogInCredentials credentials,
  ) async {
    if (_auth == null) {
      return failure(const LogInFailure.unknown('No FirebaseAuth available'));
    }
    try {
      final result = await DesktopWebviewAuth.signIn(_googleSignInArgs);

      if (result == null || result.accessToken == null) {
        throw Exception('There is not access token');
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: result.accessToken,
      );

      return success(
        await _auth!.signInWithCredential(credential),
      );
    } catch (ex, stack) {
      logError(ex, stack: stack);
      return failure(LogInFailure.unknown(ex));
    }
  }
}
