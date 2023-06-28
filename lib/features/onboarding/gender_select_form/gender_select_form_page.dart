// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/widgets/gender_select_form_dialog_content.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class GenderSelectFormPage extends StatefulWidget with HasPresenter<GenderSelectFormPresenter> {
  const GenderSelectFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final GenderSelectFormPresenter presenter;

  @override
  State<GenderSelectFormPage> createState() => _GenderSelectFormPageState();
}

class _GenderSelectFormPageState extends State<GenderSelectFormPage>
    with PresenterStateMixin<GenderSelectFormViewModel, GenderSelectFormPresenter, GenderSelectFormPage> {
  static const _personIconSize = 40.0;
  static const _enabledButtonOpacity = 1.0;
  static const _disabledButtonOpacity = 0.5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final darkBlue600 = darkBlue.shade600;
    final blackAndWhite600 = colors.blackAndWhite.shade600;
    return Scaffold(
      appBar: PicnicAppBar(
        actions: [
          Center(
            child: GestureDetector(
              onTap: presenter.onTapSkip,
              child: Text(
                appLocalizations.skipAction,
                style: theme.styles.link20.copyWith(color: darkBlue600),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Assets.images.profileIconPlaceholder.image(
                  width: _personIconSize,
                  height: _personIconSize,
                  fit: BoxFit.contain,
                  color: darkBlue,
                ),
                const Gap(8),
                Text(
                  textAlign: TextAlign.center,
                  appLocalizations.aboutYou,
                  style: theme.styles.title60,
                ),
                const Gap(8),
                Text(
                  appLocalizations.aboutYouDescription,
                  style: theme.styles.body30.copyWith(color: blackAndWhite600),
                  textAlign: TextAlign.center,
                ),
                const Gap(16),
                Text(
                  textAlign: TextAlign.center,
                  appLocalizations.iAm,
                  style: theme.styles.subtitle15.copyWith(color: blackAndWhite600),
                ),
                const Gap(16),
                stateObserver(
                  builder: (context, state) {
                    return GenderSelectFormDialogContent(
                      theme: theme,
                      state: state,
                      onTapSelectGender: presenter.onTapSelectGender,
                    );
                  },
                ),
              ],
            ),
            const Spacer(),
            stateObserver(
              builder: (context, state) => PicnicButton(
                opacity: state.isContinueEnabled ? _enabledButtonOpacity : _disabledButtonOpacity,
                onTap: state.isContinueEnabled ? presenter.onTapContinue : null,
                color: colors.blue,
                title: appLocalizations.continueAction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
