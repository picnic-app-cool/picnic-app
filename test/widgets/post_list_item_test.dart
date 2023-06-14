import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/post_viewing_time/analytics_event_post_viewing_time.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/image_post/image_post_page.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_page.dart';
import 'package:picnic_app/features/posts/widgets/post_list_item.dart';

import '../features/analytics/mocks/analytics_mocks.dart';
import '../mocks/stubs.dart';
import '../test_extensions/widget_tester_extensions.dart';
import '../test_utils/test_app_widget.dart';
import '../test_utils/test_utils.dart';

void main() {
  testWidgets(
    'updating post should recreate pages',
    (widgetTester) async {
      reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
      reRegister<VideoPostPage>(const _TestVideoPostPage());
      reRegister<ImagePostPage>(const _TestImagePostPage());
      await widgetTester.pumpWidget(_buildPostListItem(Stubs.videoPost));
      await widgetTester.pumpWidget(_buildPostListItem(Stubs.imagePost));
      final state = widgetTester.state<PostListItemState>(find.byType(PostListItem));
      expect(state.page, isA<ImagePostPage>());
    },
  );

  testWidgets(
    'should measure post time',
    (widgetTester) async {
      reRegister<LogAnalyticsEventUseCase>(AnalyticsMocks.logAnalyticsEventUseCase);
      await widgetTester.setupWidget(
        Material(child: _buildPostListItem(Stubs.imagePost)),
      );
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));
      await widgetTester.setupWidget(Container());
      await widgetTester.pumpAndSettle(const Duration(seconds: 1));

      final analyticsEvent =
          verify(() => AnalyticsMocks.logAnalyticsEventUseCase.execute(captureAny())).captured.first as AnalyticsEvent;
      expect(analyticsEvent.name, AnalyticsEventPostViewingTime.eventName);
    },
  );
}

Widget _buildPostListItem(Post post) {
  return TestAppWidget(
    child: PostListItem(
      post: post,
      onPostUpdated: (_) {},
      onLongPress: (_) {},
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
