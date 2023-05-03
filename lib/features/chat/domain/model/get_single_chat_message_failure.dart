import 'package:picnic_app/core/domain/model/displayable_failure.dart';

class GetSingleChatMessageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetSingleChatMessageFailure.unknown([this.cause]) : type = GetChatMessageFailureType.unknown;

  const GetSingleChatMessageFailure.chatDoesNotExist([this.cause]) : type = GetChatMessageFailureType.chatDoesNotExist;

  const GetSingleChatMessageFailure.messageDoesNotExist([this.cause])
      : type = GetChatMessageFailureType.messageDoesNotExist;

  final GetChatMessageFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatMessageFailureType.unknown:
      case GetChatMessageFailureType.chatDoesNotExist:
      case GetChatMessageFailureType.messageDoesNotExist:
        return DisplayableFailure.commonError();
    }
  }

  @override
  String toString() => 'GetChatMessageFailure{type: $type, cause: $cause}';
}

enum GetChatMessageFailureType {
  unknown,
  chatDoesNotExist,
  messageDoesNotExist,
}
