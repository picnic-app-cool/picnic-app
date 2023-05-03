import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/mark_message_as_read_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';

class MarkMessageAsReadUseCase {
  const MarkMessageAsReadUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<MarkMessageAsReadFailure, Unit>> execute({required Id? lastSeenMessageId}) async {
    if (lastSeenMessageId == null) {
      logError("Last seen massage id is null");
      return success(unit);
    } else {
      return _repository.markMessageAsRead(lastSeenMessageId: lastSeenMessageId);
    }
  }
}
