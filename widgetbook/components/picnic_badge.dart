import 'package:picnic_ui_components/ui/widgets/picnic_badge.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicBadgeUseCase extends WidgetbookComponent {
  PicnicBadgeUseCase()
      : super(
          name: "$PicnicBadge",
          useCases: [
            WidgetbookUseCase(
              name: "Picnic Badge Use Case",
              builder: (context) => PicnicBadge(
                count: context.knobs.number(label: 'Count').toInt(),
              ),
            ),
          ],
        );
}
