import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class UnreactToCommentFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const UnreactToCommentFailure.unknown([this.cause]) : type = UnreactToCommentFailureType.unknown;

  final UnreactToCommentFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case UnreactToCommentFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'UnreactToCommentFailure{type: $type, cause: $cause}';
}

enum UnreactToCommentFailureType {
  unknown,
}
