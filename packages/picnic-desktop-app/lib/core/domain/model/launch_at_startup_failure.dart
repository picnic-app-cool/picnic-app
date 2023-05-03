import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LaunchAtStartupFailure implements HasDisplayableFailure {
  const LaunchAtStartupFailure.unknown([this.cause])
      // ignore: avoid_field_initializers_in_const_classes
      : type = LaunchAtStartupFailureType.unknown;

  final LaunchAtStartupFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LaunchAtStartupFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'AppInitFailure{type: $type, cause: $cause}';
}

enum LaunchAtStartupFailureType {
  unknown,
}
