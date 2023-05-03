import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class OpenNativeAppSettingsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const OpenNativeAppSettingsFailure.unknown([this.cause]) : type = OpenNativeAppSettingsFailureType.unknown;

  final OpenNativeAppSettingsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case OpenNativeAppSettingsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'OpenNativeAppSettingsFailure{type: $type, cause: $cause}';
}

enum OpenNativeAppSettingsFailureType {
  unknown,
}
