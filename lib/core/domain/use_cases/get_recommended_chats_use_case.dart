import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_recommended_chats_failure.dart';
import 'package:picnic_app/core/domain/model/get_recommended_chats_input.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class GetRecommendedChatsUseCase {
  const GetRecommendedChatsUseCase(
    this._chatRepository,
  );

  final ChatRepository _chatRepository;

  Future<Either<GetRecommendedChatsFailure, PaginatedList<Chat>>> execute({
    required GetRecommendedChatsInput input,
  }) {
    return _chatRepository //
        .getRecommendedChats(input: input);
  }
}
