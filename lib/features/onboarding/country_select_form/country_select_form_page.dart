// ignore: unused_import
import 'dart:async';

import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_editing_controller.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/country_select_form/country_select_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CountrySelectFormPage extends StatefulWidget with HasPresenter<CountrySelectFormPresenter> {
  const CountrySelectFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final CountrySelectFormPresenter presenter;

  @override
  State<CountrySelectFormPage> createState() => _CountrySelectFormPageState();
}

class _CountrySelectFormPageState extends State<CountrySelectFormPage>
    with PresenterStateMixin<CountrySelectFormViewModel, CountrySelectFormPresenter, CountrySelectFormPage> {
  late TextEditingController countryCodeController;

  static const _contentPadding = 36.0;
  static const _titleSpacing = 4.0;

  @override
  void initState() {
    super.initState();
    countryCodeController = CountryEditingController<CountrySelectFormViewModel>(
      cubit: presenter,
      countryCodeExtractor: (state) => state.countryCode,
    );
  }

  @override
  void dispose() {
    countryCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return OnboardingPageContainer(
      dialog: PicnicDialog(
        image: PicnicAvatar(
          backgroundColor: theme.colors.blackAndWhite.shade900.withOpacity(Constants.onboardingImageBgOpacity),
          imageSource: PicnicImageSource.emoji(
            '📍',
            style: const TextStyle(
              fontSize: Constants.onboardingEmojiLargeSize,
            ),
            padding: const EdgeInsets.only(top: 10.0),
          ),
        ),
        title: appLocalizations.countrySelectFormTitle,
        titleSpacing: _titleSpacing,
        description: appLocalizations.countrySelectFormDescription,
        contentPadding: _contentPadding,
        content: stateObserver(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OnBoardingTextInput(
                    initialCountry: state.countryCode,
                    hintText: appLocalizations.countrySelectFormInputHint,
                    textController: countryCodeController,
                    inputTextStyle: theme.styles.body20,
                    inputType: PicnicOnBoardingTextInputType.countryPickerTextInput,
                    onChangedCountryCode: (CountryCode value) => presenter.onChangedCountryCode(value.code!),
                  ),
                  const Gap(20),
                  PicnicButton(
                    color: theme.colors.pink,
                    onTap: presenter.onTapContinue,
                    title: appLocalizations.continueAction,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
