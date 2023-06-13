// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/phone_form/phone_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/features/user_agreement/widgets/terms_and_policies_disclaimer.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PhoneFormPage extends StatefulWidget with HasPresenter<PhoneFormPresenter> {
  const PhoneFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final PhoneFormPresenter presenter;

  @override
  State<PhoneFormPage> createState() => _PhoneFormPageState();
}

class _PhoneFormPageState extends State<PhoneFormPage>
    with PresenterStateMixin<CongratsFormViewModel, PhoneFormPresenter, PhoneFormPage> {
  late FocusNode phoneFocusNode;

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          final themeData = PicnicTheme.of(context);
          final blackAndWhite = themeData.colors.blackAndWhite;
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appLocalizations.yourPhoneNumber,
                                style: themeData.styles.title60,
                              ),
                              const Gap(8),
                              Text(
                                appLocalizations.loginPhoneFormDescription,
                                style: themeData.styles.body20.copyWith(color: blackAndWhite.shade600),
                              ),
                            ],
                          ),
                          // ignore: no-magic-number
                          Assets.images.phone.image(scale: 0.5),
                        ],
                      ),
                      const Gap(12),
                      OnBoardingTextInput(
                        key: const Key('phoneInput'),
                        focusNode: phoneFocusNode,
                        showFlag: true,
                        initialValue: state.phoneNumber,
                        initialCountry: state.dialCode,
                        inputType: PicnicOnBoardingTextInputType.phoneInput,
                        onChanged: presenter.onChangedPhone,
                        onChangedCountryCode: (CountryCode value) => presenter.onChangedDialCode(value.dialCode),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TermsAndPoliciesDisclaimer(
                        onTapTerms: presenter.onTapTerms,
                        onTapPolicies: presenter.onTapPolicies,
                        textColor: blackAndWhite.shade700,
                        userAgreementText: appLocalizations.byContinuingYouAgreeTo,
                        showWarningIcon: true,
                      ),
                      const Gap(12),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          PicnicButton(
                            onTap: state.continueEnabled ? presenter.onTapContinue : null,
                            title: appLocalizations.continueAction,
                            minWidth: double.infinity,
                          ),
                          PicnicLoadingIndicator(isLoading: state.isLoading),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
}
