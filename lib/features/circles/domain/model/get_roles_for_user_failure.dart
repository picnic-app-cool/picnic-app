import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetRolesForUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetRolesForUserFailure.unknown([this.cause]) : type = GetRolesForUserFailureType.unknown;

  final GetRolesForUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetRolesForUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetRolesForUserFailure{type: $type, cause: $cause}';
}

enum GetRolesForUserFailureType {
  unknown,
}
