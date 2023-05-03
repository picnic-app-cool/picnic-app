import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DeletePostsFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeletePostsFailure.unknown([this.cause]) : type = DeletePostsFailureType.unknown;

  final DeletePostsFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeletePostsFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DeletePostsFailure{type: $type, cause: $cause}';
}

enum DeletePostsFailureType {
  unknown,
}
