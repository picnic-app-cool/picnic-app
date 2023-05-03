import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/update_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';

class UpdateChatNameUseCase {
  const UpdateChatNameUseCase(this._chatSettingsRepository);

  final ChatSettingsRepository _chatSettingsRepository;

  Future<Either<UpdateChatSettingsFailure, Unit>> execute({
    required Id chatId,
    required String name,
  }) async {
    return _chatSettingsRepository.updateChatName(
      chatId: chatId,
      name: name,
    );
  }
}
