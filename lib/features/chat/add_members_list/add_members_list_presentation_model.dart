import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/search_users_failure.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/presentation/selectable_public_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AddMembersListPresentationModel implements AddMembersListViewModel {
  /// Creates the initial state
  AddMembersListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    AddMembersListInitialParams initialParams,
  )   : searchText = '',
        onAddUser = initialParams.onAddUser,
        onAddUserResult = const FutureResult.empty(),
        users = const PaginatedList.empty(),
        searchUsersOperation = null;

  /// Used for the copyWith method
  AddMembersListPresentationModel._({
    required this.searchText,
    required this.onAddUser,
    required this.onAddUserResult,
    required this.users,
    required this.searchUsersOperation,
  });

  final String searchText;

  final Future<bool> Function(User) onAddUser;

  final FutureResult<void> onAddUserResult;

  final CancelableOperation<Either<SearchUsersFailure, PaginatedList<PublicProfile>>>? searchUsersOperation;

  @override
  final PaginatedList<Selectable<PublicProfile>> users;

  Cursor get cursor => users.nextPageCursor();

  AddMembersListPresentationModel byAppendingUsersList(PaginatedList<PublicProfile> newList) => copyWith(
        users: users + newList.mapItems((item) => item.toSelectable()),
      );

  AddMembersListPresentationModel bySelectingUser(PublicProfile profile) => copyWith(
        users: users.byUpdatingItem(
          update: (user) => user.copyWith(selected: true),
          itemFinder: (user) => user.item == profile,
        ),
      );

  AddMembersListPresentationModel copyWith({
    String? searchText,
    Future<bool> Function(User)? onAddUser,
    FutureResult<void>? onAddUserResult,
    PaginatedList<Selectable<PublicProfile>>? users,
    CancelableOperation<Either<SearchUsersFailure, PaginatedList<PublicProfile>>>? searchUsersOperation,
  }) {
    return AddMembersListPresentationModel._(
      searchText: searchText ?? this.searchText,
      onAddUser: onAddUser ?? this.onAddUser,
      onAddUserResult: onAddUserResult ?? this.onAddUserResult,
      users: users ?? this.users,
      searchUsersOperation: searchUsersOperation ?? this.searchUsersOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AddMembersListViewModel {
  PaginatedList<Selectable<PublicProfile>> get users;
}
