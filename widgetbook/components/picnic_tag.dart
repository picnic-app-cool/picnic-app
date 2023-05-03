//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicTagUseCase extends WidgetbookComponent {
  PicnicTagUseCase()
      : super(
          name: "$PicnicTag",
          useCases: [
            WidgetbookUseCase(
              name: "Tag Use Cases",
              builder: (context) {
                const iconSizeUseCase = 24.0;

                final themeColors = PicnicTheme.of(context).colors;
                final colors = [
                  Option(
                    label: "Pink",
                    value: themeColors.pink,
                  ),
                  Option(
                    label: "Grey",
                    value: themeColors.blackAndWhite[300],
                  ),
                  Option(
                    label: "Dark Blue",
                    value: themeColors.blue,
                  ),
                  Option(
                    label: "Teal Green",
                    value: themeColors.teal,
                  ),
                  Option(
                    label: "Yellow",
                    value: themeColors.yellow,
                  ),
                  Option(
                    label: "White",
                    value: themeColors.blackAndWhite.shade100,
                  ),
                  Option(
                    label: "Black",
                    value: themeColors.blackAndWhite.shade900,
                  ),
                ];
                final icons = [
                  const Option(
                    label: "No icon",
                    value: null,
                  ),
                  Option(
                    label: "Edit",
                    value: Image.asset(Assets.images.edit.path),
                  ),
                  Option(
                    label: "Bookmark",
                    value: Image.asset(Assets.images.bookmark.path),
                  ),
                  Option(
                    label: "Message",
                    value: Image.asset(Assets.images.message.path),
                  ),
                  Option(
                    label: "Person",
                    value: Image.asset(Assets.images.person.path),
                  ),
                  Option(
                    label: "Add",
                    value: Image.asset(Assets.images.add.path),
                  ),
                  Option(
                    label: "Check",
                    value: Image.asset(Assets.images.checkboxCircle.path),
                  ),
                ];
                return PicnicTag(
                  title: context.knobs.text(
                    label: 'Tag Title',
                    initialValue: 'gamer',
                  ),
                  blurRadius: context.knobs.slider(
                    label: 'Blur Radius',
                    initialValue: 8.0,
                    min: 8.0,
                    max: 50.0,
                  ),
                  style: context.knobs.options(
                    label: 'Tag Style',
                    options: [
                      const Option(
                        label: "Filled",
                        value: PicnicTagStyle.filled,
                      ),
                      const Option(
                        label: "Outlined",
                        value: PicnicTagStyle.outlined,
                      )
                    ],
                  ),
                  backgroundColor: context.knobs.options(
                    label: 'Background Color',
                    options: colors,
                  ),
                  borderWidth: context.knobs.options(
                    label: 'Border Width',
                    options: [
                      Option(
                        label: "XSmall",
                        value: PicnicTagBorderWidth.small,
                      ),
                      Option(
                        label: "Small",
                        value: PicnicTagBorderWidth.regular,
                      ),
                      Option(
                        label: "Medium",
                        value: PicnicTagBorderWidth.large,
                      ),
                      Option(
                        label: "XLarge",
                        value: PicnicTagBorderWidth.xlarge,
                      ),
                    ],
                  ),
                  prefixIcon: context.knobs.options(
                    label: 'Prefix Icon',
                    options: icons,
                  ),
                  suffixIcon: context.knobs.options(
                    label: 'Suffix Icon',
                    options: icons,
                  ),
                  padding: context.knobs.options(
                    label: 'Padding',
                    options: [
                      const Option(
                        label: "Horizontal 10 Vertical 6",
                        value: EdgeInsets.only(left: 10.0, right: 10.0, top: 6.0, bottom: 6.0),
                      ),
                      const Option(
                        label: "Horizontal 24 Vertical 8",
                        value: EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0, bottom: 8.0),
                      ),
                      const Option(
                        label: "Horizontal 12 Vertical 8",
                        value: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
                      ),
                    ],
                  ),
                  borderColor: context.knobs.options(
                    label: 'Border Color',
                    options: colors,
                  ),
                  iconSize: iconSizeUseCase,
                  borderRadius: context.knobs.options(
                    label: 'Border Radius',
                    options: [
                      Option(
                        label: "Small",
                        value: PicnicTagBorderRadius.small,
                      ),
                      Option(
                        label: "Regular",
                        value: PicnicTagBorderRadius.regular,
                      ),
                      Option(
                        label: "Sharp",
                        value: PicnicTagBorderRadius.large,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
}

abstract class PicnicTagBorderWidth {
  static double small = 0.5;

  static double regular = 1.0;

  static double large = 2.0;

  static double xlarge = 3.0;
}

abstract class PicnicTagBorderRadius {
  static double small = 12;

  static double regular = 16;

  static double large = 100;
}
