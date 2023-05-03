import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetOnBoardingCirclesFailure implements HasDisplayableFailure {
  const GetOnBoardingCirclesFailure({
    required this.type,
    required this.cause,
  });

  // ignore: avoid_field_initializers_in_const_classes
  const GetOnBoardingCirclesFailure.unknown([this.cause]) : type = GetGroupedCirclesFailureType.unknown;

  final GetGroupedCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetGroupedCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetGroupedCirclesFailure{type: $type, cause: $cause}';
}

enum GetGroupedCirclesFailureType {
  unknown,
}
