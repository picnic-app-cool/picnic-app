import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/link_post/link_post_navigator.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presentation_model.dart';

class LinkPostPresenter extends Cubit<LinkPostViewModel> {
  LinkPostPresenter(
    LinkPostPresentationModel model,
    this.navigator,
  ) : super(model);

  final LinkPostNavigator navigator;

  // ignore: unused_element
  LinkPostPresentationModel get _model => state as LinkPostPresentationModel;

  void onTapLink(LinkUrl linkUrl) => navigator.openWebView(linkUrl.url);

  void reportActionTaken(PostRouteResult result) => navigator.closeWithResult(result);

  void postUpdated(Post post) {
    tryEmit(_model.copyWith(post: post));
    _model.onPostUpdatedCallback?.call(_model.post);
  }

  void onUpdatedComments(List<CommentPreview> comments) => tryEmit(_model.copyWith(comments: comments));
}
