import 'package:picnic_app/core/domain/model/displayable_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class GetChatFailure implements HasDisplayableFailure {
  // ignore: avoid_field_initializers_in_const_classes
  const GetChatFailure.unknown([this.cause]) : type = GetChatFailureType.unknown;

  const GetChatFailure.chatDoesNotExist(Id chatId)
      : cause = chatId,
        type = GetChatFailureType.chatDoesNotExist;

  // ignore: avoid_field_initializers_in_const_classes
  const GetChatFailure.forbiddenAccess([this.cause]) : type = GetChatFailureType.forbiddenAccess;

  final GetChatFailureType type;
  final Object? cause;

  @override
  DisplayableFailure displayableFailure() {
    switch (type) {
      case GetChatFailureType.unknown:
      case GetChatFailureType.chatDoesNotExist:
        return DisplayableFailure.commonError();
      case GetChatFailureType.forbiddenAccess:
        return DisplayableFailure(
          title: appLocalizations.commonErrorTitle,
          message: appLocalizations.userNotParticipantErrorMessage,
        );
    }
  }

  @override
  String toString() => 'GetChatFailure{type: $type, cause: $cause}';
}

enum GetChatFailureType {
  unknown,
  chatDoesNotExist,
  forbiddenAccess,
}
