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

  /// whether to show a loading indicator at the end of the input
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final themeStyles = theme.styles;
    final hintTextStyle = themeStyles.body20.copyWith(
      color: themeColors.blackAndWhite.shade600,
    );

    var defaultInputTextStyle = inputTextStyle;
    defaultInputTextStyle ??= themeStyles.caption20.copyWith(
      color: themeColors.blackAndWhite.shade900,
      fontWeight: FontWeight.bold,
    );

    return PicnicTextInput(
      initialValue: initialValue,
      hintText: hintText,
      errorText: errorText!,
      isLoading: isLoading,
      readOnly: inputType == PicnicOnBoardingTextInputType.countryPickerTextInput,
      inputFillColor: themeColors.blackAndWhite.shade200,
      onChanged: onChanged,
      textController: textController,
      focusNode: focusNode,
      suffix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (inputType == PicnicOnBoardingTextInputType.oneTimePassInput)
            _OneTimePassTimer(
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
        ],
      ),
      prefix: inputType == PicnicOnBoardingTextInputType.countryCodePickerTextInput
          ? _InternationalMobileCodePicker(
              textStyle: hintTextStyle,
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

class _OneTimePassTimer extends StatelessWidget {
  const _OneTimePassTimer({
    required this.onTapResendOTP,
    required this.currentTimeProvider,
    required this.codeExpiryTime,
  });

  final VoidCallback onTapResendOTP;
  final CurrentTimeProvider currentTimeProvider;
  final DateTime codeExpiryTime;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return CountdownTimerBuilder(
      key: Key(codeExpiryTime.millisecond.toString()),
      deadline: codeExpiryTime,
      builder: (context, timeRemaining) => Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
          right: 12.0,
          bottom: 12.0,
        ),
        child: Text(
          (timeRemaining.isNegative ? Duration.zero : timeRemaining).formattedMMss,
          style: theme.styles.body20.copyWith(
            color: theme.colors.blackAndWhite.shade500,
          ),
        ),
      ),
      timerCompleteBuilder: (context) => TextButton(
        onPressed: onTapResendOTP,
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Text(
            appLocalizations.resendOTPButton,
            style: styles.caption20.copyWith(
              color: colors.blue.shade500,
              fontWeight: FontWeight.bold,
            ),
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
  }) : super(key: key);

  final TextStyle textStyle;
  final ValueChanged<CountryCode>? onChanged;
  final bool showCountryOnly;
  final String initialCountry;

  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: onChanged,
      initialSelection: initialCountry,
      favorite: [initialCountry],
      showFlag: false,
      showCountryOnly: showCountryOnly,
      textStyle: textStyle,
      showFlagDialog: true,
      countriesFilter: const PicnicCountriesFilter(),
    );
  }
}

enum PicnicOnBoardingTextInputType {
  countryCodePickerTextInput,
  countryPickerTextInput,
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
    }
  }
}
