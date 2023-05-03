import 'package:widgetbook/widgetbook.dart';
import '../components/diagrams/picnic_binary_percentage_progress_bar.dart';
import '../components/diagrams/picnic_half_circle_dots_progress_bar.dart';

class DiagamsFolder extends WidgetbookFolder {
  DiagamsFolder()
      : super(
          name: "Diagrams",
          widgets: [
            PicnicHalfCircleDotsProgressBarComponent(),
            PicnicBinaryPercentageProgressBarComponent(),
          ],
        );
}
