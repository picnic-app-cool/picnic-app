//ignore_for_file: unused-code, unused-files
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/add_user_to_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/chat_settings.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_participants_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/invite_user_to_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/remove_user_from_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/update_chat_settings_failure.dart';

abstract class ChatSettingsRepository {
  Future<Either<UpdateChatSettingsFailure, Unit>> updateChatSettings({
    required Id chatId,
    required ChatSettings settings,
  });

  Future<Either<UpdateChatSettingsFailure, Unit>> updateChatName({
    required Id chatId,
    required String name,
  });

  Future<Either<GetChatSettingsFailure, ChatSettings>> getChatSettings({
    required Id chatId,
  });

  Future<Either<InviteUserToChatFailure, Unit>> inviteUserToChat({
    required Id chatId,
    required List<Id> userIds,
  });

  Future<Either<AddUserToChatFailure, Unit>> addUserToChat({
    required Id chatId,
    required Id userId,
  });

  Future<Either<RemoveUserFromChatFailure, Unit>> removeUserFromChat({
    required Id chatId,
    required Id userId,
  });

  Future<Either<GetChatParticipantsFailure, PaginatedList<User>>> getChatParticipants({
    required Id chatId,
    required Cursor nextPageCursor,
  });
}
