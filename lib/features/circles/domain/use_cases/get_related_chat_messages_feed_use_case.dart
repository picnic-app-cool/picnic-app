import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_feed.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_related_chat_messages_feed_failure.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_related_messages_use_case.dart';

class GetRelatedChatMessagesFeedUseCase {
  const GetRelatedChatMessagesFeedUseCase(
    this._getRelatedMessagesUseCase,
    this._getCircleDetailsUseCase,
  );

  final GetRelatedMessagesUseCase _getRelatedMessagesUseCase;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;

  Future<Either<GetRelatedChatMessagesFeedFailure, ChatMessagesFeed>> execute({
    required Id messageId,
    required int relatedMessagesCount,
    required Id circleId,
  }) async {
    return _getRelatedMessagesUseCase
        .execute(messageId: messageId, relatedMessagesCount: relatedMessagesCount)
        .mapFailure(GetRelatedChatMessagesFeedFailure.unknown)
        .flatMap((relatedMessages) {
      return _getCircleDetailsUseCase
          .execute(circleId: circleId)
          .mapFailure(GetRelatedChatMessagesFeedFailure.unknown)
          .mapSuccess(
            (circle) => ChatMessagesFeed(
              circle: circle,
              name: circle.name,
              membersCount: circle.membersCount,
              messages: relatedMessages,
            ),
          );
    });
  }
}
