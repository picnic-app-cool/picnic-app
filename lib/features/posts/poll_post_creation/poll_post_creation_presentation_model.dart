import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/images_poll_form.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PollPostCreationPresentationModel implements PollPostCreationViewModel {
  /// Creates the initial state
  PollPostCreationPresentationModel.initial(
    PollPostCreationInitialParams initialParams,
    FeatureFlagsStore featureFlags,
  )   : pollForm = const ImagesPollForm.empty(),
        featureFlags = featureFlags.featureFlags,
        onPostUpdatedCallback = initialParams.onTapPost,
        suggestedUsersToMention = const PaginatedList.empty(),
        mentionedUser = const UserMention.empty(),
        profileStats = const ProfileStats.empty(),
        circle = initialParams.circle;

  /// Used for the copyWith method
  PollPostCreationPresentationModel._({
    required this.pollForm,
    required this.onPostUpdatedCallback,
    required this.featureFlags,
    required this.suggestedUsersToMention,
    required this.mentionedUser,
    required this.profileStats,
    required this.circle,
  });

  final Function(CreatePostInput) onPostUpdatedCallback;

  @override
  final ImagesPollForm pollForm;

  @override
  final FeatureFlags featureFlags;

  @override
  final PaginatedList<UserMention> suggestedUsersToMention;

  @override
  final UserMention mentionedUser;

  @override
  final ProfileStats profileStats;

  final Circle? circle;

  @override
  bool get isButtonEnabled => pollForm.leftImagePath.isNotEmpty & pollForm.rightImagePath.isNotEmpty;

  @override
  bool get showAddSoundButton =>
      pollForm.sound == const Sound.empty() && featureFlags[FeatureFlagType.attachSoundsToPostsEnabled];

  @override
  bool get showSelectedSoundBadge =>
      pollForm.sound != const Sound.empty() && featureFlags[FeatureFlagType.attachSoundsToPostsEnabled];

  @override
  bool get isMentionsPollPostCreationEnabled => featureFlags[FeatureFlagType.mentionsPollPostCreationEnabled];

  @override
  String get circleName => circle?.name ?? '';

  @override
  bool get postingEnabled => circle?.pollPostingEnabled ?? true;

  CreatePostInput get createPostInput => pollForm.toCreatePostInput();

  PollPostCreationViewModel byUpdatingSuggestedUsersToMention({
    PaginatedList<UserMention>? suggestedUsersToMention,
  }) =>
      copyWith(
        suggestedUsersToMention: suggestedUsersToMention,
      );

  PollPostCreationPresentationModel copyWith({
    ImagesPollForm? pollForm,
    FeatureFlags? featureFlags,
    Function(CreatePostInput)? onPostUpdatedCallback,
    PaginatedList<UserMention>? suggestedUsersToMention,
    UserMention? mentionedUser,
    ProfileStats? profileStats,
    Circle? circle,
  }) {
    return PollPostCreationPresentationModel._(
      pollForm: pollForm ?? this.pollForm,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      featureFlags: featureFlags ?? this.featureFlags,
      suggestedUsersToMention: suggestedUsersToMention ?? this.suggestedUsersToMention,
      mentionedUser: mentionedUser ?? this.mentionedUser,
      profileStats: profileStats ?? this.profileStats,
      circle: circle ?? this.circle,
    );
  }

  PollPostCreationViewModel byUpdatingForm(
    ImagesPollForm Function(ImagesPollForm form) updater,
  ) =>
      copyWith(pollForm: updater(pollForm));
}

/// Interface to expose fields used by the view (page).
abstract class PollPostCreationViewModel {
  ImagesPollForm get pollForm;

  FeatureFlags get featureFlags;

  bool get showAddSoundButton;

  bool get showSelectedSoundBadge;

  bool get isButtonEnabled;

  bool get isMentionsPollPostCreationEnabled;

  PaginatedList<UserMention> get suggestedUsersToMention;

  UserMention get mentionedUser;

  ProfileStats get profileStats;

  bool get postingEnabled;

  String get circleName;
}
