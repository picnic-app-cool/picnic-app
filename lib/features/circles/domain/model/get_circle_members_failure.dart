import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleMembersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleMembersFailure.unknown([this.cause]) : type = GetCircleMembersFailureType.unknown;

  final GetCircleMembersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetCircleMembersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleMembersFailure{type: $type, cause: $cause}';
}

enum GetCircleMembersFailureType {
  unknown,
}
