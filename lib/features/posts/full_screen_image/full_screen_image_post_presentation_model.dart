import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/save_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/utils/future_result.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class FullScreenImagePostPresentationModel implements FullScreenImagePostViewModel {
  /// Creates the initial state
  FullScreenImagePostPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    FullScreenImagePostInitialParams initialParams,
    UserStore userStore,
  )   : privateProfile = userStore.privateProfile,
        savePostResult = const FutureResult.empty(),
        post = initialParams.post;

  /// Used for the copyWith method
  FullScreenImagePostPresentationModel._({
    required this.post,
    required this.privateProfile,
    required this.savePostResult,
  });

  final FutureResult<Either<SavePostToCollectionFailure, Post>> savePostResult;

  @override
  final Post post;

  final PrivateProfile privateProfile;

  @override
  ImagePostContent get imagePostContent => post.content as ImagePostContent;

  @override
  bool get canDeletePost => isAuthor || circle.permissions.canManagePosts;

  @override
  BasicPublicProfile get author => post.author;

  @override
  bool get canReportPost => !isAuthor;

  @override
  bool get isAuthor => privateProfile.user.id == post.author.id;

  @override
  BasicCircle get circle => post.circle;

  FullScreenImagePostPresentationModel byUpdatingShareStatus() {
    return copyWith(
      post: post.byIncrementingShareCount(),
    );
  }

  FullScreenImagePostPresentationModel byUpdatingSavedStatus({required bool iSaved}) {
    return copyWith(
      post: post.byUpdatingSavedStatus(
        iSaved: iSaved,
      ),
    );
  }

  FullScreenImagePostPresentationModel byUpdatingJoinedStatus({required bool iJoined}) {
    return copyWith(
      post: post.copyWith(
        circle: post.circle.copyWith(iJoined: iJoined),
      ),
    );
  }

  FullScreenImagePostPresentationModel byUpdatingAuthorWithFollow({required bool follow}) {
    return copyWith(
      post: post.copyWith(
        author: author.copyWith(iFollow: follow),
      ),
    );
  }

  FullScreenImagePostPresentationModel copyWith({
    Post? post,
    PrivateProfile? privateProfile,
    FutureResult<Either<SavePostToCollectionFailure, Post>>? savePostResult,
  }) {
    return FullScreenImagePostPresentationModel._(
      savePostResult: savePostResult ?? this.savePostResult,
      post: post ?? this.post,
      privateProfile: privateProfile ?? this.privateProfile,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class FullScreenImagePostViewModel {
  ImagePostContent get imagePostContent;

  BasicCircle get circle;

  Post get post;

  bool get canDeletePost;

  bool get isAuthor;

  bool get canReportPost;

  BasicPublicProfile get author;
}
