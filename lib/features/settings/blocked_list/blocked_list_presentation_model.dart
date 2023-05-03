import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class BlockedListPresentationModel implements BlockedListViewModel {
  /// Creates the initial state
  BlockedListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    BlockedListInitialParams initialParams,
  ) : users = const PaginatedList.empty();

  /// Used for the copyWith method
  BlockedListPresentationModel._({
    required this.users,
  });

  @override
  final PaginatedList<PublicProfile> users;

  Cursor get cursor => users.nextPageCursor();

  BlockedListPresentationModel copyWith({
    PaginatedList<PublicProfile>? users,
  }) =>
      BlockedListPresentationModel._(
        users: users ?? this.users,
      );

  BlockedListPresentationModel byAppendingBlockedList({
    required PaginatedList<PublicProfile> newList,
  }) =>
      copyWith(
        users: users + newList,
      );

  BlockedListPresentationModel byUpdateBlockAction(PublicProfile blockedProfile) => copyWith(
        users: users.byUpdatingItem(
          update: (update) => update.copyWith(isBlocked: !update.isBlocked),
          itemFinder: (finder) => blockedProfile.id == finder.id,
        ),
      );
}

/// Interface to expose fields used by the view (page).
abstract class BlockedListViewModel {
  PaginatedList<PublicProfile> get users;
}
