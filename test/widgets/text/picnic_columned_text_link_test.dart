import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/ui/widgets/text/picnic_columned_text_link.dart';

import '../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    "picnic_columned_text_link",
    widgetBuilder: (context) {
      return GoldenTestScenario(
        name: "Columned text",
        child: TestWidgetContainer(
          child: PicnicColumnedTextLink(
            text: "director",
            onTapShareCircleLink: () {},
          ),
        ),
      );
    },
  );
}
