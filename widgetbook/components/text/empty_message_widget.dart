import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/empty_message_widget.dart';
import 'package:widgetbook/widgetbook.dart';

class EmptyMessageWidgetComponent extends WidgetbookComponent {
  EmptyMessageWidgetComponent()
      : super(
          name: "$EmptyMessageWidget",
          useCases: [
            WidgetbookUseCase(
              name: "Default",
              builder: (context) => EmptyMessageWidget(
                message: context.knobs.text(label: 'message', initialValue: appLocalizations.emptyUserCirclesMessage),
              ),
            )
          ],
        );
}
