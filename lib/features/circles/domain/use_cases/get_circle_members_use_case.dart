import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/get_circle_members_failure.dart';
import 'package:picnic_app/utils/extensions/object_extension.dart';

class GetCircleMembersUseCase {
  const GetCircleMembersUseCase(
    this._circlesRepository,
    this._userStore,
  );

  final CirclesRepository _circlesRepository;
  final UserStore _userStore;

  Future<Either<GetCircleMembersFailure, PaginatedList<PublicProfile>>> execute({
    required Id circleId,
    required Cursor cursor,
    bool ignoreMyself = false,
    String searchQuery = '',
  }) async {
    return _circlesRepository
        .getCircleMembers(
          circleId: circleId,
          cursor: cursor,
          searchQuery: searchQuery,
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
}
