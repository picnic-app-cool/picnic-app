import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/language/language_initial_params.dart';
import 'package:picnic_app/features/settings/language/language_page.dart';
import 'package:picnic_app/features/settings/language/widgets/language_info_bottom_sheet.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

class LanguageNavigator with ErrorBottomSheetRoute, LanguageInfoRoute {
  LanguageNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin LanguageRoute {
  void openLanguage(LanguageInitialParams initialParams) {
    appNavigator.push(
      materialRoute(getIt<LanguagePage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
mixin LanguageInfoRoute {
  void showLanguageInfo() => showPicnicBottomSheet(
        LanguageInfoBottomSheet(
          onTap: appNavigator.close,
        ),
      );

  AppNavigator get appNavigator;
}
