import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_participants_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';

class GetChatParticipantsUseCase {
  const GetChatParticipantsUseCase(this._repository);

  final ChatSettingsRepository _repository;

  Future<Either<GetChatParticipantsFailure, PaginatedList<User>>> execute({
    required Id chatId,
    required Cursor nextPageCursor,
  }) async =>
      _repository.getChatParticipants(
        chatId: chatId,
        nextPageCursor: nextPageCursor,
      );
}
