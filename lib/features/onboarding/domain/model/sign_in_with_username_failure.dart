import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SignInWithUsernameFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SignInWithUsernameFailure.unknown([this.cause]) : type = SignInWithUsernameFailureType.unknown;

  final SignInWithUsernameFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SignInWithUsernameFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SignInWithUsernameFailure{type: $type, cause: $cause}';
}

enum SignInWithUsernameFailureType {
  unknown,
}
