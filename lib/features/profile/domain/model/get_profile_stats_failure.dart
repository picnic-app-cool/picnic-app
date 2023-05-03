import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetProfileStatsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetProfileStatsFailure.unknown([this.cause]) : type = GetProfileStatsFailureType.unknown;

  final GetProfileStatsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetProfileStatsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetProfileStatsFailure{type: $type, cause: $cause}';
}

enum GetProfileStatsFailureType {
  unknown,
}
