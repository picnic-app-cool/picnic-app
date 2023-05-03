//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/picnic_switch.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:widgetbook/widgetbook.dart';

import 'picnic_tag.dart';

class PicnicListItemUseCases extends WidgetbookComponent {
  PicnicListItemUseCases()
      : super(
          name: "$PicnicListItem",
          useCases: [
            WidgetbookUseCase(
              name: "List Item use Cases",
              builder: (context) {
                final themeColors = PicnicTheme.of(context).colors;
                final themeStyles = PicnicTheme.of(context).styles;

                final colors = [
                  Option(
                    label: "Blue",
                    value: themeColors.lightBlue.shade200,
                  ),
                  Option(
                    label: "Green",
                    value: themeColors.green.shade300,
                  ),
                  Option(
                    label: "Black",
                    value: themeColors.blackAndWhite.shade200,
                  ),
                  Option(
                    label: "Pink",
                    value: themeColors.pink.shade200,
                  ),
                ];
                final styles = PicnicTheme.of(context).styles;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PicnicListItem(
                      borderRadius: context.knobs.options(
                        label: 'Border radius',
                        options: [
                          const Option(
                            label: "8",
                            value: 8.0,
                          ),
                          const Option(
                            label: "12",
                            value: 12.0,
                          ),
                        ],
                      ),
                      leading: context.knobs.options(
                        label: 'Leading',
                        options: [
                          Option(
                            label: "Avatar",
                            value: PicnicAvatar(
                              size: 42,
                              backgroundColor: context.knobs.options(
                                label: 'Avatar Background Color',
                                options: colors,
                              ),
                              isCrowned: context.knobs.options(
                                label: 'Avatar Crowned ?',
                                options: [
                                  const Option(label: 'No', value: false),
                                  const Option(label: 'Yes', value: true),
                                ],
                              ),
                              imageSource: context.knobs.options(
                                label: 'Avatar child',
                                options: [
                                  Option(
                                    label: 'Laptop',
                                    value: PicnicImageSource.emoji(Constants.laptopEmoji),
                                  ),
                                  Option(
                                    label: 'Laptop',
                                    value: PicnicImageSource.emoji(Constants.smileEmoji),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Option(
                            label: 'Cog wheel',
                            value: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                Constants.cogWheelEmoji,
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          Option(
                            label: 'Whole Watermelon',
                            value: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Image.asset(
                                Assets.images.watermelonWhole.path,
                              ),
                            ),
                          ),
                          Option(
                            label: 'Seed',
                            value: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Transform.rotate(
                                angle: 75,
                                child: Image.asset(
                                  Assets.images.seed.path,
                                ),
                              ),
                            ),
                          ),
                          const Option(
                            label: "None",
                            value: null,
                          ),
                        ],
                      ),
                      setBoxShadow: context.knobs.options(
                        label: 'Box Shadow',
                        options: [
                          const Option(
                            label: "Yes",
                            value: true,
                          ),
                          const Option(
                            label: "No",
                            value: false,
                          ),
                        ],
                      ),
                      borderColor: context.knobs.options(
                        label: 'List Item Border Color ',
                        options: [
                          const Option(
                            label: "None",
                            value: null,
                          ),
                          Option(
                            label: "Gold",
                            value: themeColors.yellow,
                          ),
                          Option(
                            label: "Light Blue",
                            value: themeColors.lightBlue,
                          ),
                          Option(
                            label: "Green",
                            value: themeColors.green,
                          ),
                        ],
                      ),
                      height: context.knobs.options(
                        label: 'Height ',
                        options: [
                          const Option(
                            label: "48",
                            value: 48.0,
                          ),
                          const Option(
                            label: "None",
                            value: 75.0,
                          ),
                        ],
                      ),
                      picnicTag: context.knobs.options(
                        label: 'Include Picnic Tag',
                        options: [
                          const Option(
                            label: "No",
                            value: null,
                          ),
                          Option(
                            label: "Yes",
                            value: PicnicTag(
                              titleTextStyle: themeStyles.body0.copyWith(color: themeColors.blackAndWhite.shade100),
                              title: "you voted",
                              blurRadius: null,
                              backgroundColor: themeColors.green,
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
                              borderRadius: PicnicTagBorderRadius.large,
                            ),
                          ),
                        ],
                      ),
                      fillColor: context.knobs.options(
                        label: 'Fill color ',
                        options: [
                          const Option(
                            label: "None",
                            value: null,
                          ),
                          Option(
                            label: "Light grey",
                            value: themeColors.blackAndWhite.shade200,
                          ),
                          const Option(
                            label: "Transparent",
                            value: Colors.transparent,
                          )
                        ],
                      ),
                      subTitle: context.knobs.options(
                        label: 'Include Subtitle',
                        options: [
                          const Option(
                            label: "None",
                            value: null,
                          ),
                          const Option(
                            label: "Members",
                            value: "29k members",
                          ),
                          const Option(
                            label: "Following",
                            value: "started following you",
                          ),
                          const Option(
                            label: "Comment",
                            value: "left a comment on your post",
                          ),
                          const Option(
                            label: "Vote",
                            value: "time to vote for a director",
                          ),
                          const Option(
                            label: "Seeds",
                            value: "100 seeds",
                          ),
                          const Option(
                            label: "Hit Road",
                            value: "yo, lets hit the road",
                          ),
                        ],
                      ),
                      subTitleStyle: context.knobs.options(
                        label: 'Subtitle Text Style',
                        options: [
                          Option(
                            label: "Caption 20 with Opacity",
                            value:
                                styles.caption20.copyWith(color: themeColors.blackAndWhite.shade800.withOpacity(0.4)),
                          ),
                          Option(
                            label: "Caption 10 with Opacity",
                            value:
                                styles.caption10.copyWith(color: themeColors.blackAndWhite.shade800.withOpacity(0.4)),
                          ),
                        ],
                      ),
                      title: context.knobs.options(
                        label: 'Title text',
                        options: [
                          const Option(
                            label: "User 1",
                            value: "@payamdaliri",
                          ),
                          const Option(
                            label: "User 2",
                            value: "payamdaliri",
                          ),
                          const Option(
                            label: "Circle",
                            value: "gacha circle",
                          ),
                          const Option(
                            label: "Circle 2",
                            value: "coding",
                          ),
                          const Option(
                            label: "Circle 3",
                            value: "fun circle",
                          ),
                          const Option(
                            label: "Circle 4",
                            value: "gacha slice",
                          ),
                          const Option(
                            label: "Circle 5",
                            value: "gacha",
                          ),
                          const Option(
                            label: "File",
                            value: "file.jpeg",
                          ),
                          const Option(
                            label: "Settings",
                            value: "settings",
                          ),
                          const Option(
                            label: "Dm",
                            value: "only receive dms from people you follow",
                          ),
                          const Option(
                            label: "Dm Long",
                            value: "only receive dms from people you follow follow follow follow",
                          ),
                          const Option(
                            label: "Followers",
                            value: "new followers",
                          ),
                          const Option(
                            label: "Melons",
                            value: "16 melons",
                          ),
                          const Option(
                            label: "Seeds count",
                            value: "you have 155 seeds in this circle",
                          ),
                        ],
                      ),
                      titleStyle: context.knobs.options(
                        label: 'Title Text Style',
                        options: [
                          Option(
                            label: "Title 10",
                            value: styles.title10,
                          ),
                          Option(
                            label: "Title 30",
                            value: styles.title30,
                          ),
                          Option(
                            label: "Title 20",
                            value: styles.title20,
                          ),
                          Option(
                            label: "Body 20",
                            value: styles.body20.copyWith(
                              color: themeColors.blackAndWhite.shade700,
                            ),
                          ),
                          Option(
                            label: "Body 30",
                            value: styles.body30.copyWith(
                              color: themeColors.blackAndWhite.shade900,
                            ),
                          )
                        ],
                      ),
                      trailing: context.knobs.options(
                        label: 'Trailing',
                        options: [
                          Option(
                            label: "Single Text : director",
                            value: Text(
                              "director",
                              style: styles.title30.copyWith(color: themeColors.lightBlue),
                            ),
                          ),
                          Option(
                            label: "View Seeds",
                            value: Text(
                              "view seeds",
                              style: styles.body30.copyWith(color: themeColors.green),
                            ),
                          ),
                          Option(
                            label: "Single Text 2: Seeds emoji and count",
                            value: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(Assets.images.seed.path),
                                Text(
                                  "315 seeds",
                                  style: styles.body30.copyWith(color: themeColors.blackAndWhite.shade900),
                                ),
                              ],
                            ),
                          ),
                          Option(
                            label: "Single Text 3: Likes count",
                            value: Row(
                              children: [
                                Text(
                                  "${Constants.heartEmoji} 98",
                                  style: styles.body20.copyWith(color: themeColors.blackAndWhite.shade700),
                                ),
                              ],
                            ),
                          ),
                          Option(
                            label: "Column: Share link",
                            value: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "director",
                                  style: styles.title30.copyWith(color: themeColors.lightBlue),
                                ),
                                Row(
                                  children: [
                                    ImageIcon(
                                      AssetImage(Assets.images.link.path),
                                      color: themeColors.blue.shade800,
                                    ),
                                    Text(
                                      "link",
                                      textAlign: TextAlign.end,
                                      style: styles.title10.copyWith(color: themeColors.blue.shade800),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Option(
                            label: "Column: Seeds and Percent",
                            value: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "75%",
                                  style: styles.title30.copyWith(color: themeColors.lightBlue),
                                ),
                                Text(
                                  "55 seeds",
                                  textAlign: TextAlign.end,
                                  style: styles.title10.copyWith(
                                    color: themeColors.blue.shade800,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Option(
                            label: "Row/Column: Clock",
                            value: Row(
                              children: [
                                Image.asset(
                                  Assets.images.clock.path,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.fill,
                                ),
                                const Gap(5),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "23:48",
                                      style: styles.title40.copyWith(height: 0),
                                    ),
                                    Text(
                                      "countdown",
                                      textAlign: TextAlign.end,
                                      style:
                                          styles.title10.copyWith(fontSize: 12, fontWeight: FontWeight.w300, height: 0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Option(
                            label: "Button: follow filled green",
                            value: PicnicButton(
                              title: "follow",
                              onTap: () {},
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              color: themeColors.green,
                              minWidth: 10,
                            ),
                          ),
                          Option(
                            label: "Button: vote now filled green",
                            value: PicnicButton(
                              title: "vote now",
                              onTap: () {},
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              color: themeColors.green,
                              minWidth: 10,
                            ),
                          ),
                          Option(
                            label: "Button: following outline pink",
                            value: PicnicButton(
                              title: "following",
                              onTap: () {},
                              style: PicnicButtonStyle.outlined,
                              borderColor: themeColors.pink,
                              borderWidth: 2,
                              titleColor: themeColors.pink,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              color: themeColors.blackAndWhite.shade100,
                              minWidth: 10,
                            ),
                          ),
                          Option(
                            label: "Button: unblock outline pink",
                            value: PicnicButton(
                              title: "unblock",
                              onTap: () {},
                              style: PicnicButtonStyle.outlined,
                              borderColor: themeColors.pink,
                              borderWidth: 2,
                              titleColor: themeColors.pink,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              color: themeColors.blackAndWhite.shade100,
                              minWidth: 10,
                            ),
                          ),
                          Option(
                            label: "Button: joined outline pink",
                            value: PicnicButton(
                              title: "joined",
                              onTap: () {},
                              style: PicnicButtonStyle.outlined,
                              borderColor: themeColors.pink,
                              borderWidth: 2,
                              titleColor: themeColors.pink,
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              color: themeColors.blackAndWhite.shade100,
                              minWidth: 10,
                            ),
                          ),
                          Option(
                            label: "Button: join filled green",
                            value: PicnicButton(
                              title: "join",
                              onTap: () {},
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              color: themeColors.green,
                              minWidth: 10,
                            ),
                          ),
                          Option(
                            label: "Image: Girl",
                            value: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                fit: BoxFit.fill,
                                "https://storage.googleapis.com/amber-app-supercool.appspot.com/mock-images/post_girl.webp",
                                width: 32,
                                height: 32,
                              ),
                            ),
                          ),
                          Option(
                            label: 'Right Arrow ',
                            value: Image.asset(Assets.images.arrowRight.path),
                          ),
                          Option(
                            label: 'Switch ',
                            value: PicnicSwitch(
                              color: themeColors.green,
                              size: PicnicSwitchSize.regular,
                              onChanged: (value) {},
                              value: true,
                            ),
                          ),
                          const Option(
                            label: "None",
                            value: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
}
