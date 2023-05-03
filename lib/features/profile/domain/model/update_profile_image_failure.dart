import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateProfileImageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateProfileImageFailure.unknown([this.cause]) : type = UpdateProfileImageFailureType.unknown;

  final UpdateProfileImageFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateProfileImageFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateProfileImageFailure{type: $type, cause: $cause}';
}

enum UpdateProfileImageFailureType {
  unknown,
}
