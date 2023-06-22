import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetConnectedSocialAccountsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetConnectedSocialAccountsFailure.unknown([this.cause]) : type = GetConnectedSocialAccountsFailureType.unknown;

  final GetConnectedSocialAccountsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetConnectedSocialAccountsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetConnectedSocialAccountsFailure{type: $type, cause: $cause}';
}

enum GetConnectedSocialAccountsFailureType {
  unknown,
}
