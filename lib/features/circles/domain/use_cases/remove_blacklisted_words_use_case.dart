import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/remove_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class RemoveBlacklistedWordsUseCase {
  const RemoveBlacklistedWordsUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<RemoveBlacklistedWordsFailure, Unit>> execute({
    required Id circleId,
    required List<String> words,
  }) =>
      _circleModeratorActionsRepository.removeBlacklistedWords(
        circleId: circleId,
        words: words,
      );
}
