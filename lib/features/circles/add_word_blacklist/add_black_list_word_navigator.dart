import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_initial_params.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class AddBlackListWordNavigator with CloseRoute, ErrorBottomSheetRoute, CloseWithResultRoute<bool> {
  AddBlackListWordNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin AddBlackListWordRoute {
  Future<bool?> openAddWordBlackList(AddBlackListWordInitialParams initialParams) => showPicnicBottomSheet<bool?>(
        getIt<AddBlackListWordPage>(param1: initialParams),
      );

  AppNavigator get appNavigator;
}
