//ignore_for_file: prefer-single-widget-per-file
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/country_with_dial_code.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/onboarding/widgets/country_code_prefix.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
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
    this.selectedCountry = const CountryWithDialCode(
      code: '+1',
      name: 'US',
      flag: '🇺🇸',
    ),
    this.initialValue,
    this.maxLines = 1,
    this.showFlag = false,
    this.focusNode,
    this.innerLabel,
    this.suffixIconConstraints,
    this.suffix,
    this.onTapCountryCode,
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
  final ValueChanged<CountryWithDialCode>? onChangedCountryCode;
  final CurrentTimeProvider? currentTimeProvider;
  final DateTime? codeExpiryTime;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextStyle? inputTextStyle;
  final CountryWithDialCode selectedCountry;
  final String? initialValue;
  final FocusNode? focusNode;
  final int maxLines;
  final bool showFlag;
  final Text? innerLabel;
  final Widget? suffix;
  final BoxConstraints? suffixIconConstraints;
  final void Function()? onTapCountryCode;

  /// whether to show a loading indicator at the end of the input
  final bool isLoading;

  static const height = 20.0;
  static const closeIconSize = 24.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final themeStyles = theme.styles;
    final blackAndWhite = themeColors.blackAndWhite;

    var defaultInputTextStyle = inputTextStyle;
    defaultInputTextStyle ??= themeStyles.body20.copyWith(
      color: blackAndWhite.shade900,
      fontWeight: FontWeight.bold,
    );

    return PicnicTextInput(
      initialValue: initialValue,
      hintText: hintText,
      hintTextStyle: themeStyles.body20.copyWith(color: themeColors.darkBlue),
      errorText: errorText!,
      isLoading: isLoading,
      innerLabel: innerLabel,
      focusedBorderSide: BorderSide(
        color: blackAndWhite.shade900,
        // ignore: no-magic-number
        width: 2,
      ),
      readOnly: inputType == PicnicOnBoardingTextInputType.ageSelectionInput,
      inputFillColor: const Color.fromRGBO(
        247,
        247,
        252,
        1,
      ),
      onChanged: onChanged,
      textController: textController,
      focusNode: focusNode,
      suffixIconConstraints: suffixIconConstraints,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (inputType == PicnicOnBoardingTextInputType.oneTimePassInput)
            OneTimePassTimer(
              onTapResendOTP: onPressedResendCode!,
              currentTimeProvider: currentTimeProvider!,
              codeExpiryTime: codeExpiryTime!,
            ),
          if (suffix != null) suffix!,
        ],
      ),
      prefix: inputType == PicnicOnBoardingTextInputType.phoneInput
          ? CountryCodePrefix(
              flag: selectedCountry.flag,
              code: selectedCountry.code,
              onTapCountryCode: onTapCountryCode!,
            )
          : null,
      keyboardType: keyboardType ?? inputType.defaultKeyboardType,
      inputTextStyle: defaultInputTextStyle,
      padding: 0,
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

enum PicnicOnBoardingTextInputType {
  phoneInput,
  oneTimePassInput,
  ageSelectionInput,
  textInput;

  TextInputType? get defaultKeyboardType {
    switch (this) {
      case PicnicOnBoardingTextInputType.oneTimePassInput:
        return TextInputType.number;
      case PicnicOnBoardingTextInputType.textInput:
        return TextInputType.text;
      case PicnicOnBoardingTextInputType.phoneInput:
        return TextInputType.number;
      case PicnicOnBoardingTextInputType.ageSelectionInput:
        return TextInputType.number;
    }
  }
}
