import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/features/profile/public_profile/profile_bottom_sheet_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ProfileBottomSheetPresentationModel implements ProfileBottomSheetViewModel {
  /// Creates the initial state
  ProfileBottomSheetPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ProfileBottomSheetInitialParams initialParams,
    UserStore userStore,
  )   : userResult = const FutureResult.empty(),
        publicProfile = const PublicProfile.empty(),
        profileStatsResult = const FutureResult.empty(),
        profileStats = const ProfileStats.empty(),
        action = PublicProfileAction.follow,
        userId = initialParams.userId,
        privateProfile = userStore.privateProfile,
        followResult = const FutureResult.empty();

  /// Used for the copyWith method
  ProfileBottomSheetPresentationModel._({
    required this.action,
    required this.userResult,
    required this.userId,
    required this.publicProfile,
    required this.privateProfile,
    required this.followResult,
    required this.profileStatsResult,
    required this.profileStats,
  });

  final FutureResult<Either<GetUserFailure, PublicProfile>> userResult;
  final FutureResult<Either<GetProfileStatsFailure, ProfileStats>> profileStatsResult;

  final PrivateProfile privateProfile;

  @override
  final PublicProfile publicProfile;

  final Id userId;

  @override
  final ProfileStats profileStats;

  @override
  final PublicProfileAction action;

  @override
  final FutureResult<void> followResult;

  @override
  bool get isLoadingUser => userResult.isPending();

  @override
  bool get isLoadingProfileStats => profileStatsResult.isPending();

  @override
  bool get isBlocked => publicProfile.isBlocked;

  List<Id> get singleChatUserIds => List.unmodifiable([privateProfile.id, userId]);

  ProfileBottomSheetPresentationModel byUpdatingPublicProfile({
    required PublicProfile publicProfile,
  }) =>
      copyWith(publicProfile: publicProfile);

  ProfileBottomSheetPresentationModel byUpdatingProfileStats({
    required ProfileStats profileStats,
  }) =>
      copyWith(profileStats: profileStats);

  ProfileBottomSheetPresentationModel copyWith({
    FutureResult<Either<GetUserFailure, PublicProfile>>? userResult,
    FutureResult<Either<GetProfileStatsFailure, ProfileStats>>? profileStatsResult,
    ProfileStats? profileStats,
    PrivateProfile? privateProfile,
    Id? userId,
    PublicProfileAction? action,
    PublicProfile? publicProfile,
    FutureResult<void>? followResult,
  }) {
    return ProfileBottomSheetPresentationModel._(
      userResult: userResult ?? this.userResult,
      profileStatsResult: profileStatsResult ?? this.profileStatsResult,
      profileStats: profileStats ?? this.profileStats,
      privateProfile: privateProfile ?? this.privateProfile,
      userId: userId ?? this.userId,
      publicProfile: publicProfile ?? this.publicProfile,
      followResult: followResult ?? this.followResult,
      action: action ?? this.action,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class ProfileBottomSheetViewModel {
  PublicProfile get publicProfile;

  PublicProfileAction get action;

  bool get isLoadingUser;

  bool get isLoadingProfileStats;

  bool get isBlocked;

  FutureResult<void> get followResult;

  ProfileStats get profileStats;
}
