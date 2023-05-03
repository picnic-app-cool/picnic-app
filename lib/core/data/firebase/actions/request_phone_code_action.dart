import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/domain/model/phone_verification_data.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/onboarding/domain/model/request_phone_code_failure.dart';

class RequestPhoneCodeAction {
  const RequestPhoneCodeAction(this._firebaseProvider);

  final FirebaseProvider? _firebaseProvider;

  //ignore: long-method
  Future<Either<RequestPhoneCodeFailure, PhoneVerificationData>> requestPhoneCode({
    required int? forceResendingCodeToken,
    required PhoneVerificationData verificationData,
    required void Function(int) onForceResendingTokenReceived,
  }) async {
    final completer = Completer<Either<RequestPhoneCodeFailure, PhoneVerificationData>>();
    final auth = _firebaseProvider?.auth;
    if (auth == null) {
      return failure(const RequestPhoneCodeFailure.unknown("No FirebaseAuth available"));
    }
    try {
      await auth.verifyPhoneNumber(
        forceResendingToken: forceResendingCodeToken,
        phoneNumber: verificationData.phoneNumberWithDialCode,

        /// after automatic verification fails
        verificationFailed: (error) => _verificationFailed(completer, error),

        /// after the code was sent
        codeSent: (verificationId, int? forceResendingToken) => _codeSent(
          completer,
          verificationData.copyWith(verificationId: verificationId),
          forceResendingToken,
          onForceResendingTokenReceived,
        ),

        /// called when automatic code resolution fails in android, we'll proceed with manually typing in the sms code
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(
          completer,
          verificationData.copyWith(verificationId: verificationId),
        ),

        /// automatic verification completed successfully
        verificationCompleted: (credential) => _verificationCompleted(
          completer,
          verificationData.copyWith(
            verificationId: credential.verificationId ?? '',
            smsCode: credential.smsCode ?? '',
          ),
        ),
      );
    } catch (ex, stack) {
      logError(
        ex,
        stack: stack,
      );
      return failure(RequestPhoneCodeFailure.unknown(ex));
    }
    return completer.future;
  }

  void _codeAutoRetrievalTimeout(
    Completer<Either<RequestPhoneCodeFailure, PhoneVerificationData>> completer,
    PhoneVerificationData verificationData,
  ) =>
      completer.complete(success(verificationData));

  void _verificationFailed(
    Completer<Either<RequestPhoneCodeFailure, PhoneVerificationData>> completer,
    FirebaseAuthException error,
  ) =>
      completer.complete(failure(RequestPhoneCodeFailure.unknown(error)));

  void _codeSent(
    Completer<Either<RequestPhoneCodeFailure, PhoneVerificationData>> completer,
    PhoneVerificationData verificationData,
    int? forceResendingToken,
    void Function(int) onForceResendingTokenReceived,
  ) {
    if (forceResendingToken != null) {
      onForceResendingTokenReceived(forceResendingToken);
    }
    completer.complete(success(verificationData));
  }

  void _verificationCompleted(
    Completer<Either<RequestPhoneCodeFailure, PhoneVerificationData>> completer,
    PhoneVerificationData verificationData,
  ) =>
      completer.complete(success(verificationData));
}
