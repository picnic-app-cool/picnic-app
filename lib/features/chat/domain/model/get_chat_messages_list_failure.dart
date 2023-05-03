import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetChatMessagesListFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatMessagesListFailure.unknown([this.cause]) : type = GetChatMessagesListFailureType.unknown;

  const GetChatMessagesListFailure.chatDoesNotExist([this.cause])
      : type = GetChatMessagesListFailureType.chatDoesNotExist;

  final GetChatMessagesListFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatMessagesListFailureType.unknown:
      case GetChatMessagesListFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatMessagesFailure{type: $type, cause: $cause}';
}

enum GetChatMessagesListFailureType {
  unknown,
  chatDoesNotExist,
}
