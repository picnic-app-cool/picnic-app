import 'package:picnic_app/core/domain/model/minimal_public_profile.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/text_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class TextPostProfilePresentationModel implements TextPostProfileViewModel {
  /// Creates the initial state
  TextPostProfilePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    TextPostProfileInitialParams initialParams,
    this.postOverlayViewModel,
  )   : postAuthor = initialParams.post.author,
        post = initialParams.post,
        onPostUpdatedCallback = initialParams.onPostUpdated,
        showTimestamp = initialParams.showTimestamp,
        showPostSummaryBarAbovePost = initialParams.showPostSummaryBarAbovePost;

  /// Used for the copyWith method
  TextPostProfilePresentationModel._({
    required this.postAuthor,
    required this.post,
    required this.onPostUpdatedCallback,
    required this.postOverlayViewModel,
    required this.showTimestamp,
    required this.showPostSummaryBarAbovePost,
  });

  final Function(Post)? onPostUpdatedCallback;

  @override
  final MinimalPublicProfile postAuthor;

  @override
  final Post post;

  @override
  final PostOverlayViewModel postOverlayViewModel;

  @override
  final bool showTimestamp;

  @override
  final bool showPostSummaryBarAbovePost;

  @override
  TextPostContent get postContent => post.content as TextPostContent;

  TextPostProfilePresentationModel copyWith({
    MinimalPublicProfile? postAuthor,
    Post? post,
    Function(Post)? onPostUpdatedCallback,
    PostOverlayViewModel? postOverlayViewModel,
    bool? showTimestamp,
    bool? showPostSummaryBarAbovePost,
  }) {
    return TextPostProfilePresentationModel._(
      postAuthor: postAuthor ?? this.postAuthor,
      post: post ?? this.post,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      postOverlayViewModel: postOverlayViewModel ?? this.postOverlayViewModel,
      showTimestamp: showTimestamp ?? this.showTimestamp,
      showPostSummaryBarAbovePost: showPostSummaryBarAbovePost ?? this.showPostSummaryBarAbovePost,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class TextPostProfileViewModel {
  MinimalPublicProfile get postAuthor;

  TextPostContent get postContent;

  Post get post;

  PostOverlayViewModel get postOverlayViewModel;

  bool get showTimestamp;

  bool get showPostSummaryBarAbovePost;
}
