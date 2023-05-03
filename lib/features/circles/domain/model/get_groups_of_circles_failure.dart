import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetGroupsOfCirclesFailure implements HasDisplayableFailure {
  const GetGroupsOfCirclesFailure({
    required this.type,
    required this.cause,
  });

  // ignore: avoid_field_initializers_in_const_classes
  const GetGroupsOfCirclesFailure.unknown([this.cause]) : type = GetGroupsOfCirclesFailureType.unknown;

  final GetGroupsOfCirclesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetGroupsOfCirclesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleModeratorsFailure{type: $type, cause: $cause}';
}

enum GetGroupsOfCirclesFailureType {
  unknown,
}
