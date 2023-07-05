import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/age_form/age_form_presenter.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_text_input.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class AgeFormPage extends StatefulWidget with HasPresenter<AgeFormPresenter> {
  const AgeFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AgeFormPresenter presenter;

  @override
  State<AgeFormPage> createState() => _AgeFormPageState();
}

class _AgeFormPageState extends State<AgeFormPage>
    with PresenterStateMixin<AgeFormViewModel, AgeFormPresenter, AgeFormPage> {
  final node = FocusNode();

  static const _contentPadding = EdgeInsets.symmetric(horizontal: 24.0);
  static const _cakeIconSize = 40.0;
  static const _minimumAge = 0;
  static const _maximumAge = 101;
  static const _closeIconHeight = 24.0;
  static const _suffixMinWidthConstraint = 36.0;
  static const _agePickerHeight = 250.0;
  static const _agePickerItemHeight = 56.0;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    node.addListener(() {
      if (node.hasFocus) {
        presenter.onTapAgeInputField();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => stateObserver(
        builder: (context, state) {
          final theme = PicnicTheme.of(context);
          final colors = theme.colors;
          final darkBlue = colors.darkBlue;
          final blackAndWhite600 = colors.blackAndWhite.shade600;
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Constants.toolbarHeight + 24.0,
                  bottom: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: _contentPadding,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Assets.images.cake.image(
                                width: _cakeIconSize,
                                height: _cakeIconSize,
                                fit: BoxFit.contain,
                                color: darkBlue,
                              ),
                              const Gap(8),
                              Text(
                                textAlign: TextAlign.center,
                                appLocalizations.yourAgeTitle,
                                style: theme.styles.title60,
                              ),
                              const Gap(8),
                              Text(
                                appLocalizations.yourAgeDescription,
                                style: theme.styles.body30.copyWith(color: blackAndWhite600),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          // ignore: no-magic-number
                          const Gap(24),
                          GestureDetector(
                            onTap: presenter.onTapAgeInputField,
                            child: OnBoardingTextInput(
                              hintText: appLocalizations.ageHint,
                              textController: _textController,
                              errorText: state.ageErrorText,
                              focusNode: node,
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: _suffixMinWidthConstraint,
                              ),
                              suffix: node.hasFocus
                                  ? InkWell(
                                      onTap: _onTapClose,
                                      child: SizedBox(
                                        height: _closeIconHeight,
                                        width: _closeIconHeight,
                                        child: Image.asset(
                                          Assets.images.close.path,
                                          color: darkBlue,
                                        ),
                                      ),
                                    )
                                  : null,
                              innerLabel: _textController.text.isNotEmpty
                                  ? Text('years old', style: theme.styles.link15.copyWith(color: darkBlue.shade600))
                                  : null,
                              inputType: PicnicOnBoardingTextInputType.ageSelectionInput,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    const Spacer(),
                    Padding(
                      padding: _contentPadding,
                      child: PicnicButton(
                        onTap: state.continueEnabled ? () => presenter.onTapContinue(_textController.text) : null,
                        title: appLocalizations.continueAction,
                      ),
                    ),
                    if (state.isAgeFieldFocused)
                      Column(
                        children: [
                          const Gap(16),
                          Container(
                            width: double.infinity,
                            height: 1,
                            color: darkBlue.shade400,
                          ),
                          Padding(
                            padding: _contentPadding,
                            child: SizedBox(
                              height: _agePickerHeight,
                              child: CupertinoPicker(
                                itemExtent: _agePickerItemHeight,
                                onSelectedItemChanged: _onAgeChangedInPicker,
                                children: List<Widget>.generate(
                                  _maximumAge - _minimumAge,
                                  (index) => Center(
                                    child: Text(
                                      (index + _minimumAge).toString(),
                                      style: theme.styles.subtitle30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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

  @override
  void dispose() {
    _textController.dispose();
    node.dispose();
    super.dispose();
  }

  void _onTapClose() {
    _textController.clear();
    node.unfocus();
    presenter.onTapClear();
  }

  void _onAgeChangedInPicker(int index) {
    setState(() {
      final ageToDisplay = (index + _minimumAge).toString();
      _textController.text = ageToDisplay;
      presenter.onChangedAge(ageToDisplay);
    });
  }
}
