import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_related_messages_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_reports_repository.dart';

class GetRelatedMessagesUseCase {
  const GetRelatedMessagesUseCase(this._circleReportsRepository);

  // ignore: unused_element
  final CircleReportsRepository _circleReportsRepository;

  Future<Either<GetRelatedMessagesFailure, List<ChatMessage>>> execute({
    required Id messageId,
    required int relatedMessagesCount,
  }) async =>
      _circleReportsRepository.getRelatedMessages(
        messageId: messageId,
        relatedMessagesCount: relatedMessagesCount,
      );
}
