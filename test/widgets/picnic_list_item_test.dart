import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

import '../../widgetbook/components/picnic_tag.dart';
import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_list_item",
    widgetBuilder: (context) {
      final theme = PicnicTheme.of(context);
      final blackAndWhite = theme.colors.blackAndWhite;
      final picnicLogoPath = Assets.images.picnicLogo.path;
      final textStyleCaption10 = theme.styles.caption10;
      final textStyleTitle10 = theme.styles.title10;
      final textStyleTitle30 = theme.styles.title30;
      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: "comment with trailing row and subtitle",
            child: TestWidgetContainer(
              child: PicnicListItem(
                title: "Payamdaliri",
                subTitle: "Thats amazing",
                titleStyle: textStyleCaption10,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.undo),
                    Icon(Icons.favorite_outlined),
                  ],
                ),
                leading: PicnicAvatar(
                  size: 40.0,
                  followButtonBackgroundColor: theme.colors.green,
                  followButtonForegroundColor: blackAndWhite.shade100,
                  backgroundColor: theme.colors.teal,
                  borderColor: Colors.white,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(picnicLogoPath),
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "owner circle trailing text",
            child: TestWidgetContainer(
              child: PicnicListItem(
                title: "coding",
                subTitle: "29k members",
                titleStyle: textStyleCaption10,
                trailing: Text(
                  "director",
                  style: textStyleTitle30.copyWith(
                    color: theme.colors.lightBlue,
                  ),
                ),
                leading: PicnicAvatar(
                  size: 42.0,
                  backgroundColor: blackAndWhite.shade200,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(picnicLogoPath),
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "owner circle with trailing text and link and shadow",
            child: TestWidgetContainer(
              child: PicnicListItem(
                title: "coding",
                setBoxShadow: true,
                subTitle: "29k members",
                titleStyle: textStyleCaption10,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "director",
                      style: textStyleTitle30.copyWith(color: theme.colors.lightBlue),
                    ),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage(Assets.images.link.path),
                          color: theme.colors.blue.shade800,
                        ),
                        Text(
                          "link",
                          textAlign: TextAlign.end,
                          style: textStyleTitle10.copyWith(color: theme.colors.blue.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
                leading: PicnicAvatar(
                  size: 42.0,
                  backgroundColor: blackAndWhite.shade200,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(picnicLogoPath),
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "top member owner circle with link and yellow border",
            child: TestWidgetContainer(
              child: PicnicListItem(
                title: "coding",
                borderColor: theme.colors.yellow,
                subTitle: "29k members",
                titleStyle: textStyleCaption10,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "director",
                      style: textStyleTitle30.copyWith(color: theme.colors.lightBlue),
                    ),
                    Row(
                      children: [
                        ImageIcon(
                          AssetImage(Assets.images.link.path),
                          color: theme.colors.blue.shade800,
                        ),
                        Text(
                          "link",
                          textAlign: TextAlign.end,
                          style: textStyleTitle10.copyWith(color: theme.colors.blue.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
                leading: PicnicAvatar(
                  size: 42.0,
                  isCrowned: true,
                  backgroundColor: blackAndWhite.shade200,
                  borderColor: Colors.white,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(picnicLogoPath),
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "notification to follow back",
            child: TestWidgetContainer(
              child: PicnicListItem(
                title: "payamdaliri",
                subTitle: "started following you",
                titleStyle: textStyleTitle10,
                subTitleStyle: textStyleCaption10.copyWith(color: theme.colors.blackAndWhite.shade600),
                trailing: PicnicButton(
                  title: "follow",
                  onTap: () {},
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 24,
                  ),
                  color: theme.colors.green,
                  minWidth: 10,
                ),
                leading: PicnicAvatar(
                  size: 40.0,
                  backgroundColor: theme.colors.lightBlue.shade200,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(picnicLogoPath),
                  ),
                ),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "user voted tag with green border",
            child: TestWidgetContainer(
              child: PicnicListItem(
                title: "@payamdaliri",
                borderColor: theme.colors.green,
                picnicTag: PicnicTag(
                  titleTextStyle: theme.styles.body0.copyWith(color: theme.colors.blackAndWhite.shade100),
                  title: "you voted",
                  blurRadius: null,
                  backgroundColor: theme.colors.green,
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                  borderRadius: PicnicTagBorderRadius.large,
                ),
                titleStyle: textStyleTitle10,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "75%",
                      style: textStyleTitle30.copyWith(color: theme.colors.lightBlue),
                    ),
                    Text(
                      "55 seeds",
                      textAlign: TextAlign.end,
                      style: textStyleTitle10.copyWith(
                        color: theme.colors.blue.shade800,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                leading: PicnicAvatar(
                  size: 40.0,
                  backgroundColor: theme.colors.lightBlue.shade200,
                  imageSource: PicnicImageSource.asset(
                    ImageUrl(picnicLogoPath),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}
