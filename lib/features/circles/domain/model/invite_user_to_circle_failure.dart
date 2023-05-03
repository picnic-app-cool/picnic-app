import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class InviteUserToCircleFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const InviteUserToCircleFailure.unknown([this.cause]) : type = InviteUserToCircleFailureType.unknown;

  final InviteUserToCircleFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case InviteUserToCircleFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'InviteUserToCircleFailure{type: $type, cause: $cause}';
}

enum InviteUserToCircleFailureType {
  unknown,
}
