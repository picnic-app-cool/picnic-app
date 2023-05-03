import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class HandleForceLogOutFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const HandleForceLogOutFailure.unknown([this.cause]) : type = HandleForceLogOutFailureType.unknown;

  final HandleForceLogOutFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case HandleForceLogOutFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'HandleForceLogOutFailure{type: $type, cause: $cause}';
}

enum HandleForceLogOutFailureType {
  unknown,
}
