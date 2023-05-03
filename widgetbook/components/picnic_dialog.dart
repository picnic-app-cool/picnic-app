import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog_title.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicDialogUseCases extends WidgetbookComponent {
  PicnicDialogUseCases()
      : super(
          name: "$PicnicDialog",
          useCases: [
            WidgetbookUseCase(
              name: "Dialog Use Cases",
              builder: (context) => PicnicDialog(
                image: PicnicAvatar(
                  size: context.knobs.slider(
                    label: 'Dialog Emoji Container Size',
                    initialValue: 100,
                    min: 1,
                    max: 200,
                  ),
                  backgroundColor: context.knobs.options(
                    label: 'Dialog Emoji Background Color',
                    options: [
                      const Option(
                        label: 'Avatar Grey',
                        value: Color(0XFFf2f2f2),
                      ),
                      const Option(
                        label: 'Avatar Blue',
                        value: Color(0XFFDEEFFF),
                      ),
                      const Option(
                        label: 'Avatar White',
                        value: Colors.white,
                      ),
                    ],
                  ),
                  showShadow: context.knobs.boolean(
                    label: 'Show Emoji Container Shadow',
                  ),
                  imageSource: PicnicImageSource.emoji(
                    context.knobs.text(
                      label: 'Dialog Emoji',
                      initialValue: '🎂',
                    ),
                    style: const TextStyle(
                      fontSize: Constants.onboardingEmojiSize,
                    ),
                  ),
                ),
                imageStyle: context.knobs.options(
                  label: 'Dialog Image Style',
                  options: [
                    const Option(
                      label: 'Inside',
                      value: PicnicDialogImageStyle.inside,
                    ),
                    const Option(
                      label: 'Outside',
                      value: PicnicDialogImageStyle.outside,
                    ),
                  ],
                ),
                title: context.knobs.text(
                  label: 'Dialog Title',
                  initialValue: 'Title',
                ),
                titleSize: context.knobs.options(
                  label: 'Dialog Title Size',
                  options: [
                    const Option(
                      label: 'Normal',
                      value: PicnicDialogTitleSize.normal,
                    ),
                    const Option(
                      label: 'Large',
                      value: PicnicDialogTitleSize.large,
                    ),
                  ],
                ),
                description: context.knobs.text(
                  label: 'Dialog Description',
                  initialValue: 'dialog description',
                ),
                content: const SizedBox.shrink(),
              ),
            ),
          ],
        );
}
