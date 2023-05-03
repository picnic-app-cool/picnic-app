import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class DeleteChatMessageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const DeleteChatMessageFailure.unknown([this.cause]) : type = DeleteChatMessageFailureType.unknown;

  final DeleteChatMessageFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case DeleteChatMessageFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'DeleteChatMessageFailure{type: $type, cause: $cause}';
}

enum DeleteChatMessageFailureType {
  unknown,
}
