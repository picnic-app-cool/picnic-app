import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetPinnedCommentsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetPinnedCommentsFailure.unknown([this.cause]) : type = GetPinnedCommentFailureType.unknown;

  final GetPinnedCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetPinnedCommentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetPinnedCommentFailure{type: $type, cause: $cause}';
}

enum GetPinnedCommentFailureType {
  unknown,
}
