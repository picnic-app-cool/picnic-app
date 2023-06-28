import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserStatsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserStatsFailure.unknown([this.cause]) : type = GetUserStatsFailureType.unknown;

  final GetUserStatsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserStatsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserStatsFailure{type: $type, cause: $cause}';
}

enum GetUserStatsFailureType {
  unknown,
}
