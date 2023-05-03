import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdatePrivacySettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdatePrivacySettingsFailure.unknown([this.cause]) : type = UpdatePrivacySettingsFailureType.unknown;

  final UpdatePrivacySettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdatePrivacySettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdatePrivacySettingsFailure{type: $type, cause: $cause}';
}

enum UpdatePrivacySettingsFailureType {
  unknown,
}
