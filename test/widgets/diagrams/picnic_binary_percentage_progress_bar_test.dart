import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/diagrams/picnic_binary_percentage_progress_bar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

import '../../test_utils/golden_tests_utils.dart';

void main() {
  final avatar = PicnicAvatar(
    size: 20,
    imageSource: PicnicImageSource.emoji(
      '🥸',
      style: const TextStyle(fontSize: 10),
    ),
  );

  widgetScreenshotTest(
    "picnic_binary_percentage_progress_bar",
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: "regular case with avatar on left",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 62,
            isAvatarOnLeftPart: true,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "regular case with avatar on right",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 62,
            isAvatarOnLeftPart: false,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "left corner case with avatar",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 1,
            isAvatarOnLeftPart: true,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "left corner case without avatar",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 1,
            isAvatarOnLeftPart: false,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "right corner case with avatar",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 99,
            isAvatarOnLeftPart: true,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "right corner case without avatar",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 99,
            isAvatarOnLeftPart: false,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "right corner case with avatar",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 0,
            isAvatarOnLeftPart: false,
            avatar: avatar,
          ),
        ),
        GoldenTestScenario(
          name: "right corner case without avatar",
          child: PicnicBinaryPercentageProgressBar(
            leftPartPercentage: 100,
            isAvatarOnLeftPart: true,
            avatar: avatar,
          ),
        ),
      ],
    ),
  );
}
