import 'dart:ui';

import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_navigator.dart';
import 'package:picnic_app/features/circles/circle_groups_selection/circle_groups_selection_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_page.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/change_circle_avatar_button.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/main/languages_list/languages_list_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/image_editor_route.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/two_options_bottom_sheet.dart';

class CreateCircleNavigator
    with
        CircleCreationRulesRoute,
        CircleGroupsSelectionRoute,
        AvatarSelectionRoute,
        LanguagesListRoute,
        ErrorBottomSheetRoute,
        CircleCreationSuccessRoute,
        ChangeCircleAvatarRoute,
        ImagePickerRoute,
        ImageEditorRoute,
        AboutElectionsRoute,
        CircleConfigRoute {
  CreateCircleNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin CreateCircleRoute {
  Future<void> openCreateCircle(
    CreateCircleInitialParams initialParams, {
    bool useRoot = false,
  }) async {
    return appNavigator.push(
      materialRoute(getIt<CreateCirclePage>(param1: initialParams)),
      useRoot: useRoot,
    );
  }

  AppNavigator get appNavigator;
}

mixin ChangeCircleAvatarRoute {
  void showCircleAvatarBottomSheet({
    required VoidCallback onTapUploadPicture,
    required VoidCallback onTapSelectEmoji,
  }) =>
      showPicnicBottomSheet<bool?>(
        TwoOptionsBottomSheet(
          title: appLocalizations.circleAvatarTitle,
          subtitle: appLocalizations.circleAvatarSubtitle,
          footer: appLocalizations.closeAction,
          primaryButton: ChangeCircleAvatarButton(
            text: appLocalizations.circleAvatarPicture,
            tapAction: () {
              appNavigator.close();
              onTapUploadPicture.call();
            },
            filled: true,
          ),
          onTapFooter: () => appNavigator.close(),
          secondaryButton: ChangeCircleAvatarButton(
            text: appLocalizations.circleAvatarEmoji,
            tapAction: () {
              appNavigator.close();
              onTapSelectEmoji.call();
            },
            filled: false,
          ),
        ),
      );

  AppNavigator get appNavigator;
}
