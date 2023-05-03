import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetFollowersFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetFollowersFailure.unknown([this.cause]) : type = GetFollowersFailureType.unknown;

  final GetFollowersFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetFollowersFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetFollowersFailure{type: $type, cause: $cause}';
}

enum GetFollowersFailureType {
  unknown,
}
