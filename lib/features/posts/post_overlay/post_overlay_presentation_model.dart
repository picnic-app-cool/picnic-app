import 'package:dartz/dartz.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_display_options.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_mediator.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

final _heartNeverAnimatedDateTime = DateTime(-1);

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostOverlayPresentationModel implements PostOverlayViewModel {
  /// Creates the initial state
  PostOverlayPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostOverlayInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    UserStore userStore,
  )   : post = initialParams.post,
        messenger = initialParams.messenger,
        savePostResult = const FutureResult.empty(),
        featureFlags = featureFlagsStore.featureFlags,
        privateProfile = userStore.privateProfile,
        commentBarHeight = 0,
        replyingComment = const CommentPreview.empty(),
        comments = [],
        circleId = initialParams.circleId,
        reportId = initialParams.reportId,
        heartLastAnimatedAt = _heartNeverAnimatedDateTime,
        maxCommentsCount = initialParams.maxCommentsCount ?? Constants.defaultCommentsPreviewCount,
        videoControlsVisible = false,
        displayOptions = initialParams.displayOptions,
        onTapCommentsInHorizontalMode = null,
        onCommentsDrawerClosed = null,
        onTapBack = null;

  /// Used for the copyWith method
  PostOverlayPresentationModel._({
    required this.post,
    required this.messenger,
    required this.savePostResult,
    required this.featureFlags,
    required this.commentBarHeight,
    required this.comments,
    required this.privateProfile,
    required this.replyingComment,
    required this.reportId,
    required this.circleId,
    required this.heartLastAnimatedAt,
    required this.maxCommentsCount,
    required this.videoControlsVisible,
    required this.onTapCommentsInHorizontalMode,
    required this.onTapBack,
    required this.displayOptions,
    required this.onCommentsDrawerClosed,
  });

  final FutureResult<Either<SavePostToCollectionFailure, Post>> savePostResult;

  final PostOverlayMediator messenger;
  final FeatureFlags featureFlags;

  final double commentBarHeight;

  final PrivateProfile privateProfile;

  @override
  final PostDisplayOptions displayOptions;

  @override
  final Post post;

  @override
  final Id circleId;

  @override
  final Id reportId;

  @override
  final List<CommentPreview> comments;

  @override
  final CommentPreview replyingComment;

  @override
  final DateTime heartLastAnimatedAt;

  @override
  final VoidCallback? onTapCommentsInHorizontalMode;

  @override
  final VoidCallback? onTapBack;

  @override
  final VoidCallback? onCommentsDrawerClosed;

  final int maxCommentsCount;

  final bool videoControlsVisible;

  @override
  bool get shouldCommentsBeVisible => featureFlags[FeatureFlagType.postOverlayCommentsEnabled] && !videoControlsVisible;

  @override
  bool get isPostSaving => savePostResult.isPending();

  @override
  BasicPublicProfile get author => post.author;

  @override
  bool get showReportAction => displayOptions.detailsMode == PostDetailsMode.report;

  @override
  bool get savedPostsEnabled => featureFlags[FeatureFlagType.savedPostsEnabled];

  @override
  bool get showSavePostToCollection => featureFlags[FeatureFlagType.collectionsEnabled];

  PostOverlayViewModel byUpdatingLikeStatus({required bool iReacted}) {
    return copyWith(
      post: post.byUpdatingLikeStatus(
        iReacted: iReacted,
      ),
    );
  }

  PostOverlayViewModel byUpdatingSavedStatus({required bool iSaved}) {
    return copyWith(
      post: post.byUpdatingSavedStatus(
        iSaved: iSaved,
      ),
    );
  }

  PostOverlayViewModel byUpdatingJoinedStatus({required bool iJoined}) {
    return copyWith(
      post: post.copyWith(
        circle: post.circle.copyWith(iJoined: iJoined),
      ),
    );
  }

  PostOverlayViewModel byUpdatingShareStatus() {
    return copyWith(
      post: post.byIncrementingShareCount(),
    );
  }

  PostOverlayViewModel byUpdatingCommentStatus({
    required Id id,
    required bool isLiked,
  }) {
    return copyWith(
      comments: comments.byUpdatingItem(
        update: (update) => update.copyWith(isLiked: isLiked),
        itemFinder: (finder) => id == finder.id,
      ),
    );
  }

  PostOverlayViewModel byRemovingComment(CommentPreview comment) {
    return copyWith(
      comments: comments.where((e) => e != comment).toList(),
    );
  }

  PostOverlayViewModel byUpdatingCommentWithId(Id id, CommentPreview Function(CommentPreview comment) update) {
    return copyWith(
      comments: comments.byUpdatingItem(update: update, itemFinder: (it) => it.id == id),
    );
  }

  PostOverlayViewModel byUpdatingAuthorWithFollow({required bool follow}) {
    return copyWith(
      post: post.copyWith(
        author: author.copyWith(iFollow: follow),
      ),
    );
  }

  PostOverlayPresentationModel copyWith({
    FutureResult<Either<SavePostToCollectionFailure, Post>>? savePostResult,
    PostOverlayMediator? messenger,
    FeatureFlags? featureFlags,
    double? commentBarHeight,
    PrivateProfile? privateProfile,
    PostDisplayOptions? displayOptions,
    Post? post,
    Id? circleId,
    Id? reportId,
    List<CommentPreview>? comments,
    CommentPreview? replyingComment,
    DateTime? heartLastAnimatedAt,
    VoidCallback? onTapCommentsInHorizontalMode,
    VoidCallback? onTapBack,
    VoidCallback? onCommentsDrawerClosed,
    int? maxCommentsCount,
    bool? videoControlsVisible,
  }) {
    return PostOverlayPresentationModel._(
      savePostResult: savePostResult ?? this.savePostResult,
      messenger: messenger ?? this.messenger,
      featureFlags: featureFlags ?? this.featureFlags,
      commentBarHeight: commentBarHeight ?? this.commentBarHeight,
      privateProfile: privateProfile ?? this.privateProfile,
      displayOptions: displayOptions ?? this.displayOptions,
      post: post ?? this.post,
      circleId: circleId ?? this.circleId,
      reportId: reportId ?? this.reportId,
      comments: comments ?? this.comments,
      replyingComment: replyingComment ?? this.replyingComment,
      heartLastAnimatedAt: heartLastAnimatedAt ?? this.heartLastAnimatedAt,
      onTapCommentsInHorizontalMode: onTapCommentsInHorizontalMode ?? this.onTapCommentsInHorizontalMode,
      onTapBack: onTapBack ?? this.onTapBack,
      maxCommentsCount: maxCommentsCount ?? this.maxCommentsCount,
      videoControlsVisible: videoControlsVisible ?? this.videoControlsVisible,
      onCommentsDrawerClosed: onCommentsDrawerClosed ?? this.onCommentsDrawerClosed,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostOverlayViewModel {
  BasicPublicProfile get author;

  List<CommentPreview> get comments;

  Post get post;

  Id get circleId;

  Id get reportId;

  bool get showReportAction;

  bool get isPostSaving;

  bool get savedPostsEnabled;

  CommentPreview get replyingComment;

  DateTime get heartLastAnimatedAt;

  bool get shouldCommentsBeVisible;

  VoidCallback? get onTapCommentsInHorizontalMode;

  VoidCallback? get onTapBack;

  PostDisplayOptions get displayOptions;

  VoidCallback? get onCommentsDrawerClosed;

  bool get showSavePostToCollection;
}
