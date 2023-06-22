//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_page.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';
import 'package:picnic_app/navigation/share_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class CircleBottomSheetNavigator
    with
        NoRoutes,
        CircleChatRoute,
        ErrorBottomSheetRoute,
        PostCreationIndexRoute,
        CloseRoute,
        FeatureDisabledBottomSheetRoute,
        ShareRoute,
        CircleDetailsRoute {
  CircleBottomSheetNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleBottomSheetRoute {
  Future<void> openCircleBottomSheet(CircleBottomSheetInitialParams initialParams) async {
    return showPicnicBottomSheet(
      getIt<CircleBottomSheetPage>(param1: initialParams),
    );
  }

  AppNavigator get appNavigator;
}
