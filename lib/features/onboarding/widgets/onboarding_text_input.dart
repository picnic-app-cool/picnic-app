//ignore_for_file: prefer-single-widget-per-file
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/onboarding/widgets/picnic_countries_filter.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/countdown_timer_builder.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class OnBoardingTextInput extends StatelessWidget {
  const OnBoardingTextInput({
    Key? key,
    this.hintText = "",
    this.inputType = PicnicOnBoardingTextInputType.textInput,
    this.onPressedResendCode,
    this.errorText = "",
    this.textController,
    this.onChanged,
    this.onChangedCountryCode,
    this.isLoading = false,
    this.currentTimeProvider,
    this.codeExpiryTime,
    this.keyboardType,
    this.inputTextStyle,
    this.initialCountry = "US",
    this.initialValue,
    this.maxLines = 1,
    this.showFlag = false,
    this.focusNode,
  })  : assert(
          !(codeExpiryTime == null && inputType == PicnicOnBoardingTextInputType.oneTimePassInput),
          "you have to provide codeExpiryTime only if inputType is oneTimePassInput",
        ),
        assert(
          !(currentTimeProvider == null && inputType == PicnicOnBoardingTextInputType.oneTimePassInput),
          "you have to provide currentTimeProvider only if inputType is oneTimePassInput",
        ),
        assert(
          initialValue == null || textController == null,
          "you can provide either textController or initialValue, not both",
        ),
        super(key: key);

  final String hintText;
  final VoidCallback? onPressedResendCode;
  final PicnicOnBoardingTextInputType inputType;
  final TextEditingController? textController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<CountryCode>? onChangedCountryCode;
  final CurrentTimeProvider? currentTimeProvider;
  final DateTime? codeExpiryTime;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextStyle? inputTextStyle;
  final String initialCountry;
  final String? initialValue;
  final FocusNode? focusNode;
  final int maxLines;
  final bool showFlag;

  /// whether to show a loading indicator at the end of the input
  final bool isLoading;

  static const height = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final themeStyles = theme.styles;
    final blackAndWhite = themeColors.blackAndWhite;
    final hintTextStyle = themeStyles.subtitle15.copyWith(
      color: blackAndWhite.shade600,
    );

    var defaultInputTextStyle = inputTextStyle;
    defaultInputTextStyle ??= themeStyles.body20.copyWith(
      color: blackAndWhite.shade900,
      fontWeight: FontWeight.bold,
    );

    return PicnicTextInput(
      initialValue: initialValue,
      hintText: hintText,
      errorText: errorText!,
      isLoading: isLoading,
      focusedBorderSide: BorderSide(
        color: blackAndWhite.shade900,
        // ignore: no-magic-number
        width: 2,
      ),
      readOnly: inputType == PicnicOnBoardingTextInputType.countryPickerTextInput,
      inputFillColor: const Color.fromRGBO(
        247,
        247,
        252,
        1,
      ),
      onChanged: onChanged,
      textController: textController,
      focusNode: focusNode,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (inputType == PicnicOnBoardingTextInputType.oneTimePassInput)
            OneTimePassTimer(
              onTapResendOTP: onPressedResendCode!,
              currentTimeProvider: currentTimeProvider!,
              codeExpiryTime: codeExpiryTime!,
            ),
          if (inputType == PicnicOnBoardingTextInputType.countryPickerTextInput)
            _CountrySelectPopup(
              initialCountry: initialCountry,
              hintTextStyle: hintTextStyle,
              onChangedCountryCode: onChangedCountryCode,
            ),
          if (inputType == PicnicOnBoardingTextInputType.phoneInput)
            InkWell(
              onTap: textController!.clear,
              child: SizedBox(
                height: height,
                width: height,
                child: Image.asset(
                  Assets.images.close.path,
                  color: blackAndWhite.shade600,
                ),
              ),
            ),
        ],
      ),
      prefix: inputType == PicnicOnBoardingTextInputType.countryCodePickerTextInput ||
              inputType == PicnicOnBoardingTextInputType.phoneInput
          ? _InternationalMobileCodePicker(
              textStyle: hintTextStyle,
              showFlagDialog: showFlag,
              onChanged: onChangedCountryCode,
              initialCountry: initialCountry,
            )
          : null,
      keyboardType: keyboardType ?? inputType.defaultKeyboardType,
      inputTextStyle: defaultInputTextStyle,
      padding: 0,
    );
  }
}

