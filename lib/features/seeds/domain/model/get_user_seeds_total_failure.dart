import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetUserSeedsTotalFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetUserSeedsTotalFailure.unknown([this.cause]) : type = GetUserSeedsTotalFailureType.unknown;

  final GetUserSeedsTotalFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetUserSeedsTotalFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetUserSeedsTotalFailure{type: $type, cause: $cause}';
}

enum GetUserSeedsTotalFailureType {
  unknown,
}
