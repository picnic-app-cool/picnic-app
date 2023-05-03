import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_bottom_sheet.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/domain/model/circle_chat_settings_page_result.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class CircleChatSettingsNavigator
    with
        CloseRoute,
        CircleDetailsRoute,
        ShareRoute,
        ReportFormRoute,
        ErrorBottomSheetRoute,
        CloseWithResultRoute<CircleChatSettingsPageResult> {
  CircleChatSettingsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleChatSettingsRoute {
  Future<CircleChatSettingsPageResult?> openCircleChatSettingsBottomSheet(
    CircleChatSettingsInitialParams initialParams,
  ) async {
    return showPicnicBottomSheet(
      getIt<CircleChatSettingsBottomSheet>(param1: initialParams),
    );
  }
}
