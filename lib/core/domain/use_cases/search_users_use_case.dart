import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/search_users_failure.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/utils/extensions/object_extension.dart';

class SearchUsersUseCase {
  const SearchUsersUseCase(
    this._usersRepository,
    this._userStore,
  );

  final UsersRepository _usersRepository;
  final UserStore _userStore;

  Future<Either<SearchUsersFailure, PaginatedList<PublicProfile>>> execute({
    required String query,
    required Cursor nextPageCursor,
    bool ignoreMyself = false,
  }) =>
      _usersRepository
          .searchUser(
            searchQuery: query,
            nextPageCursor: nextPageCursor,
          )
          .mapSuccess(
            (users) => ignoreMyself
                ? _userStore.privateProfile.user.id.let(
                    (myId) => users.byRemovingWhere(
                      (user) => user.id == myId,
                    ),
                  )
                : users,
          );
}
