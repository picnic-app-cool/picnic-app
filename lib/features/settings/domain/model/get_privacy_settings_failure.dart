import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPrivacySettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPrivacySettingsFailure.unknown([this.cause]) : type = GetPrivacySettingsFailureType.unknown;

  final GetPrivacySettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPrivacySettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPrivacySettingsFailure{type: $type, cause: $cause}';
}

enum GetPrivacySettingsFailureType {
  unknown,
}
