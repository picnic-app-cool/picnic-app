import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';

class GetChatSettingsUseCase {
  const GetChatSettingsUseCase(this._chatSettingsRepository);

  final ChatSettingsRepository _chatSettingsRepository;

  Future<Either<GetChatSettingsFailure, ChatSettings>> execute({
    required Id chatId,
  }) async {
    return _chatSettingsRepository.getChatSettings(
      chatId: chatId,
    );
  }
}
