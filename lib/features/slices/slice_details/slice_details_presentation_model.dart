import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/features/slices/domain/model/slice_details_tab.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SliceDetailsPresentationModel implements SliceDetailsViewModel {
  /// Creates the initial state
  SliceDetailsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SliceDetailsInitialParams initialParams,
  )   : selectedTab = SliceDetailsTab.members,
        slice = initialParams.slice,
        sliceRole = initialParams.slice.sliceRole,
        moderators = const PaginatedList.empty(),
        users = const PaginatedList.empty(),
        searchQuery = '',
        circle = initialParams.circle;

  /// Used for the copyWith method
  SliceDetailsPresentationModel._({
    required this.selectedTab,
    required this.slice,
    required this.circle,
    required this.moderators,
    required this.users,
    required this.sliceRole,
    required this.searchQuery,
  });

  final Slice slice;
  final Circle circle;

  @override
  final String searchQuery;

  @override
  final SliceDetailsTab selectedTab;

  @override
  final PaginatedList<SliceMember> moderators;

  @override
  final PaginatedList<SliceMember> users;

  @override
  final SliceRole sliceRole;

  @override
  List<SliceDetailsTab> get tabs {
    return [
      SliceDetailsTab.members,
      SliceDetailsTab.circleInfo,
      SliceDetailsTab.rules,
    ];
  }

  @override
  bool get iJoined => slice.iJoined;

  @override
  bool get canEditRules => circle.circleRole == CircleRole.director || circle.circleRole == CircleRole.moderator;

  @override
  bool get iRequestedToJoin => slice.iRequestedToJoin;

  @override
  String get parentCircleName => circle.name;

  @override
  String get parentCircleEmoji => circle.emoji;

  @override
  String get parentCircleImage => circle.imageFile;

  @override
  String get parentCircleRules => circle.rulesText;

  @override
  String get sliceName => slice.name;

  @override
  String get rules => slice.rules;

  @override
  bool get isPrivate => slice.private;

  @override
  int get pendingRequestsCount => slice.pendingJoinRequestsCount;

  //TODO mod/director can approve requests https://picnic-app.atlassian.net/browse/GS-5349
  @override
  bool get canApproveRequests => true;

  @override
  bool get isLoading => false;

  @override
  bool get isContentHidden => !iJoined && isPrivate;

  Cursor get sliceModeratorCursor => moderators.nextPageCursor();

  Cursor get sliceUserCursor => users.nextPageCursor();

  SliceDetailsPresentationModel byAppendingModeratorsList(PaginatedList<SliceMember> newList) => copyWith(
        moderators: moderators + newList,
      );

  SliceDetailsPresentationModel byAppendingUsersList(PaginatedList<SliceMember> newList) => copyWith(
        users: users + newList,
      );

  SliceDetailsPresentationModel copyWith({
    SliceDetailsTab? selectedTab,
    Circle? circle,
    Slice? slice,
    PaginatedList<SliceMember>? moderators,
    PaginatedList<SliceMember>? users,
    SliceRole? sliceRole,
    String? searchQuery,
  }) {
    return SliceDetailsPresentationModel._(
      selectedTab: selectedTab ?? this.selectedTab,
      circle: circle ?? this.circle,
      slice: slice ?? this.slice,
      moderators: moderators ?? this.moderators,
      users: users ?? this.users,
      sliceRole: sliceRole ?? this.sliceRole,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  SliceDetailsPresentationModel byUpdatingSliceRules(String rules) => copyWith(slice: slice.copyWith(rules: rules));
}

/// Interface to expose fields used by the view (page).
abstract class SliceDetailsViewModel {
  SliceDetailsTab get selectedTab;

  List<SliceDetailsTab> get tabs;

  String get parentCircleRules;

  String get sliceName;

  String get parentCircleName;

  String get parentCircleEmoji;

  String get parentCircleImage;

  bool get iJoined;

  bool get iRequestedToJoin;

  bool get isPrivate;

  int get pendingRequestsCount;

  bool get canApproveRequests;

  PaginatedList<SliceMember> get moderators;

  PaginatedList<SliceMember> get users;

  bool get isLoading;

  SliceRole get sliceRole;

  String get searchQuery;

  String get rules;

  bool get canEditRules;

  bool get isContentHidden;
}
