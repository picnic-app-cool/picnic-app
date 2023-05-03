import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';

class PostsListInitialParams {
  const PostsListInitialParams({
    required this.feed,
    required this.onPostChanged,
    this.localPost = const Post.empty(),
    this.gridView = false,
  });

  final bool gridView;
  final Feed feed;
  final Post localPost;
  final OnDisplayedPostChangedCallback onPostChanged;
}
