import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:widgetbook/widgetbook.dart';

import '../constants/widgetbook_constants.dart';

abstract class PicnicButtonBorderWidth {
  static double small = 0.5;

  static double regular = 1.0;

  static double large = 2.0;

  static double xlarge = 3.0;
}

abstract class PicnicButtonMinimumWidth {
  static double small = 120;

  static double regular = 160;

  static double large = 250;
}

class PicnicButtonUseCases extends WidgetbookComponent {
  PicnicButtonUseCases()
      : super(
          name: "$PicnicButton",
          useCases: [
            WidgetbookUseCase(
              name: "Button Use Cases",
              builder: (context) {
                final colors = PicnicTheme.of(context).colors;
                final colorOptions = [
                  Option(
                    label: "White",
                    value: colors.blackAndWhite.shade100,
                  ),
                  Option(
                    label: "Green",
                    value: colors.green,
                  ),
                  Option(
                    label: "Pink",
                    value: colors.pink,
                  ),
                  Option(
                    label: "Purple",
                    value: colors.purple,
                  ),
                  Option(
                    label: "Grey",
                    value: colors.blackAndWhite.shade500,
                  ),
                  Option(
                    label: "Opacity green",
                    value: colors.green.shade200,
                  ),
                  Option(
                    label: "Black",
                    value: colors.blackAndWhite.shade900,
                  ),
                  const Option(
                    label: "Primary Blue",
                    value: PicnicColors.primaryTabBlue,
                  ),
                  Option(
                    label: "Light grey",
                    value: colors.blackAndWhite.shade200,
                  )
                ];
                return PicnicButton(
                  size: context.knobs.options(
                    label: 'Button Size',
                    options: [
                      const Option(
                        label: "Small",
                        value: PicnicButtonSize.small,
                      ),
                      const Option(
                        label: "Large",
                        value: PicnicButtonSize.large,
                      ),
                    ],
                  ),
                  title: context.knobs.text(
                    label: 'Button Label',
                    initialValue: 'edit profile',
                  ),
                  onTap: context.knobs.options(
                    label: 'State',
                    options: [
                      const Option(
                        label: "Disabled",
                        value: null,
                      ),
                      Option(
                        label: "Enabled",
                        value: () {},
                      ),
                    ],
                  ),
                  style: context.knobs.options(
                    label: 'Button Style',
                    options: [
                      const Option(
                        label: "Filled",
                        value: PicnicButtonStyle.filled,
                      ),
                      const Option(
                        label: "Outlined",
                        value: PicnicButtonStyle.outlined,
                      ),
                    ],
                  ),
                  color: context.knobs.options(
                    label: 'Background Color',
                    options: colorOptions.reversed.toList(),
                  ),
                  emoji: context.knobs.options(
                    label: 'Emoji',
                    options: WidgetBookConstants.emojiList,
                  ),
                  borderWidth: context.knobs.options(
                    label: 'Border Width',
                    options: [
                      Option(
                        label: "XSmall",
                        value: PicnicButtonBorderWidth.small,
                      ),
                      Option(
                        label: "Small",
                        value: PicnicButtonBorderWidth.regular,
                      ),
                      Option(
                        label: "Medium",
                        value: PicnicButtonBorderWidth.large,
                      ),
                      Option(
                        label: "XLarge",
                        value: PicnicButtonBorderWidth.xlarge,
                      ),
                    ],
                  ),
                  titleColor: context.knobs.options(
                    label: 'Title Color',
                    options: colorOptions,
                  ),
                  icon: context.knobs.options(
                    label: 'Button Icon',
                    options: [
                      const Option(
                        label: "No icon",
                        value: null,
                      ),
                      Option(
                        label: "Edit",
                        value: Assets.images.edit.path,
                      ),
                      Option(
                        label: "Bookmark",
                        value: Assets.images.bookmark.path,
                      ),
                      Option(
                        label: "Message",
                        value: Assets.images.message.path,
                      ),
                      Option(
                        label: "Person",
                        value: Assets.images.person.path,
                      ),
                      Option(
                        label: "Circle chat",
                        value: Assets.images.chat.path,
                      ),
                      Option(
                        label: "Join star",
                        value: Assets.images.star.path,
                      ),
                      Option(
                        label: "Ownership briefcase",
                        value: Assets.images.briefcase.path,
                      ),
                      Option(
                        label: "Pin",
                        value: Assets.images.pin.path,
                      )
                    ],
                  ),
                  padding: context.knobs.options(
                    label: 'Padding',
                    options: [
                      const Option(
                        label: "Horizontal 20 Vertical 16",
                        value: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 20,
                        ),
                      ),
                      const Option(
                        label: "Horizontal 10 Vertical 8",
                        value: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                      ),
                    ],
                  ),
                  minWidth: context.knobs.options(
                    label: 'Min Width',
                    options: [
                      const Option(
                        label: "None",
                        value: null,
                      ),
                      Option(
                        label: "Small",
                        value: PicnicButtonMinimumWidth.small,
                      ),
                      Option(
                        label: "Regular",
                        value: PicnicButtonMinimumWidth.regular,
                      ),
                      Option(
                        label: "Large",
                        value: PicnicButtonMinimumWidth.large,
                      ),
                    ],
                  ),
                  borderColor: context.knobs.options(
                    label: 'Border Color',
                    options: colorOptions,
                  ),
                  suffix: context.knobs.options(
                    label: "Suffix",
                    options: [
                      const Option(
                        label: "None",
                        value: null,
                      ),
                      Option(
                        label: "Image",
                        value: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Assets.images.picnicLogo.image(width: 10, height: 10),
                        ),
                      ),
                      const Option(
                        label: "Text",
                        value: Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("some text"),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
}
