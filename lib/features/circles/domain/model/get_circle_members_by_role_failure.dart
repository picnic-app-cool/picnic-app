import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetCircleMembersByRoleFailure implements HasDisplayableFailure {
  const GetCircleMembersByRoleFailure({
    required this.type,
    required this.cause,
  });

  // ignore: avoid_field_initializers_in_const_classes
  const GetCircleMembersByRoleFailure.unknown([this.cause]) : type = GetGetModeratorsFailureType.unknown;

  final GetGetModeratorsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetGetModeratorsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetCircleModeratorsFailure{type: $type, cause: $cause}';
}

enum GetGetModeratorsFailureType {
  unknown,
}
