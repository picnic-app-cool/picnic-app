import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/no_routes.dart';

class EditSliceRulesNavigator with NoRoutes, CloseWithResultRoute<Slice>, ErrorBottomSheetRoute {
  EditSliceRulesNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin EditSliceRulesRoute {
  Future<Slice?> openEditSliceRules(EditSliceRulesInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<EditSliceRulesPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
