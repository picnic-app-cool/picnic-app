import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_blacklisted_words_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_moderator_actions_repository.dart';

class GetBlacklistedWordsUseCase {
  const GetBlacklistedWordsUseCase(this._circleModeratorActionsRepository);

  final CircleModeratorActionsRepository _circleModeratorActionsRepository;

  Future<Either<GetBlacklistedWordsFailure, PaginatedList<String>>> execute({
    required Id circleId,
    required Cursor cursor,
    String searchQuery = '',
  }) =>
      _circleModeratorActionsRepository.getBlackListedWords(
        circleId: circleId,
        cursor: cursor,
        searchQuery: searchQuery,
      );
}
