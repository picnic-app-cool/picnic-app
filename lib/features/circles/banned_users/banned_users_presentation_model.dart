import 'package:async/async.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_initial_params.dart';

import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/get_banned_users_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class BannedUsersPresentationModel implements BannedUsersViewModel {
  /// Creates the initial state
  BannedUsersPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    BannedUsersInitialParams initialParams,
    this.currentTimeProvider,
  )   : circle = initialParams.circle,
        bannedUsers = const PaginatedList.empty(),
        getBannedUsersOperation = null;

  /// Used for the copyWith method
  BannedUsersPresentationModel._({
    required this.currentTimeProvider,
    required this.circle,
    required this.bannedUsers,
    required this.getBannedUsersOperation,
  });

  @override
  final PaginatedList<BannedUser> bannedUsers;

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final Circle circle;

  final CancelableOperation<Either<GetBannedUsersFailure, PaginatedList<BannedUser>>>? getBannedUsersOperation;

  Cursor get bannedUsersCursor => bannedUsers.nextPageCursor();

  BannedUsersPresentationModel byRemovingBan(BannedUser bannedUser) => copyWith(
        bannedUsers: bannedUsers.byRemoving(element: bannedUser),
      );

  BannedUsersPresentationModel byAppendingBannedList(
    PaginatedList<BannedUser> newList,
  ) =>
      copyWith(
        bannedUsers: bannedUsers + newList,
      );

  BannedUsersPresentationModel copyWith({
    CurrentTimeProvider? currentTimeProvider,
    Circle? circle,
    PaginatedList<BannedUser>? bannedUsers,
    CancelableOperation<Either<GetBannedUsersFailure, PaginatedList<BannedUser>>>? getBannedUsersOperation,
  }) {
    return BannedUsersPresentationModel._(
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      circle: circle ?? this.circle,
      bannedUsers: bannedUsers ?? this.bannedUsers,
      getBannedUsersOperation: getBannedUsersOperation ?? this.getBannedUsersOperation,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class BannedUsersViewModel {
  Circle get circle;

  PaginatedList<BannedUser> get bannedUsers;

  CurrentTimeProvider get currentTimeProvider;
}
