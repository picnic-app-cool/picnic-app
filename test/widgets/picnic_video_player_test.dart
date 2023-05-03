import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/core/domain/model/video_url.dart';
import 'package:picnic_app/ui/widgets/video_player/picnic_video_player.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  // TODO: we definitely need to write more tests for this widget to cover all functionality it provides,
  // but due to its platform-dependent nature it is problematic

  widgetScreenshotTest(
    "picnic_video_player",
    widgetBuilder: (context) {
      final colors = PicnicTheme.of(context).colors;

      return GoldenTestGroup(
        columns: 2,
        children: [
          GoldenTestScenario(
            name: "player with empty url",
            child: const TestWidgetContainer(
              child: PicnicVideoPlayer(
                url: VideoUrl.empty(),
              ),
            ),
          ),
          GoldenTestScenario(
            name: "player with empty url and background color",
            child: TestWidgetContainer(
              child: TestWidgetContainer(
                child: PicnicVideoPlayer(
                  url: const VideoUrl.empty(),
                  backgroundColor: colors.green,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
