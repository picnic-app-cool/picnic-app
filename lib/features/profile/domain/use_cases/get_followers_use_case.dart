import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/get_followers_failure.dart';

class GetFollowersUseCase {
  GetFollowersUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Either<GetFollowersFailure, PaginatedList<PublicProfile>>> execute({
    required Id userId,
    required String searchQuery,
    required Cursor nextPageCursor,
  }) {
    return _usersRepository.getFollowers(
      userId: userId,
      searchQuery: searchQuery,
      nextPageCursor: nextPageCursor,
    );
  }
}
