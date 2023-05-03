import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';

class RemoveReasonNavigator with CloseWithResultRoute<String>, CloseRoute {
  RemoveReasonNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin RemoveReasonRoute {
  Future<String?> openRemoveReason(RemoveReasonInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<RemoveReasonPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
