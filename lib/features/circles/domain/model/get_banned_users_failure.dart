import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetBannedUsersFailure implements HasDisplayableFailure {
  const GetBannedUsersFailure({
    required this.type,
    required this.cause,
  });

  // ignore: avoid_field_initializers_in_const_classes
  const GetBannedUsersFailure.unknown([this.cause]) : type = GetBannedUsersFailureType.unknown;

  final GetBannedUsersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetBannedUsersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetBannedUsersFailure{type: $type, cause: $cause}';
}

enum GetBannedUsersFailureType {
  unknown,
}
