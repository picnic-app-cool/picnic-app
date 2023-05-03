import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateCurrentUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateCurrentUserFailure.unknown([this.cause]) : type = UpdateCurrentUserFailureType.unknown;

  final UpdateCurrentUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateCurrentUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateCurrentUserFailure{type: $type, cause: $cause}';
}

enum UpdateCurrentUserFailureType {
  unknown,
}
