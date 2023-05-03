import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/video_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/post_details_mode.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostDetailsPresentationModel implements PostDetailsViewModel {
  /// Creates the initial state
  PostDetailsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostDetailsInitialParams initialParams,
    UserStore userStore,
  )   : initialPostId = initialParams.postId,
        post = initialParams.post,
        isModOrDirector = initialParams.isModOrDirector,
        privateProfile = userStore.privateProfile,
        reportId = initialParams.reportId,
        mode = initialParams.mode,
        onPostUpdatedCallback = initialParams.onPostUpdated,
        getPostResult = const FutureResult.empty();

  /// Used for the copyWith method
  PostDetailsPresentationModel._({
    required this.post,
    required this.isModOrDirector,
    required this.privateProfile,
    required this.reportId,
    required this.mode,
    required this.initialPostId,
    required this.getPostResult,
    required this.onPostUpdatedCallback,
  });

  final Function(Post)? onPostUpdatedCallback;

  final Id initialPostId;

  final FutureResult<Either<GetPostByIdFailure, Post>> getPostResult;

  @override
  final Post post;

  @override
  final Id reportId;

  @override
  final PostDetailsMode mode;

  final PrivateProfile privateProfile;

  @override
  final bool isModOrDirector;

  @override
  bool get isLoading => getPostResult.isPending();

  @override
  bool get deleteEnabled => isAuthor || isModOrDirector;

  @override
  bool get showOptions => mode != PostDetailsMode.report;

  @override
  bool get isTransparent => post.content is ImagePostContent || post.content is VideoPostContent;

  @override
  bool get isAuthor => privateProfile.user.id == post.author.id;

  Id get postId => initialPostId.isNone ? post.id : initialPostId;

  PostDetailsPresentationModel copyWith({
    Id? initialPostId,
    FutureResult<Either<GetPostByIdFailure, Post>>? getPostResult,
    Post? post,
    Id? reportId,
    PostDetailsMode? mode,
    PrivateProfile? privateProfile,
    bool? isModOrDirector,
    Function(Post)? onPostUpdatedCallback,
  }) {
    return PostDetailsPresentationModel._(
      initialPostId: initialPostId ?? this.initialPostId,
      getPostResult: getPostResult ?? this.getPostResult,
      post: post ?? this.post,
      reportId: reportId ?? this.reportId,
      mode: mode ?? this.mode,
      privateProfile: privateProfile ?? this.privateProfile,
      isModOrDirector: isModOrDirector ?? this.isModOrDirector,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostDetailsViewModel {
  Post get post;

  bool get deleteEnabled;

  bool get isTransparent;

  bool get isModOrDirector;

  Id get reportId;

  bool get showOptions;

  bool get isAuthor;

  PostDetailsMode get mode;

  bool get isLoading;
}
