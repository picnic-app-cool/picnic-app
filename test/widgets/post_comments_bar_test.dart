import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_button/post_bar_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_bar_like_button/post_bar_like_button_params.dart';
import 'package:picnic_app/features/posts/widgets/post_comment_bar.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'post_comments_bar',
    widgetBuilder: (context) {
      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'everything enabled - light',
            child: _buildCommentBar(
              isPostLiked: true,
              isPostSaved: true,
            ),
          ),
          GoldenTestScenario(
            name: 'everything enabled - dark',
            child: _buildCommentBar(
              isPostLiked: true,
              isPostSaved: true,
              overlayTheme: PostOverlayTheme.dark,
            ),
          ),
          GoldenTestScenario(
            name: 'everything disabled - light',
            child: _buildCommentBar(),
          ),
          GoldenTestScenario(
            name: 'everything disabled - dark',
            child: _buildCommentBar(
              overlayTheme: PostOverlayTheme.dark,
            ),
          ),
          GoldenTestScenario(
            name: 'bookmark disabled',
            child: _buildCommentBar(
              bookmarkEnabled: false,
            ),
          ),
          GoldenTestScenario(
            name: 'everything loading',
            child: _buildCommentBar(
              postLiking: true,
              postSaving: true,
            ),
          ),
          GoldenTestScenario(
            name: 'commenting disabled',
            child: _buildCommentBar(
              canComment: false,
            ),
          ),
        ],
      );
    },
  );
}

Widget _buildCommentBar({
  bool isPostLiked = false,
  bool bookmarkEnabled = true,
  bool hasActionsBelow = false,
  bool postSaving = false,
  bool postLiking = false,
  bool isPostSaved = false,
  bool canComment = true,
  int likesCount = 123,
  int commentsCount = 123,
  int savesCount = 123,
  int sharesCount = 123,
  PostOverlayTheme overlayTheme = PostOverlayTheme.light,
}) {
  final Color bgColor;
  switch (overlayTheme) {
    case PostOverlayTheme.dark:
      bgColor = Colors.white70;
      break;
    case PostOverlayTheme.light:
      bgColor = Colors.black87;
      break;
  }
  return TestWidgetContainer(
    backgroundColor: bgColor,
    child: PostCommentBar(
      bookmarkEnabled: bookmarkEnabled,
      hasActionsBelow: hasActionsBelow,
      overlayTheme: overlayTheme,
      likeButtonParams: PostBarLikeButtonParams(
        isLiked: isPostLiked,
        likes: likesCount.toString(),
        onTap: () {},
        overlayTheme: overlayTheme,
      ),
      commentsButtonParams: PostBarButtonParams(
        onTap: () {},
        overlayTheme: overlayTheme,
        text: commentsCount.toString(),
      ),
      shareButtonParams: PostBarButtonParams(
        onTap: () {},
        overlayTheme: overlayTheme,
        text: sharesCount.toString(),
      ),
      bookmarkButtonParams: PostBarButtonParams(
        onTap: () {},
        overlayTheme: overlayTheme,
        text: savesCount.toString(),
        selected: isPostSaved,
      ),
      canComment: canComment,
    ),
  );
}
