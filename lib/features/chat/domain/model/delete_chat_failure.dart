import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DeleteChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteChatFailure.unknown([this.cause]) : type = DeleteChatFailureType.unknown;

  final DeleteChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteChatFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DeleteChatFailure{type: $type, cause: $cause}';
}

enum DeleteChatFailureType {
  unknown,
}
