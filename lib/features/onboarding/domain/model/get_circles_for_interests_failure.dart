import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCirclesForInterestsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCirclesForInterestsFailure.unknown([this.cause]) : type = GetCirclesForInterestsFailureType.unknown;

  final GetCirclesForInterestsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCirclesForInterestsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCirclesForInterestsFailure{type: $type, cause: $cause}';
}

enum GetCirclesForInterestsFailureType {
  unknown,
}
