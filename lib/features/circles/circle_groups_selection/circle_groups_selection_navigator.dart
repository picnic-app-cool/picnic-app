import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_page.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/model/selectable_circle_group.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class CircleGroupsSelectionNavigator with CloseWithResultRoute<SelectableCircleGroup> {
  CircleGroupsSelectionNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CircleGroupsSelectionRoute {
  Future<SelectableCircleGroup?> openCircleGroupsSelection(CircleGroupsSelectionInitialParams initialParams) =>
      showPicnicBottomSheet(getIt<CircleGroupsSelectionPage>(param1: initialParams));

  AppNavigator get appNavigator;
}
