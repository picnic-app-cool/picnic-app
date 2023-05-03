import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCirclesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCirclesFailure.unknown([this.cause]) : type = GetCirclesFailureType.unknown;

  final GetCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCirclesFailure{type: $type, cause: $cause}';
}

enum GetCirclesFailureType {
  unknown,
}
