import 'package:picnic_app/core/domain/model/language.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_initial_params.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class LanguagesListNavigator with CloseWithResultRoute<Language>, CloseRoute {
  LanguagesListNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin LanguagesListRoute {
  Future<Language?> openLanguagesList(LanguagesListInitialParams initialParams) =>
      showPicnicBottomSheet(getIt<LanguagesListPage>(param1: initialParams));

  AppNavigator get appNavigator;
}
