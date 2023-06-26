import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
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
  late final TextEditingController phoneController;

  static const _contentPadding = EdgeInsets.only(
    left: 24.0,
    right: 24.0,
    top: Constants.toolbarHeight + 24.0,
    bottom: 16.0,
  );

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: state.phoneNumber);
    phoneController.addListener(() => presenter.onChangedPhone(phoneController.text));

    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    phoneController.dispose();

    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          final themeData = PicnicTheme.of(context);
          final blackAndWhite = themeData.colors.blackAndWhite;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: _contentPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    appLocalizations.yourPhoneNumber,
                                    style: themeData.styles.title60,
                                  ),
                                  const Gap(8),
                                  Text(
                                    appLocalizations.loginPhoneFormDescription,
                                    style: themeData.styles.body30.copyWith(color: blackAndWhite.shade600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            // ignore: no-magic-number
                            Assets.images.phone.image(
                              // ignore: no-magic-number
                              width: 40,
                              // ignore: no-magic-number
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        const Gap(24),
                        OnBoardingTextInput(
                          key: const Key('phoneInput'),
                          focusNode: phoneFocusNode,
                          textController: phoneController,
                          showFlag: true,
                          keyboardType: TextInputType.phone,
                          hintText: "phone number",
                          initialCountry: state.countryCode,
                          inputType: PicnicOnBoardingTextInputType.phoneInput,
                          onChanged: presenter.onChangedPhone,
                          onChangedCountryCode: (CountryCode value) => presenter.onChangedCountryCode(
                            value.code,
                            value.dialCode,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
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
            ),
          );
        },
      );
}
