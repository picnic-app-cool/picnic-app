import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/presentation/selectable_public_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/search_non_member_users_failure.dart';
import 'package:picnic_app/features/circles/invite_user_list/invite_user_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class InviteUserListPresentationModel implements InviteUserListViewModel {
  /// Creates the initial state
  InviteUserListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    InviteUserListInitialParams initialParams,
  )   : searchText = '',
        onInviteUserResult = const FutureResult.empty(),
        circleId = initialParams.circleId,
        users = const PaginatedList.empty(),
        searchMembersOperation = null;

  /// Used for the copyWith method
  InviteUserListPresentationModel._({
    required this.searchText,
    required this.onInviteUserResult,
    required this.circleId,
    required this.users,
    required this.searchMembersOperation,
  });

  final String searchText;

  final FutureResult<void> onInviteUserResult;

  final CancelableOperation<Either<SearchNonMemberUsersFailure, PaginatedList<PublicProfile>>>? searchMembersOperation;

  @override
  final PaginatedList<Selectable<PublicProfile>> users;

  @override
  final Id circleId;

  Cursor get cursor => users.nextPageCursor();

  InviteUserListPresentationModel byAppendingUsersList(PaginatedList<PublicProfile> newList) => copyWith(
        users: users + newList.mapItems((item) => item.toSelectable()),
      );

  InviteUserListPresentationModel bySelectingUser(PublicProfile profile) => copyWith(
        users: users.byUpdatingItem(
          update: (user) => user.copyWith(selected: true),
          itemFinder: (user) => user.item == profile,
        ),
      );

  InviteUserListPresentationModel copyWith({
    String? searchText,
    FutureResult<void>? onInviteUserResult,
    Id? circleId,
    PaginatedList<Selectable<PublicProfile>>? users,
    CancelableOperation<Either<SearchNonMemberUsersFailure, PaginatedList<PublicProfile>>>? searchMembersOperation,
  }) {
    return InviteUserListPresentationModel._(
      searchText: searchText ?? this.searchText,
      onInviteUserResult: onInviteUserResult ?? this.onInviteUserResult,
      circleId: circleId ?? this.circleId,
      users: users ?? this.users,
      searchMembersOperation: searchMembersOperation ?? this.searchMembersOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class InviteUserListViewModel {
  PaginatedList<Selectable<PublicProfile>> get users;

  Id get circleId;
}
