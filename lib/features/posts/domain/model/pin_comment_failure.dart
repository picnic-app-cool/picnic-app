import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class PinCommentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const PinCommentFailure.unknown([this.cause]) : type = PinCommentFailureType.unknown;

  final PinCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case PinCommentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'PinCommentFailure{type: $type, cause: $cause}';
}

enum PinCommentFailureType {
  unknown,
}
