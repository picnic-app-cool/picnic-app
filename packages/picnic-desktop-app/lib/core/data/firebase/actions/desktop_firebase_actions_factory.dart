import 'package:picnic_app/core/data/firebase/actions/firebase_actions_factory.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_apple_action.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_google_action.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_phone_action.dart';
import 'package:picnic_app/core/data/firebase/actions/request_phone_code_action.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_desktop_app/core/data/firebase/actions/desktop_log_in_with_google_action.dart';

class DesktopFirebaseActionsFactory implements FirebaseActionsFactory {
  const DesktopFirebaseActionsFactory(this._firebaseProvider);

  final FirebaseProvider _firebaseProvider;

  @override
  // TODO: implement logInWithAppleAction
  LogInWithAppleAction get logInWithAppleAction => LogInWithAppleAction(_firebaseProvider);

  @override
  LogInWithGoogleAction get logInWithGoogleAction => DesktopLogInWithGoogleAction(
        _firebaseProvider.auth,
      );

  @override
  // TODO: implement logInWithPhoneAction
  LogInWithPhoneAction get logInWithPhoneAction => throw UnimplementedError();

  @override
  // TODO: implement requestPhoneCodeAction
  RequestPhoneCodeAction get requestPhoneCodeAction => throw UnimplementedError();
}
