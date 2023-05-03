import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LoadAvatarBordersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LoadAvatarBordersFailure.unknown([this.cause]) : type = LoadAvatarBordersFailureType.unknown;

  final LoadAvatarBordersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LoadAvatarBordersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LoadAvatarBordersFailure{type: $type, cause: $cause}';
}

enum LoadAvatarBordersFailureType {
  unknown,
}
