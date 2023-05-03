import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/image_post/image_post_page.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_page.dart';
import 'package:picnic_app/features/posts/widgets/post_list_item.dart';

import '../mocks/stubs.dart';
import '../test_utils/test_app_widget.dart';
import '../test_utils/test_utils.dart';

void main() {
  testWidgets(
    'updating post should recreate pages',
    (widgetTester) async {
      reRegister<VideoPostPage>(const _TestVideoPostPage());
      reRegister<ImagePostPage>(const _TestImagePostPage());
      await widgetTester.pumpWidget(_buildPostListItem(Stubs.videoPost));
      await widgetTester.pumpWidget(_buildPostListItem(Stubs.imagePost));
      final state = widgetTester.state<PostListItemState>(find.byType(PostListItem));
      expect(state.page, isA<ImagePostPage>());
    },
  );
}

Widget _buildPostListItem(Post post) {
  return TestAppWidget(
    child: PostListItem(
      post: post,
      onPostUpdated: (_) {},
      onReport: (_) {},
      showTimestamp: true,
    ),
  );
}

//ignore: avoid_implementing_value_types
class _TestVideoPostPage extends StatefulWidget implements VideoPostPage {
  const _TestVideoPostPage({Key? key}) : super(key: key);

  @override
  State<_TestVideoPostPage> createState() => _TestVideoPostPageState();

  @override
  VideoPostInitialParams get initialParams => throw UnimplementedError();
}

class _TestVideoPostPageState extends State<_TestVideoPostPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

//ignore: avoid_implementing_value_types
class _TestImagePostPage extends StatefulWidget implements ImagePostPage {
  const _TestImagePostPage({Key? key}) : super(key: key);

  @override
  State<_TestImagePostPage> createState() => _TestImagePostPageState();

  @override
  ImagePostPresenter get presenter => throw UnimplementedError();
}

class _TestImagePostPageState extends State<_TestImagePostPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
