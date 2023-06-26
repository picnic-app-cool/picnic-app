// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presenter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

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
    return stateObserver(
      builder: (context, state) {
        final themeData = PicnicTheme.of(context);
        final blackAndWhite = themeData.colors.blackAndWhite;
        return FractionallySizedBox(
          // ignore: no-magic-number
          heightFactor: 0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "permissions",
                            style: themeData.styles.title60,
                          ),
                          const Gap(8),
                          Text(
                            "enhancing your experience",
                            style: themeData.styles.body30.copyWith(color: blackAndWhite.shade600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Assets.images.notificationBell.image(
                      // ignore: no-magic-number
                      width: 40,
                      // ignore: no-magic-number
                      height: 40,
                      fit: BoxFit.contain,
                      color: const Color.fromRGBO(
                        160,
                        170,
                        189,
                        1,
                      ),
                    ),
                  ],
                ),
                const Gap(24),
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
                const Spacer(),
                // ignore: no-magic-number
                PicnicTextButton(
                  label: "skip for now",
                  labelStyle: theme.styles.link30.copyWith(
                    color: const Color.fromRGBO(
                      110,
                      126,
                      145,
                      1,
                    ),
                  ),
                  onTap: presenter.onTapSkip,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
