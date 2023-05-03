import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/diagrams/picnic_binary_percentage_progress_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicBinaryPercentageProgressBarComponent extends WidgetbookComponent {
  PicnicBinaryPercentageProgressBarComponent()
      : super(
          name: "$PicnicBinaryPercentageProgressBar",
          useCases: [
            WidgetbookUseCase(
              name: "Default",
              builder: (context) => PicnicBinaryPercentageProgressBar(
                leftPartPercentage: context.knobs
                    .slider(
                      label: 'progress',
                      //ignore: no-magic-number
                      initialValue: 62,
                      min: 0,
                      //ignore: no-magic-number
                      max: 100,
                    )
                    .toInt(),
                isAvatarOnLeftPart: context.knobs.boolean(
                  label: 'avatar on left part?',
                ),
                avatar: PicnicAvatar(
                  size: 20,
                  imageSource: PicnicImageSource.emoji(
                    '🥸',
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            )
          ],
        );
}
