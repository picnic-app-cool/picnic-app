import 'package:alchemist/alchemist.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/widgets/comment_tree_item.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "comment_tree_item",
    setUp: () {
      when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2023, 3, 26));
    },
    widgetBuilder: (context) => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'CommentTreeItem',
          child: TestWidgetContainer(
            child: CommentTreeItem(
              treeComment: Stubs.comments.children[0],
              onLoadMore: (_) async {},
              onDoubleTap: (_) {},
              onProfileTap: (_) {},
              onReply: (_, __) {},
              onLikeUnlikeTap: (_) {},
              onTapShareCommentItem: (string) {},
            ),
          ),
        ),
      ],
    ),
  );

  widgetScreenshotTest(
    "comment_tree_item_collapsed",
    setUp: () {
      when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2023, 3, 26));
    },
    widgetBuilder: (context) => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'CommentTreeItem',
          child: TestWidgetContainer(
            child: CommentTreeItem(
              treeComment: Stubs.comments.children[0],
              collapsedCommentIds: [Stubs.comments.children[0].id],
              onLoadMore: (_) async {},
              onDoubleTap: (_) {},
              onProfileTap: (_) {},
              onReply: (_, __) {},
              onLikeUnlikeTap: (_) {},
              onTapShareCommentItem: (string) {},
            ),
          ),
        ),
      ],
    ),
  );
}
