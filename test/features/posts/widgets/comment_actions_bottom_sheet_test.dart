import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/widgets/comment_actions_bottom_sheet.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'comment_actions_bottom_sheet',
    setUp: () {
      when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2023, 3, 26));
    },
    widgetBuilder: (context) => GoldenTestGroup(
      children: [
        GoldenTestScenario(
          name: 'simplest tree comment',
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
          child: TestWidgetContainer(
            child: CommentActionsBottomSheet(
              comment: Stubs.comments.children[0],
              onTapDelete: null,
              onTapPin: null,
              onTapUnpin: null,
              onTapClose: () {},
              onTapLike: () {},
              onTapReply: () {},
              onTapReport: () {},
              onTapShare: () {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'simplest comment preview',
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
          child: TestWidgetContainer(
            child: CommentActionsBottomSheet(
              comment: Stubs.commentsPreview.first,
              onTapDelete: null,
              onTapPin: null,
              onTapUnpin: null,
              onTapClose: () {},
              onTapLike: () {},
              onTapReply: () {},
              onTapReport: () {},
              onTapShare: () {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'with delete option',
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
          child: TestWidgetContainer(
            child: CommentActionsBottomSheet(
              comment: Stubs.comments.children[0],
              onTapClose: () {},
              onTapDelete: () {},
              onTapPin: null,
              onTapUnpin: null,
              onTapLike: () {},
              onTapReply: () {},
              onTapReport: () {},
              onTapShare: () {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'with pin option',
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
          child: TestWidgetContainer(
            child: CommentActionsBottomSheet(
              comment: Stubs.comments.children[0],
              onTapClose: () {},
              onTapDelete: null,
              onTapPin: () {},
              onTapUnpin: null,
              onTapLike: () {},
              onTapReply: () {},
              onTapReport: () {},
              onTapShare: () {},
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'with unpin option',
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 400),
          child: TestWidgetContainer(
            child: CommentActionsBottomSheet(
              comment: Stubs.comments.children[0],
              onTapClose: () {},
              onTapDelete: null,
              onTapPin: null,
              onTapUnpin: () {},
              onTapLike: () {},
              onTapReply: () {},
              onTapReport: () {},
              onTapShare: () {},
            ),
          ),
        ),
      ],
    ),
  );
}
