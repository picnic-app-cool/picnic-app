import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRecommendedCirclesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetRecommendedCirclesFailure.unknown([this.cause]) : type = GetRecommendedCirclesFailureType.unknown;

  final GetRecommendedCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRecommendedCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRecommendedCirclesFailure{type: $type, cause: $cause}';
}

enum GetRecommendedCirclesFailureType {
  unknown,
}
