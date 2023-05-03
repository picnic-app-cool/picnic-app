import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/credentials/phone_log_in_credentials.dart';
import 'package:picnic_app/features/onboarding/domain/model/log_in_failure.dart';

class LogInWithPhoneAction {
  const LogInWithPhoneAction(
    this._firebaseProvider,
  );

  final FirebaseProvider? _firebaseProvider;

  Future<Either<LogInFailure, UserCredential>> signIn({
    required LogInCredentials credentials,
  }) async {
    try {
      final auth = _firebaseProvider?.auth;
      if (auth == null) {
        return failure(const LogInFailure.unknown("No FirebaseAuth available"));
      }
      final creds = credentials as PhoneLogInCredentials;
      final firebaseCreds = PhoneAuthProvider.credential(
        verificationId: creds.verificationData.verificationId,
        smsCode: creds.verificationData.smsCode,
      );
      final result = await auth.signInWithCredential(firebaseCreds);

      return success(result);
    } catch (ex, stack) {
      logError(
        ex,
        stack: stack,
      );
      if (ex is FirebaseAuthException) {
        return ex.code == 'invalid-verification-code'
            ? failure(LogInFailure.invalidCode(ex))
            : failure(LogInFailure.unknown(ex));
      }
      return failure(LogInFailure.unknown(ex));
    }
  }
}
