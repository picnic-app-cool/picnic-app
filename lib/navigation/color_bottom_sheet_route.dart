import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/color_selection/picnic_color_selection.dart';
import 'package:picnic_app/ui/widgets/confirmation_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

mixin ColorBottomSheetRoute {
  AppNavigator get appNavigator;

  // TODO Color Picker actions https://picnic-app.atlassian.net/browse/GS-6187
  void showColorBottomSheet({
    required Function(String) onTextColorSelected,
    required String selectedTextColor,
  }) {
    final currentContext = AppNavigator.currentContext;
    showPicnicBottomSheet(
      ConfirmationBottomSheet(
        title: appLocalizations.colorPicker,
        message: '',
        color: PicnicTheme.of(currentContext).colors.green.shade500,
        contentWidget: PicnicColorSelection(
          options: TextColor.selectableCircleValues,
          onColorTextSelected: (textColor) => onTextColorSelected(textColor.name),
          selectedTextColor: TextColor.fromString(selectedTextColor),
        ),
        primaryAction: ConfirmationAction(
          roundedButton: true,
          title: appLocalizations.confirmAction,
          action: () => appNavigator.close(),
        ),
        secondaryAction: ConfirmationAction(
          title: appLocalizations.closeAction,
          action: () => appNavigator.close(),
        ),
        titleAction: ConfirmationAction(
          title: appLocalizations.resetTitle,
          action: () => appNavigator.close(),
        ),
      ),
    );
  }
}
