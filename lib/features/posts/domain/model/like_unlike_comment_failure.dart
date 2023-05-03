import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class LikeUnlikeCommentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const LikeUnlikeCommentFailure.unknown([this.cause]) : type = LikeUnlikeCommentFailureType.unknown;

  final LikeUnlikeCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case LikeUnlikeCommentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'LikeUnlikeCommentFailure{type: $type, cause: $cause}';
}

enum LikeUnlikeCommentFailureType {
  unknown,
}
