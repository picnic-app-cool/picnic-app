import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/get_single_chat_recipient_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_participants_use_case.dart';

class GetSingleChatRecipientUseCase {
  const GetSingleChatRecipientUseCase(this._getChatParticipantsUseCase, this._userStore);

  final GetChatParticipantsUseCase _getChatParticipantsUseCase;
  final UserStore _userStore;

  Future<Either<GetSingleChatRecipientFailure, User>> execute({
    required Id chatId,
  }) async =>
      _getChatParticipantsUseCase
          .execute(
            chatId: chatId,
            nextPageCursor: const Cursor.empty(),
          )
          .mapFailure((failure) => const GetSingleChatRecipientFailure.unknown())
          .mapSuccess(
            (users) => _filterRecipient(users.items),
          );

  User _filterRecipient(List<User> users) {
    final list = users.where((it) => it.id != _userStore.privateProfile.id);
    return list.isNotEmpty ? list.first : const User.empty();
  }
}
