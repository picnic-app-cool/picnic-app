import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class EditProfileFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const EditProfileFailure.unknown([this.cause]) : type = EditProfileFailureType.unknown;

  final EditProfileFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case EditProfileFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'EditProfileFailure{type: $type, cause: $cause}';
}

enum EditProfileFailureType {
  unknown,
}
