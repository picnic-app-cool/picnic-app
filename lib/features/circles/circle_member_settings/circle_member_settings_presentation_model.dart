import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_member_settings/circle_member_settings_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/domain/model/get_user_roles_in_circle_failure.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleMemberSettingsPresentationModel implements CircleMemberSettingsViewModel {
  /// Creates the initial state
  CircleMemberSettingsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleMemberSettingsInitialParams initialParams,
    UserStore userStore,
  )   : publicProfile = initialParams.user,
        privateProfile = userStore.privateProfile,
        circle = initialParams.circle,
        action = PublicProfileAction.follow,
        profileStatsResult = const FutureResult.empty(),
        profileStats = const ProfileStats.empty(),
        userResult = const FutureResult.empty(),
        followResult = const FutureResult.empty(),
        roles = [],
        getUserRolesResult = const FutureResult.empty();

  /// Used for the copyWith method
  CircleMemberSettingsPresentationModel._({
    required this.publicProfile,
    required this.circle,
    required this.action,
    required this.privateProfile,
    required this.profileStatsResult,
    required this.profileStats,
    required this.followResult,
    required this.userResult,
    required this.roles,
    required this.getUserRolesResult,
  });

  final FutureResult<Either<GetUserFailure, PublicProfile>> userResult;

  final PrivateProfile privateProfile;

  final FutureResult<Either<GetProfileStatsFailure, ProfileStats>> profileStatsResult;

  final FutureResult<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>> getUserRolesResult;

  @override
  final ProfileStats profileStats;

  final FutureResult<Either<FollowUnfollowUserFailure, Unit>> followResult;

  @override
  final PublicProfileAction action;

  @override
  final PublicProfile publicProfile;

  @override
  final List<CircleCustomRole> roles;

  final Circle circle;

  @override
  List<Id> get singleChatUserIds => List.unmodifiable([privateProfile.id, publicProfile.id]);

  @override
  bool get isLoadingUser => userResult.isPending();

  @override
  bool get hasPermissionToManageUsers => circle.hasPermissionToManageUsers;

  @override
  User get user => publicProfile.user;

  @override
  bool get isLoadingProfileStats => profileStatsResult.isPending();

  @override
  bool get isLoadingToggleFollow => followResult.isPending();

  @override
  bool get isBlocked => publicProfile.isBlocked;

  @override
  bool get isMe => privateProfile.isSameUser(userId: publicProfile.id);

  @override
  bool get isLoadingRoles => getUserRolesResult.isPending();

  @override
  List<CircleCustomRole> get rolesModified => roles.where((role) => role.name != 'default').toList();

  CircleMemberSettingsPresentationModel byUpdatingPublicProfile({
    required PublicProfile publicProfile,
  }) =>
      copyWith(publicProfile: publicProfile);

  CircleMemberSettingsPresentationModel byUpdatingProfileStats({
    required ProfileStats profileStats,
  }) =>
      copyWith(profileStats: profileStats);

  CircleMemberSettingsPresentationModel copyWith({
    PublicProfile? publicProfile,
    Circle? circle,
    PublicProfileAction? action,
    PrivateProfile? privateProfile,
    FutureResult<Either<GetProfileStatsFailure, ProfileStats>>? profileStatsResult,
    FutureResult<Either<FollowUnfollowUserFailure, Unit>>? followResult,
    ProfileStats? profileStats,
    FutureResult<Either<GetUserFailure, PublicProfile>>? userResult,
    List<CircleCustomRole>? roles,
    FutureResult<Either<GetUserRolesInCircleFailure, CircleMemberCustomRoles>>? getUserRolesResult,
  }) {
    return CircleMemberSettingsPresentationModel._(
      publicProfile: publicProfile ?? this.publicProfile,
      privateProfile: privateProfile ?? this.privateProfile,
      circle: circle ?? this.circle,
      action: action ?? this.action,
      profileStatsResult: profileStatsResult ?? this.profileStatsResult,
      profileStats: profileStats ?? this.profileStats,
      followResult: followResult ?? this.followResult,
      userResult: userResult ?? this.userResult,
      roles: roles ?? this.roles,
      getUserRolesResult: getUserRolesResult ?? this.getUserRolesResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleMemberSettingsViewModel {
  PublicProfile get publicProfile;

  User get user;

  bool get hasPermissionToManageUsers;

  PublicProfileAction get action;

  List<CircleCustomRole> get roles;

  List<CircleCustomRole> get rolesModified;

  bool get isLoadingProfileStats;

  List<Id> get singleChatUserIds;

  bool get isLoadingUser;

  bool get isLoadingToggleFollow;

  ProfileStats get profileStats;

  bool get isBlocked;

  bool get isMe;

  bool get isLoadingRoles;
}
