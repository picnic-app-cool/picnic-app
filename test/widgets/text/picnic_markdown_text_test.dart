import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/ui/widgets/text/picnic_markdown_text.dart';
import '../../test_utils/golden_tests_utils.dart';

void main() {
  widgetScreenshotTest(
    'picnic_markdown_text',
    widgetBuilder: (context) => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'normal text',
          child: const TestWidgetContainer(
            child: PicnicMarkdownText(
              markdownSource: 'Normal text',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'link text',
          child: const TestWidgetContainer(
            child: PicnicMarkdownText(
              markdownSource: '[Link Text](link)',
            ),
          ),
        ),
        GoldenTestScenario(
          name: 'normal text with link',
          child: const TestWidgetContainer(
            child: PicnicMarkdownText(
              markdownSource: 'Normal text with [Link](link)',
            ),
          ),
        ),
      ],
    ),
  );
}
