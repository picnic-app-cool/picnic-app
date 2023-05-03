import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DeleteCommentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteCommentFailure.unknown([this.cause]) : type = DeleteCommentFailureType.unknown;

  final DeleteCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteCommentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DeleteCommentFailure{type: $type, cause: $cause}';
}

enum DeleteCommentFailureType {
  unknown,
}
