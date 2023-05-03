import 'package:widgetbook/widgetbook.dart';

import '../components/misc/picnic_loading_indicator.dart';

class MiscFolder extends WidgetbookFolder {
  MiscFolder()
      : super(
          name: "Misc",
          widgets: [
            PicnicLoadingIndicatorUseCases(),
          ],
        );
}
