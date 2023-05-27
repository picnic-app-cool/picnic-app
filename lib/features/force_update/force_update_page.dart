import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/force_update/force_update_picnic_logo.dart';
import 'package:picnic_app/features/force_update/force_update_presentation_model.dart';
import 'package:picnic_app/features/force_update/force_update_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_background.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class ForceUpdatePage extends StatefulWidget with HasPresenter<ForceUpdatePresenter> {
  const ForceUpdatePage({
    super.key,
    required this.presenter,
  });

  @override
  final ForceUpdatePresenter presenter;

  @override
  State<ForceUpdatePage> createState() => _ForceUpdatePageState();
}

class _ForceUpdatePageState extends State<ForceUpdatePage>
    with PresenterStateMixin<ForceUpdateViewModel, ForceUpdatePresenter, ForceUpdatePage> {
  static const _horizontalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Stack(
      children: [
        const PicnicBackground(),
        OnboardingPageContainer(
          dialog: PicnicDialog(
            dialogPadding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
            content: stateObserver(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ForceUpdatePicnicLogo(),
                    const Gap(16),
                    Text(
                      appLocalizations.newReleaseTitle,
                      style: theme.styles.subtitle40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _horizontalPadding,
                      ),
                      child: Text(
                        appLocalizations.newReleaseLabel,
                        style: theme.styles.body30.copyWith(color: colors.blackAndWhite.shade600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(28),
                    PicnicButton(
                      color: theme.colors.blue,
                      onTap: presenter.onTapUpdate,
                      size: PicnicButtonSize.large,
                      title: appLocalizations.newReleaseUpdateButtonLabel,
                    ),
                    const Gap(20),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
