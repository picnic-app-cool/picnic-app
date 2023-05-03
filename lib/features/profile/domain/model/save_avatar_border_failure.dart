import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class SaveAvatarBorderFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SaveAvatarBorderFailure.unknown([this.cause]) : type = SaveAvatarBorderFailureType.unknown;

  final SaveAvatarBorderFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SaveAvatarBorderFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'SaveAvatarBorderFailure{type: $type, cause: $cause}';
}

enum SaveAvatarBorderFailureType {
  unknown,
}
