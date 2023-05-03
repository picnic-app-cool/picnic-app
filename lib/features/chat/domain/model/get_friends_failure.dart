import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetFriendsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetFriendsFailure.unknown([this.cause]) : type = GetFriendsFailureType.unknown;

  final GetFriendsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetFriendsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetFriendsFailure{type: $type, cause: $cause}';
}

enum GetFriendsFailureType {
  unknown,
}
