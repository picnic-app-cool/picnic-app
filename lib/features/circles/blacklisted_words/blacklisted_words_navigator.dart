import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_word_blacklist/add_black_list_word_navigator.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_initial_params.dart';
import 'package:picnic_app/features/circles/blacklisted_words/blacklisted_words_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';

class BlacklistedWordsNavigator
    with AddBlackListWordRoute, CloseRoute, ConfirmationBottomSheetRoute, ErrorBottomSheetRoute {
  BlacklistedWordsNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin BlacklistedWordsRoute {
  Future<void> openBlacklistedWords(BlacklistedWordsInitialParams initialParams) async {
    return appNavigator.push(
      materialRoute(getIt<BlacklistedWordsPage>(param1: initialParams)),
    );
  }

  AppNavigator get appNavigator;
}
