import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/ui/widgets/picnic_square.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_square",
    widgetBuilder: (context) {
      final styles = PicnicTheme.of(context).styles;
      final colors = PicnicTheme.of(context).colors;

      return GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: "member with title Body 20",
            child: TestWidgetContainer(
              child: PicnicSquare(
                avatarBackgroundColor: colors.blackAndWhite.shade200,
                emoji: Constants.heartEmoji,
                title: "fan edits",
                titleStyle: styles.body20,
                imagePath: '',
              ),
            ),
          ),
          GoldenTestScenario(
            name: "royalty member with title Body 20",
            child: TestWidgetContainer(
              child: PicnicSquare(
                isRoyalty: true,
                avatarBackgroundColor: colors.blackAndWhite.shade200,
                emoji: Constants.heartEmoji,
                title: "fan edits",
                titleStyle: styles.body20,
                imagePath: '',
              ),
            ),
          ),
          GoldenTestScenario(
            name: "user seeds count with title Body 10 and subtitle and no border",
            child: TestWidgetContainer(
              child: PicnicSquare(
                avatarBackgroundColor: colors.lightBlue.shade200,
                emoji: Constants.heartEmoji,
                title: "@payamdaliri",
                subTitle: "200 seeds",
                titleStyle: styles.body20,
                imagePath: '',
              ),
            ),
          ),
          GoldenTestScenario(
            name: "user seeds count with title Body 10 and subtitle and light blue border ",
            child: TestWidgetContainer(
              child: PicnicSquare(
                avatarBackgroundColor: colors.lightBlue.shade200,
                emoji: Constants.heartEmoji,
                title: "@payamdaliri",
                borderColor: colors.lightBlue,
                subTitle: "200 seeds",
                titleStyle: styles.body20,
                imagePath: '',
              ),
            ),
          ),
          GoldenTestScenario(
            name: "user seeds count with title Body 10 and subtitle and light green border ",
            child: TestWidgetContainer(
              child: PicnicSquare(
                avatarBackgroundColor: colors.lightBlue.shade200,
                emoji: Constants.heartEmoji,
                title: "@payamdaliri",
                borderColor: colors.green,
                subTitle: "200 seeds",
                titleStyle: styles.body20,
                imagePath: '',
              ),
            ),
          )
        ],
      );
    },
  );
}
