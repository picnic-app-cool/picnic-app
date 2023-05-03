import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';

class FeedHomeInitialParams {
  const FeedHomeInitialParams({
    required this.onPostChanged,
    required this.onCirclesSideMenuToggled,
    this.postToShow = const Post.empty(),
  });

  final Post postToShow;
  final OnDisplayedPostChangedCallback onPostChanged;
  final VoidCallback onCirclesSideMenuToggled;
}
