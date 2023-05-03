import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserCirclesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserCirclesFailure.unknown([this.cause]) : type = GetUserCirclesFailureType.unknown;

  final GetUserCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCirclesFailure{type: $type, cause: $cause}';
}

enum GetUserCirclesFailureType {
  unknown,
}