class _CountrySelectPopup extends StatelessWidget {
  const _CountrySelectPopup({
    Key? key,
    required this.hintTextStyle,
    required this.onChangedCountryCode,
    required this.initialCountry,
  }) : super(key: key);

  final TextStyle hintTextStyle;
  final ValueChanged<CountryCode>? onChangedCountryCode;
  final String initialCountry;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(Assets.images.arrowDown.path),
        _InternationalMobileCodePicker(
          initialCountry: initialCountry,
          textStyle: hintTextStyle.copyWith(color: Colors.transparent),
          onChanged: onChangedCountryCode,
          showCountryOnly: true,
        ),
      ],
    );
  }
}

class OneTimePassTimer extends StatelessWidget {
  const OneTimePassTimer({
    required this.onTapResendOTP,
    required this.currentTimeProvider,
    required this.codeExpiryTime,
    this.padding,
  });

  final VoidCallback onTapResendOTP;
  final CurrentTimeProvider currentTimeProvider;
  final DateTime codeExpiryTime;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return CountdownTimerBuilder(
      key: Key(codeExpiryTime.millisecond.toString()),
      deadline: codeExpiryTime,
      builder: (context, timeRemaining) => Padding(
        padding: padding ??
            const EdgeInsets.only(
              top: 12.0,
              right: 12.0,
              bottom: 12.0,
            ),
        child: Text(
          "${appLocalizations.resendOTPButton} ${(timeRemaining.isNegative ? Duration.zero : timeRemaining).formatteds}s",
          style: theme.styles.link20.copyWith(
            color: theme.colors.blackAndWhite.shade500,
          ),
        ),
      ),
      timerCompleteBuilder: (context) => InkWell(
        onTap: onTapResendOTP,
        child: Text(
          appLocalizations.resendOTPButton,
          style: styles.caption20.copyWith(
            color: colors.blue.shade500,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      currentTimeProvider: currentTimeProvider,
    );
  }
}

class _InternationalMobileCodePicker extends StatelessWidget {
  const _InternationalMobileCodePicker({
    Key? key,
    required this.textStyle,
    required this.onChanged,
    required this.initialCountry,
    this.showCountryOnly = false,
    this.showFlagDialog = false,
  }) : super(key: key);

  final TextStyle textStyle;
  final ValueChanged<CountryCode>? onChanged;
  final bool showCountryOnly;
  final bool showFlagDialog;

  final String initialCountry;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: onChanged,
      initialSelection: initialCountry,
      favorite: [initialCountry],
      showFlag: showFlagDialog,
      showDropDownButton: true,
      showCountryOnly: showCountryOnly,
      dialogSize: const Size(360, 550),
      // ignore: no-magic-number
      flagWidth: 16.0,
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      textStyle: textStyle,
      showFlagDialog: true,
      countriesFilter: const PicnicCountriesFilter(),
    );
  }
}

enum PicnicOnBoardingTextInputType {
  countryCodePickerTextInput,
  countryPickerTextInput,
  phoneInput,
  oneTimePassInput,
  textInput;

  TextInputType? get defaultKeyboardType {
    switch (this) {
      case PicnicOnBoardingTextInputType.countryCodePickerTextInput:
        return TextInputType.phone;
      case PicnicOnBoardingTextInputType.countryPickerTextInput:
        return TextInputType.text;
      case PicnicOnBoardingTextInputType.oneTimePassInput:
        return TextInputType.number;
      case PicnicOnBoardingTextInputType.textInput:
        return TextInputType.text;
      case PicnicOnBoardingTextInputType.phoneInput:
        return TextInputType.number;
    }
  }
}
