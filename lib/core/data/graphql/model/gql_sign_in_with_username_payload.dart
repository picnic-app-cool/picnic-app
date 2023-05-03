import 'package:picnic_app/core/data/utils/safe_convert.dart';
import 'package:picnic_app/core/domain/model/sign_in_method.dart';
import 'package:picnic_app/core/domain/model/sign_in_with_username_payload.dart';

class GqlSignInWithUsernamePayload {
  const GqlSignInWithUsernamePayload({
    required this.signInMethod,
    required this.maskedIdentifier,
    required this.sessionInfo,
  });

  factory GqlSignInWithUsernamePayload.fromJson(Map<String, dynamic> json) {
    final innerJson = asT<Map<String, dynamic>>(json, "signInWithUsername");
    return GqlSignInWithUsernamePayload(
      signInMethod: asT<String>(innerJson, 'signInMethod'),
      maskedIdentifier: asT<String>(innerJson, 'maskedIdentifier'),
      sessionInfo: asT<String>(innerJson, 'sessionInfo'),
    );
  }

  final String signInMethod;
  final String maskedIdentifier;
  final String sessionInfo;

  SignInWithUsernamePayload toDomain() => SignInWithUsernamePayload(
        signInMethod: SignInMethod.fromString(signInMethod),
        maskedIdentifier: maskedIdentifier,
        sessionInfo: sessionInfo,
      );
}
