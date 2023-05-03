import 'package:alchemist/alchemist.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/buttom_sheet/picnic_vertical_action_bottom_sheet.dart';

import '../../test_utils/golden_tests_utils.dart';

void main() {
  screenshotTest(
    "picnic_vertical_action_bottom_sheet_golden_test",
    pageBuilder: () {
      return GoldenTestScenario(
        name: "picnic action bottom sheet",
        child: PicnicVerticalActionBottomSheet(
          title: "Title",
          description: "description for the action",
          actions: [
            ActionBottom(
              label: appLocalizations.shareAction,
              action: () => notImplemented(),
              icon: Assets.images.share.path,
              isPrimary: true,
            ),
            ActionBottom(
              label: appLocalizations.reportAction,
              action: () => notImplemented(),
              icon: Assets.images.infoOutlined.path,
            ),
            ActionBottom(
              label: appLocalizations.blockAction,
              action: () => notImplemented(),
              icon: Assets.images.block.path,
            ),
          ],
          onTapClose: () => notImplemented(),
        ),
      );
    },
  );
}
