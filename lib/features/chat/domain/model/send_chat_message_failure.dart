import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class SendChatMessageFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const SendChatMessageFailure.unknown([this.cause]) : type = SendChatMessageFailureType.unknown;

  const SendChatMessageFailure.permissionDenied([this.cause]) : type = SendChatMessageFailureType.permissionDenied;

  const SendChatMessageFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = SendChatMessageFailureType.chatDoesNotExist;

  final SendChatMessageFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case SendChatMessageFailureType.unknown:
      case SendChatMessageFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
      case SendChatMessageFailureType.permissionDenied:
        return DisplayableFailure.commonError(appLocalizations.chattingDisabled);
    }
  }

  @override
  String toString() => 'SendChatMessageFailure{type: $type, cause: $cause}';
}

enum SendChatMessageFailureType {
  unknown,
  chatDoesNotExist,
  permissionDenied,
}
