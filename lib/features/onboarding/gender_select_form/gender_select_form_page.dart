// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/gender_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/gender_select_form/widgets/gender_select_form_dialog_content.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

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
  static const _contentPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    top: Constants.toolbarHeight + 24.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final textColor = theme.colors.blackAndWhite.shade600;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: _contentPadding,
          child: stateObserver(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalizations.aboutYou,
                                  style: theme.styles.title60,
                                ),
                                const Gap(8),
                                Text(
                                  appLocalizations.aboutYouDescription,
                                  style: theme.styles.body30.copyWith(color: textColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          // ignore: no-magic-number
                          Assets.images.personOutline.image(
                            // ignore: no-magic-number
                            width: 40,
                            // ignore: no-magic-number
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const Gap(24),
                    ],
                  ),
                  GenderSelectFormDialogContent(
                    theme: theme,
                    state: state,
                    onTapSelectGender: presenter.onTapSelectGender,
                  ),
                  const Spacer(),
                  PicnicButton(
                    onTap: state.isContinueEnabled ? presenter.onTapContinue : null,
                    color: theme.colors.blue,
                    title: appLocalizations.continueAction,
                  ),
                  const Gap(6),
                  PicnicTextButton(
                    onTap: presenter.onTapContinue,
                    label: appLocalizations.skipAction,
                    labelStyle: theme.styles.body20.copyWith(color: textColor),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
