import 'package:flutter/material.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/text/picnic_markdown_text.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicMarkdownTextComponent extends WidgetbookComponent {
  PicnicMarkdownTextComponent()
      : super(
          name: '$PicnicMarkdownText',
          useCases: [
            WidgetbookUseCase(
              name: 'Picnic Markdown Text Use Cases',
              builder: (context) {
                final _defaultMarkdown = appLocalizations.communityGuidelinesSectionFour;
                final colors = PicnicTheme.of(context).colors;
                final colorOptions = [
                  Option(
                    label: "Black",
                    value: colors.blackAndWhite.shade900,
                  ),
                  Option(
                    label: "Light blue",
                    value: colors.lightBlue,
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
                    label: "Light grey",
                    value: colors.blackAndWhite.shade200,
                  ),
                ];
                final fontWeightOptions = [
                  const Option(
                    label: '100',
                    value: FontWeight.w100,
                  ),
                  const Option(
                    label: '200',
                    value: FontWeight.w200,
                  ),
                  const Option(
                    label: '300',
                    value: FontWeight.w300,
                  ),
                  const Option(
                    label: '400',
                    value: FontWeight.w400,
                  ),
                  const Option(
                    label: '500',
                    value: FontWeight.w500,
                  ),
                  const Option(
                    label: '600',
                    value: FontWeight.w600,
                  ),
                  const Option(
                    label: '700',
                    value: FontWeight.w700,
                  ),
                  const Option(
                    label: '800',
                    value: FontWeight.w800,
                  ),
                  const Option(
                    label: '900',
                    value: FontWeight.w900,
                  ),
                ];

                return PicnicMarkdownText(
                  markdownSource: context.knobs.text(
                    label: 'Markdown source',
                    initialValue: _defaultMarkdown,
                  ),
                  selectableText: context.knobs.boolean(
                    label: 'Selectable text',
                  ),
                  padding: EdgeInsets.all(
                    context.knobs.slider(
                      label: 'Padding',
                      min: 0,
                      max: 50,
                      initialValue: 0,
                    ),
                  ),
                  linkStyle: TextStyle(
                    color: context.knobs.options(
                      label: 'Link color',
                      options: colorOptions,
                    ),
                    fontSize: context.knobs
                        .number(
                          label: 'Link font size',
                          initialValue: 16.0,
                        )
                        .toDouble(),
                    fontWeight: context.knobs.options(
                      label: 'Link font weight',
                      options: fontWeightOptions,
                    ),
                  ),
                  textStyle: TextStyle(
                    color: context.knobs.options(
                      label: 'Text color',
                      options: colorOptions,
                    ),
                    fontSize: context.knobs
                        .number(
                          label: 'Text font size',
                          initialValue: 16.0,
                        )
                        .toDouble(),
                    fontWeight: context.knobs.options(
                      label: 'Text font weight',
                      options: fontWeightOptions,
                    ),
                  ),
                );
              },
            ),
          ],
        );
}
