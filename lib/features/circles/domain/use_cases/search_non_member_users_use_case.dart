import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/search_non_member_users_failure.dart';

class SearchNonMemberUsersUseCase {
  const SearchNonMemberUsersUseCase(this._usersRepository);

  final UsersRepository _usersRepository;

  Future<Either<SearchNonMemberUsersFailure, PaginatedList<PublicProfile>>> execute({
    required String searchQuery,
    required Id circleId,
    required Cursor cursor,
    List<PublicProfile> invited = const [],
  }) async {
    return _usersRepository
        .searchNonMembershipUsers(
      searchQuery: searchQuery,
      circleId: circleId,
      nextPageCursor: cursor,
    )
        .mapSuccess((users) {
      users.removeWhere((user) => invited.contains(user));
      return users;
    });
  }
}
