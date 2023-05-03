import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class ChatMessagesFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const ChatMessagesFailure.unknown([this.cause]) : type = ChatMessagesFailureType.unknown;

  final ChatMessagesFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case ChatMessagesFailureType.unknown:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'ChatMessagesFailure{type: $type, cause: $cause}';
}

enum ChatMessagesFailureType {
  unknown,
}
