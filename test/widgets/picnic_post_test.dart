import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/content_stats_for_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/widgets/post_summary_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_post/picnic_post.dart';

import '../../widgetbook/constants/widgetbook_constants.dart';
import '../mocks/stubs.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  final post = const Post.empty().copyWith(
    circle: const BasicCircle.empty().copyWith(
      name: '🚀 startups',
    ),
    contentStats: const ContentStatsForContent.empty().copyWith(impressions: 3581),
    author: Stubs.postAuthor,
  );
  final postSummaryBarWithTag = PostSummaryBar(
    author: Stubs.postAuthor,
    overlayTheme: PostOverlayTheme.light,
    post: post,
    onTapTag: () {},
    padding: EdgeInsets.zero,
    showTagBackground: true,
    isDense: true,
    showTagPrefixIcon: false,
    onToggleFollow: () {},
    onTapAuthor: () {},
  );
  final postSummaryBar = PostSummaryBar(
    author: Stubs.postAuthor,
    post: post,
    overlayTheme: PostOverlayTheme.light,
    onTapTag: () {},
    padding: EdgeInsets.zero,
    displayTag: false,
    showTagBackground: true,
    isDense: true,
    showTagPrefixIcon: false,
    onToggleFollow: () {},
    onTapAuthor: () {},
  );
  widgetScreenshotTest(
    "picnic_post",
    widgetBuilder: (context) {
      return GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: "horizontal blue linear gradient with expand",
            child: TestWidgetContainer(
              child: SizedBox(
                width: 300,
                height: 400,
                child: PicnicPost(
                  onTapExpand: () {},
                  background: BoxDecoration(
                    gradient: WidgetBookConstants.picnicPostGradientBlue,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  postSummaryBar: postSummaryBarWithTag,
                  bodyText:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                  post: post,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "horizontal blue linear gradient without expand",
            child: TestWidgetContainer(
              child: SizedBox(
                width: 300,
                height: 400,
                child: PicnicPost(
                  background: BoxDecoration(
                    gradient: WidgetBookConstants.picnicPostGradientBlue,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  postSummaryBar: postSummaryBarWithTag,
                  bodyText:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                  post: post,
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "vertical blue linear gradient",
            child: TestWidgetContainer(
              child: PicnicPost(
                dimension: PicnicPostDimension.vertical,
                background: BoxDecoration(
                  gradient: WidgetBookConstants.picnicPostGradientBlue,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                postSummaryBar: postSummaryBar,
                bodyText:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                post: post,
              ),
            ),
          ),
          GoldenTestScenario(
            name: "vertical lounge image background",
            child: TestWidgetContainer(
              child: PicnicPost(
                dimension: PicnicPostDimension.vertical,
                background: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://storage.googleapis.com/amber-app-supercool.appspot.com/mock-images/post_lounge.webp",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                postSummaryBar: postSummaryBar,
                bodyText:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                post: post,
              ),
            ),
          ),
          GoldenTestScenario(
            name: "vertical post with two images",
            child: TestWidgetContainer(
              child: PicnicPost(
                dimension: PicnicPostDimension.verticalGallery,
                background: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://storage.googleapis.com/amber-app-supercool.appspot.com/mock-images/post_chicken.webp",
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    topLeft: Radius.circular(24),
                  ),
                ),
                backgroundRightHalf: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://storage.googleapis.com/amber-app-supercool.appspot.com/mock-images/post_beer.webp",
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                postSummaryBar: postSummaryBar,
                post: post,
              ),
            ),
          )
        ],
      );
    },
  );
}
