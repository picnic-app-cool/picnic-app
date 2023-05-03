import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleStatsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleStatsFailure.unknown([this.cause]) : type = GetCircleStatsFailureType.unknown;

  final GetCircleStatsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCircleStatsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleStatsFailure{type: $type, cause: $cause}';
}

enum GetCircleStatsFailureType {
  unknown,
}
