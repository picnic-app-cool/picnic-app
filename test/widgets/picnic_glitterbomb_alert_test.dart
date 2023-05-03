import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/ui/widgets/picnic_glitterbomb_alert.dart';

import '../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_glitterbomb_alert',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'glitterbomb alert',
          child: TestWidgetContainer(
            child: PicnicGlitterBombAlert(
              avatarImage: const ImageUrl('😍'),
              onTapGlitterbombBack: () => {},
              senderUsername: 'username',
            ),
          ),
        ),
      ],
    ),
  );
}
