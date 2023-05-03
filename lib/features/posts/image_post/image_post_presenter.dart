import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_navigator.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presentation_model.dart';

class ImagePostPresenter extends Cubit<ImagePostViewModel> {
  ImagePostPresenter(
    ImagePostPresentationModel model,
    this.navigator,
  ) : super(model);

  final ImagePostNavigator navigator;

  // ignore: unused_element
  ImagePostPresentationModel get _model => state as ImagePostPresentationModel;

  void reportActionTaken(PostRouteResult result) => navigator.closeWithResult(result);

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(_model.post);
  }

  void onUpdatedComments(List<CommentPreview> comments) => tryEmit(_model.copyWith(comments: comments));

  void onImageTap() =>
      navigator.openFullScreenImagePost(FullScreenImagePostInitialParams(imageContent: _model.imageContent));
}
