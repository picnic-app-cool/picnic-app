import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_author_details.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_bar_with_avatar_title.dart';
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
              child: PicnicBarWithAuthorDetails(
                iFollow: false,
                iJoined: false,
                viewsCount: 1234,
                postDetails: PicnicTag(
                  title: 'startups',
                  backgroundColor: colors.blackAndWhite.shade900.withOpacity(0.07),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
                circleName: title.formattedUsername,
                titleColor: colors.blackAndWhite.shade900,
                avatar: PicnicAvatar(
                  size: 32.0,
                  borderColor: PicnicTheme.of(context).colors.green,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(Assets.images.picnicLogo.path),
                  ),
                ),
                onAuthorUsernameTap: () {},
                onCircleNameTap: () {},
                authorUsername: 'username',
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
