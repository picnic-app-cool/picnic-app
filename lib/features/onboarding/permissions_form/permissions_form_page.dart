// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class PermissionsFormPage extends StatefulWidget with HasPresenter<PermissionsFormPresenter> {
  const PermissionsFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PermissionsFormPresenter presenter;

  @override
  State<PermissionsFormPage> createState() => _PermissionsFormPageState();
}

class _PermissionsFormPageState extends State<PermissionsFormPage>
    with PresenterStateMixin<PermissionsFormViewModel, PermissionsFormPresenter, PermissionsFormPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeBlue = theme.colors.blue;
    final blue = themeBlue;
    final darkBlue = themeBlue.shade600;
    return OnboardingPageContainer(
      dialog: PicnicDialog(
        image: PicnicAvatar(
          backgroundColor: theme.colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
          imageSource: PicnicImageSource.emoji(
            '🔥',
            style: const TextStyle(
              fontSize: Constants.onboardingEmojiSize,
            ),
          ),
        ),
        title: appLocalizations.permissionLabel,
        description: appLocalizations.permissionsDescription,
        content: stateObserver(
          builder: (context, state) => SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.notificationsPermissionShouldBeRequested)
                  PicnicButton(
                    onTap: state.notificationsPermissionAlreadyRequested ? null : presenter.onTapEnableNotifications,
                    title: appLocalizations.notificationAppBarTitle,
                    color: state.notificationsPermissionGranted ? darkBlue : blue,
                  ),
                const Gap(8),
                PicnicButton(
                  onTap: state.contactsPermissionAlreadyRequested ? null : presenter.onTapEnableContacts,
                  title: appLocalizations.contacts,
                  color: state.contactsPermissionGranted ? darkBlue : blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
