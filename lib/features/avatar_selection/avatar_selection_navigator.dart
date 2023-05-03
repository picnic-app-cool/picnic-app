import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';

class AvatarSelectionNavigator with CloseWithResultRoute<String> {
  AvatarSelectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AvatarSelectionRoute {
  Future<String?> openAvatarSelection(AvatarSelectionInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<AvatarSelectionPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
