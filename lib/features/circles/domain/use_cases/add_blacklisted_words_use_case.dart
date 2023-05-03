import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/add_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class AddBlacklistedWordsUseCase {
  const AddBlacklistedWordsUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<AddBlacklistedWordsFailure, Unit>> execute({
    required Id circleId,
    required String words,
  }) {
    final wordsList = words
        .split(',') //
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    return _circleModeratorActionsRepository.addBlackListedWords(
      circleId: circleId,
      words: wordsList,
    );
  }
}
