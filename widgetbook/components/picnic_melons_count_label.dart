import 'package:flutter/material.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_melons_count_label.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicMelonsCountLabelUseCases extends WidgetbookComponent {
  PicnicMelonsCountLabelUseCases()
      : super(
          name: "$PicnicMelonsCountLabel",
          useCases: [
            WidgetbookUseCase(
              name: "Melons Count Label Use Cases",
              builder: (context) {
                final themeColors = PicnicTheme.of(context).colors;
                final themeStyles = PicnicTheme.of(context).styles;

                return PicnicMelonsCountLabel(
                  label: context.knobs.text(
                    label: 'Label Text',
                    initialValue: 'you have 0 melons',
                  ),
                  backgroundColor: context.knobs.options(
                    label: 'Label Background Color',
                    options: [
                      Option(
                        label: 'Grey',
                        value: themeColors.blackAndWhite.shade200,
                      ),
                      Option(
                        label: 'Pink',
                        value: themeColors.pink.shade100,
                      ),
                      Option(
                        label: 'Blue',
                        value: themeColors.blue.shade100,
                      ),
                      Option(
                        label: 'Green',
                        value: themeColors.green.shade100,
                      ),
                      Option(
                        label: 'Yellow',
                        value: themeColors.yellow.shade100,
                      ),
                    ],
                  ),
                  suffix: context.knobs.options(
                    label: 'Trailing',
                    options: [
                      const Option(
                        label: 'None',
                        value: null,
                      ),
                      Option(
                        label: 'Text Button',
                        value: PicnicTextButton(
                          label: 'view seeds',
                          labelStyle: themeStyles.body30.copyWith(
                            color: themeColors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                  prefix: context.knobs.options(
                    label: 'Leading',
                    options: [
                      const Option(
                        label: 'None',
                        value: null,
                      ),
                      Option(
                        label: 'Image',
                        value: Image.asset(
                          Assets.images.watermelonWhole.path,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
}
