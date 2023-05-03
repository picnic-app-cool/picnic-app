import 'package:google_sign_in/google_sign_in.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_apple_action.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_google_action.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_phone_action.dart';
import 'package:picnic_app/core/data/firebase/actions/request_phone_code_action.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';

class FirebaseActionsFactory {
  FirebaseActionsFactory(
    this._firebaseProvider,
    this._googleSignIn,
  );

  final FirebaseProvider _firebaseProvider;
  final GoogleSignIn _googleSignIn;

  RequestPhoneCodeAction get requestPhoneCodeAction => RequestPhoneCodeAction(
        _firebaseProvider,
      );

  LogInWithGoogleAction get logInWithGoogleAction => LogInWithGoogleAction(
        _firebaseProvider,
        _googleSignIn,
      );

  LogInWithAppleAction get logInWithAppleAction => LogInWithAppleAction(
        _firebaseProvider,
      );

  LogInWithPhoneAction get logInWithPhoneAction => LogInWithPhoneAction(
        _firebaseProvider,
      );
}
