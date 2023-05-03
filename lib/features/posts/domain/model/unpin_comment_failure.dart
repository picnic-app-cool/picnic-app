import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnpinCommentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnpinCommentFailure.unknown([this.cause]) : type = UnpinCommentFailureType.unknown;

  final UnpinCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnpinCommentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnpinCommentFailure{type: $type, cause: $cause}';
}

enum UnpinCommentFailureType {
  unknown,
}
