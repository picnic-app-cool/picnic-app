import 'package:picnic_app/ui/widgets/text/picnic_columned_text_link.dart';
import 'package:widgetbook/widgetbook.dart';

class PicnicColumnedTextLinkComponent extends WidgetbookComponent {
  PicnicColumnedTextLinkComponent()
      : super(
          name: "$PicnicColumnedTextLink",
          useCases: [
            WidgetbookUseCase(
              name: "Default",
              builder: (context) => PicnicColumnedTextLink(
                text: context.knobs.text(label: 'text', initialValue: 'mid'),
                onTapShareCircleLink: () {},
              ),
            )
          ],
        );
}
