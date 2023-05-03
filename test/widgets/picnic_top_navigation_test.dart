import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/domain/model/feed_type.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/top_navigation/feed_items_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_avatar_title.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_tag_avatar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_title_badge.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_three_icons_bar.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_top_navigation",
    widgetBuilder: (context) {
      final colors = PicnicTheme.of(context).colors;

      const title = 'home';
      return GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: "bar with avatar",
            child: TestWidgetContainer(
              child: PicnicBarWithAvatarTitle(
                iconPathLeft: Assets.images.bell.path,
                onTapLeft: () {},
                iconTintColor: colors.lightBlue,
                avatar: PicnicAvatar(
                  size: 32.0,
                  borderColor: PicnicTheme.of(context).colors.green,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(Assets.images.picnicLogo.path),
                  ),
                ),
                suffix: Image.asset(Assets.images.bell.path),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "bar with tag avatar",
            child: TestWidgetContainer(
              child: PicnicBarWithTagAvatar(
                viewsCount: 1234,
                tag: PicnicTag(
                  title: 'startups',
                  backgroundColor: colors.blackAndWhite.shade900.withOpacity(0.07),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                title: title.formattedUsername,
                titleColor: colors.blackAndWhite.shade900,
                avatar: PicnicAvatar(
                  size: 32.0,
                  borderColor: PicnicTheme.of(context).colors.green,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(Assets.images.picnicLogo.path),
                  ),
                ),
                onTitleTap: () {},
              ),
            ),
          ),
          GoldenTestScenario(
            name: "bar with title and badge",
            child: TestWidgetContainer(
              child: PicnicBarWithTitleBadge(
                title: 'discover',
                iconPathFirst: Assets.images.bell.path,
                badgeRadius: 10.0,
                badgeValue: 1,
                badgeBackgroundColor: colors.green,
                iconTintColor: colors.lightBlue,
                onTapFirst: () {},
              ),
            ),
          ),
          GoldenTestScenario(
            name: "text bar",
            child: TestWidgetContainer(
              child: FeedItemsBar(
                selectedFeed: const Feed.empty().copyWith(feedType: FeedType.custom),
                onTabChanged: (feed) {},
                titleColor: colors.blackAndWhite.shade900,
                tabs: [
                  const Feed.empty().copyWith(
                    id: const Id("popular-id"),
                    feedType: FeedType.custom,
                    name: 'Popular',
                  ),
                  const Feed.empty().copyWith(
                    id: const Id("roblox-id"),
                    feedType: FeedType.circle,
                    name: 'Roblox',
                  ),
                  const Feed.empty().copyWith(
                    id: const Id("picnic-id"),
                    feedType: FeedType.explore,
                    name: 'Picnic',
                  ),
                ],
              ),
            ),
          ),
          GoldenTestScenario(
            name: "three icons bar",
            child: TestWidgetContainer(
              child: PicnicThreeIconsBar(
                iconPath1: Assets.images.bell.path,
                iconPath2: Assets.images.bell.path,
                iconPath3: Assets.images.bell.path,
                title1: 'chat feed',
                title2: 'my circles',
                title3: 'dms',
              ),
            ),
          ),
        ],
      );
    },
  );
}
