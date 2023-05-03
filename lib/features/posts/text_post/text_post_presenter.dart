import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/text_post/text_post_navigator.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presentation_model.dart';

class TextPostPresenter extends Cubit<TextPostViewModel> {
  TextPostPresenter(
    TextPostPresentationModel model,
    this.navigator,
  ) : super(model);

  final TextPostNavigator navigator;

  // ignore: unused_element
  TextPostPresentationModel get _model => state as TextPostPresentationModel;

  void onTapUpload() => notImplemented();

  void onTapExpand(String text) => tryEmit(_model.copyWith(expandedText: text));

  void onTapCompress() => tryEmit(_model.copyWith(expandedText: ''));

  void reportActionTaken(PostRouteResult result) => navigator.closeWithResult(result);

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(_model.post);
  }

  void onUpdatedComments(List<CommentPreview> comments) => tryEmit(_model.copyWith(comments: comments));
}
