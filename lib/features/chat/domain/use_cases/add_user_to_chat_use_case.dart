import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/add_user_to_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';

class AddUserToChatUseCase {
  const AddUserToChatUseCase(this._chatSettingsRepository);

  final ChatSettingsRepository _chatSettingsRepository;

  Future<Either<AddUserToChatFailure, Unit>> execute({
    required Id chatId,
    required Id userId,
  }) async {
    return _chatSettingsRepository.addUserToChat(
      chatId: chatId,
      userId: userId,
    );
  }
}
