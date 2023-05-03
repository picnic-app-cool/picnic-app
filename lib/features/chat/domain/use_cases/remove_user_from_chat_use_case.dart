import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/remove_user_from_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';

class RemoveUserFromChatUseCase {
  const RemoveUserFromChatUseCase(this._chatSettingsRepository);

  final ChatSettingsRepository _chatSettingsRepository;

  Future<Either<RemoveUserFromChatFailure, Unit>> execute({
    required Id chatId,
    required Id userId,
  }) async {
    return _chatSettingsRepository.removeUserFromChat(
      chatId: chatId,
      userId: userId,
    );
  }
}
