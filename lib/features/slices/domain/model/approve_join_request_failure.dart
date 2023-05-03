import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ApproveJoinRequestFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ApproveJoinRequestFailure.unknown([this.cause]) : type = ApproveJoinRequestFailureType.unknown;

  final ApproveJoinRequestFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ApproveJoinRequestFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ApproveJoinRequestFailure{type: $type, cause: $cause}';
}

enum ApproveJoinRequestFailureType {
  unknown,
}
