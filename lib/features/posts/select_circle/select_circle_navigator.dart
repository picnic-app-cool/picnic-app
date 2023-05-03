import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/feature_disabled_bottom_sheet_route.dart';

class SelectCircleNavigator
    with CreateCircleRoute, ErrorBottomSheetRoute, MainRoute, FeatureDisabledBottomSheetRoute, CloseRoute {
  SelectCircleNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin SelectCircleRoute {
  Future<void> openSelectCircle(SelectCircleInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<SelectCirclePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
