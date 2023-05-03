import 'package:picnic_app/core/fx_effect_overlay/fx_effect_route.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class SingleChatSettingsNavigator with ErrorBottomSheetRoute, ReportFormRoute, PublicProfileRoute, FxEffectRoute {
  SingleChatSettingsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SingleChatSettingsRoute {
  Future<void> openSingleChatSettings(SingleChatSettingsInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<SingleChatSettingsPage>(param1: initialParams),
    );
  }

  AppNavigator get appNavigator;
}
