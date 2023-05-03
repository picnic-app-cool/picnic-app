import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class MainInitialParams {
  const MainInitialParams({
    this.postToShow = const Post.empty(),
  });

  final Post postToShow;
}
