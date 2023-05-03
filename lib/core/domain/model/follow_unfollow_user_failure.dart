import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class FollowUnfollowUserFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const FollowUnfollowUserFailure.unknown([this.cause]) : type = FollowUserFailureType.unknown;

  final FollowUserFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case FollowUserFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'FollowUserFailure{type: $type, cause: $cause}';
}

enum FollowUserFailureType {
  unknown,
}
