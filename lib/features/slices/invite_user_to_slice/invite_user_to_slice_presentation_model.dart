import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/presentation/selectable_public_profile.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_initial_params.dart';

class InviteUserToSlicePresentationModel implements InviteUserToSliceViewModel {
  /// Creates the initial state
  InviteUserToSlicePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    InviteUserToSliceInitialParams initialParams,
  )   : searchText = '',
        onInviteUserResult = const FutureResult.empty(),
        circleId = initialParams.circleId,
        users = const PaginatedList.empty();

  /// Used for the copyWith method
  InviteUserToSlicePresentationModel._({
    required this.searchText,
    required this.onInviteUserResult,
    required this.circleId,
    required this.users,
  });

  final String searchText;

  final FutureResult<void> onInviteUserResult;

  @override
  final PaginatedList<Selectable<PublicProfile>> users;

  @override
  final Id circleId;

  Cursor get cursor => users.nextPageCursor();

  InviteUserToSlicePresentationModel byAppendingUsersList(PaginatedList<PublicProfile> newList) => copyWith(
        users: users + newList.mapItems((item) => item.toSelectable()),
      );

  InviteUserToSlicePresentationModel bySelectingUser(PublicProfile profile) => copyWith(
        users: users.byUpdatingItem(
          update: (user) => user.copyWith(selected: true),
          itemFinder: (user) => user.item == profile,
        ),
      );

  InviteUserToSlicePresentationModel copyWith({
    String? searchText,
    FutureResult<void>? onInviteUserResult,
    Id? circleId,
    PaginatedList<Selectable<PublicProfile>>? users,
  }) {
    return InviteUserToSlicePresentationModel._(
      searchText: searchText ?? this.searchText,
      onInviteUserResult: onInviteUserResult ?? this.onInviteUserResult,
      circleId: circleId ?? this.circleId,
      users: users ?? this.users,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class InviteUserToSliceViewModel {
  PaginatedList<Selectable<PublicProfile>> get users;

  Id get circleId;
}
