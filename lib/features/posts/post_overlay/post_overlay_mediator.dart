import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/post_route_result.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';

/// encapsulates all possible messages being sent from within the overlay to the enclosing post page,
/// should be passed in as param to PostOverlay widget
class PostOverlayMediator {
  const PostOverlayMediator({
    required this.reportActionTaken,
    required this.postUpdated,
    this.onUpdatedComments,
    this.commentBarSizeChanged,
    this.onPresenterCreated,
  });

  final ValueChanged<PostRouteResult> reportActionTaken;
  final ValueChanged<Post> postUpdated;
  final ValueChanged<List<CommentPreview>>? onUpdatedComments;
  final ValueChanged<double>? commentBarSizeChanged;
  final ValueChanged<PostOverlayPresenter>? onPresenterCreated;
}
