import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/invite_user_to_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';

class InviteUsersToChatUseCase {
  const InviteUsersToChatUseCase(this._chatSettingsRepository);

  final ChatSettingsRepository _chatSettingsRepository;

  Future<Either<InviteUserToChatFailure, Unit>> execute({
    required Id chatId,
    required List<Id> userIds,
  }) async {
    return _chatSettingsRepository.inviteUserToChat(
      chatId: chatId,
      userIds: userIds,
    );
  }
}
