//Figma Link :
//https://www.figma.com/file/6jHfRx6qqnUyQ25IWCziNK/Picnic-Redesign?node-id=4%3A623

import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_square.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicCircleSquareUseCases extends WidgetbookComponent {
  PicnicCircleSquareUseCases()
      : super(
          name: "$PicnicSquare",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Circle Square Use Case",
              builder: (context) {
                final styles = PicnicTheme.of(context).styles;
                final themeColors = PicnicTheme.of(context).colors;

                return Center(
                  child: PicnicSquare(
                    borderColor: context.knobs.options(
                      label: 'Border Color',
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
                    avatarBackgroundColor: context.knobs.options(
                      label: 'Avatar Background Color',
                      options: [
                        Option(
                          label: "Light Blue",
                          value: themeColors.lightBlue.shade200,
                        ),
                        Option(
                          label: "Grey",
                          value: themeColors.blackAndWhite.shade200,
                        ),
                        const Option(
                          label: "None",
                          value: null,
                        ),
                      ],
                    ),
                    subTitle: context.knobs.options(
                      label: 'Subtitle Text',
                      options: [
                        const Option(
                          label: "None",
                          value: null,
                        ),
                        const Option(
                          label: "Seed",
                          value: "200 seeds",
                        ),
                      ],
                    ),
                    title: context.knobs.options(
                      label: 'Title',
                      options: [
                        const Option(
                          label: "fan edits",
                          value: "fan edits",
                        ),
                        const Option(
                          label: "user",
                          value: "@payamdaliri",
                        ),
                      ],
                    ),
                    titleStyle: context.knobs.options(
                      label: 'Title Text Style',
                      options: [
                        Option(
                          label: "Body 20",
                          value: styles.body20,
                        ),
                        Option(
                          label: "Body 10",
                          value: styles.body10,
                        ),
                      ],
                    ),
                    emoji: '❤️',
                    isRoyalty: context.knobs.options(
                      label: 'Top Member',
                      options: [
                        const Option(
                          label: "No",
                          value: false,
                        ),
                        const Option(
                          label: "Top Member",
                          value: true,
                        ),
                      ],
                    ),
                    imagePath: '',
                  ),
                );
              },
            ),
          ],
        );
}
