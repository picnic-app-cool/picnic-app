import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/search_users_failure.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/circles/ban_user_list/ban_user_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class BanUserListPresentationModel implements BanUserListViewModel {
  /// Creates the initial state
  BanUserListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    BanUserListInitialParams initialParams,
  )   : circle = initialParams.circle,
        usersList = const PaginatedList.empty(),
        searchQuery = '',
        searchUsersOperation = null;

  /// Used for the copyWith method
  BanUserListPresentationModel._({
    required this.circle,
    required this.usersList,
    required this.searchQuery,
    required this.searchUsersOperation,
  });

  @override
  final Circle circle;

  @override
  final PaginatedList<PublicProfile> usersList;

  @override
  final String searchQuery;

  final CancelableOperation<Either<SearchUsersFailure, PaginatedList<PublicProfile>>>? searchUsersOperation;

  Cursor get cursor => usersList.nextPageCursor();

  BanUserListPresentationModel byBanUser(User user) => copyWith(
        usersList: usersList.byRemovingWhere((bannedUser) => bannedUser.id == user.id),
      );

  BanUserListPresentationModel byAppendingUsersList(PaginatedList<PublicProfile> newList) {
    final list = usersList + newList;
    return copyWith(usersList: list);
  }

  BanUserListPresentationModel copyWith({
    Circle? circle,
    PaginatedList<PublicProfile>? usersList,
    String? searchQuery,
    CancelableOperation<Either<SearchUsersFailure, PaginatedList<PublicProfile>>>? searchUsersOperation,
  }) {
    return BanUserListPresentationModel._(
      circle: circle ?? this.circle,
      usersList: usersList ?? this.usersList,
      searchQuery: searchQuery ?? this.searchQuery,
      searchUsersOperation: searchUsersOperation ?? this.searchUsersOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class BanUserListViewModel {
  PaginatedList<PublicProfile> get usersList;

  Circle get circle;

  String get searchQuery;
}
