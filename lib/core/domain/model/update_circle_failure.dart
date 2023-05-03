import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UpdateCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UpdateCircleFailure.unknown([this.cause]) : type = UpdateCircleFailureType.unknown;

  final UpdateCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UpdateCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UpdateCircleFailure{type: $type, cause: $cause}';
}

enum UpdateCircleFailureType {
  unknown,
}
