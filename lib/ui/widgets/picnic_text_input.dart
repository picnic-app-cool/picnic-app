import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

/// [PicnicTextInput]
/// Custom validation implemented as to align left the [errorText] in a custom way
/// Error border is also set manually as we are not using the inbuilt validator of TextFormField to show a validation message due to the above

class PicnicTextInput extends StatelessWidget {
  const PicnicTextInput({
    Key? key,
    this.hintText = "",
    this.errorText = "",
    this.textController,
    this.scrollPhysics,
    this.onChanged,
    this.isLoading = false,
    this.keyboardType = TextInputType.text,
    this.inputTextStyle,
    this.initialValue,
    this.focusedBorderSide = BorderSide.none,
    this.inputFillColor,
    this.readOnly = false,
    this.focusNode,
    this.prefix,
    this.suffix,
    this.onTap,
    this.maxLines = 1,
    this.maxLength,
    this.showMaxLengthCounter = true,
    this.counterTextStyle,
    this.outerLabel,
    this.innerLabel,
    this.autocorrect = true,
    this.padding = _defaultPadding,
    this.contentPadding,
    this.hintTextStyle,
    this.innerLabelStyle,
    this.suffixIconConstraints,
  })  : assert(
          initialValue == null || textController == null,
          "you can provide either textController or initialValue, not both",
        ),
        super(key: key);

  final String hintText;
  final TextEditingController? textController;
  final ScrollPhysics? scrollPhysics;
  final ValueChanged<String>? onChanged;
  final String errorText;
  final TextInputType? keyboardType;
  final TextStyle? inputTextStyle;
  final TextStyle? hintTextStyle;
  final TextStyle? innerLabelStyle;
  final String? initialValue;
  final FocusNode? focusNode;
  final bool isLoading;
  final bool readOnly;
  final Widget? suffix;
  final Widget? prefix;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final bool showMaxLengthCounter;
  final TextStyle? counterTextStyle;
  final Text? outerLabel;
  final Text? innerLabel;
  final bool autocorrect;
  final BoxConstraints? suffixIconConstraints;

  final Color? inputFillColor;
  final BorderSide focusedBorderSide;
  final double padding;
  final EdgeInsets? contentPadding;

  static const _defaultContentPadding = EdgeInsets.only(
    top: 16.0,
    right: 12.0,
    bottom: 16.0,
    left: 16.0,
  );

  static const _defaultPadding = 8.0;

  static const _defaultRadius = 8.0;
  static const _errorTextLineHeight = 2.0;
  static const _borderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;
    final themeStyles = theme.styles;
    final darkBlue = themeColors.darkBlue;
    final darkBlueShade600 = darkBlue.shade600;

    var defaultHintTextStyle = hintTextStyle;
    defaultHintTextStyle ??= themeStyles.body20.copyWith(
      color: darkBlueShade600,
    );

    var defaultInputTextStyle = inputTextStyle;
    defaultInputTextStyle ??= themeStyles.body20.copyWith(
      color: darkBlue.shade900,
    );

    var defaultInnerLabelStyle = innerLabelStyle;
    defaultInnerLabelStyle ??= themeStyles.link15.copyWith(
      color: darkBlueShade600,
    );

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (outerLabel != null) ...[
            outerLabel!,
            const Gap(3),
          ],
          TextFormField(
            focusNode: focusNode,
            initialValue: initialValue,
            controller: textController,
            scrollPhysics: scrollPhysics,
            readOnly: readOnly,
            onTap: onTap,
            maxLength: maxLength,
            maxLines: maxLines,
            onChanged: onChanged,
            autocorrect: autocorrect,
            buildCounter: maxLength != null && showMaxLengthCounter ? _buildCounter : null,
            decoration: InputDecoration(
              label: innerLabel,
              labelStyle: defaultInnerLabelStyle,
              alignLabelWithHint: true,
              isDense: true,
              hintText: hintText,
              hintStyle: defaultHintTextStyle,
              enabledBorder: _setInputBorder(BorderSide.none, themeColors),
              focusedBorder: _setInputBorder(focusedBorderSide, themeColors),
              filled: true,
              fillColor: errorText.isEmpty ? inputFillColor : themeColors.pink.shade100,
              contentPadding: contentPadding ?? _defaultContentPadding,
              prefixIcon: prefix,
              suffixIconConstraints: suffixIconConstraints,
              suffixIcon: isLoading
                  ? PicnicLoadingIndicator(
                      isLoading: isLoading,
                    )
                  : suffix,
              counter: showMaxLengthCounter ? null : const Offstage(),
            ),
            keyboardType: keyboardType,
            style: defaultInputTextStyle,
          ),
          if (errorText.isNotEmpty)
            Text(
              errorText,
              style: themeStyles.subtitle10.copyWith(
                height: _errorTextLineHeight,
                color: themeColors.pink,
              ),
            ),
        ],
      ),
    );
  }

  OutlineInputBorder _setInputBorder(
    BorderSide borderSide,
    PicnicColors colors,
  ) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_defaultRadius),
      borderSide: errorText.isEmpty
          ? borderSide
          : BorderSide(
              width: _borderWidth,
              color: colors.pink.shade400,
            ),
    );
  }

  Widget? _buildCounter(
    BuildContext context, {
    int? currentLength,
    int? maxLength,
    bool? isFocused,
  }) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: _TextInputCounter(
                currentLength: currentLength ?? 0,
                maxLength: maxLength ?? 0,
                style: counterTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInputCounter extends StatelessWidget {
  const _TextInputCounter({
    Key? key,
    required this.maxLength,
    required this.currentLength,
    this.style,
  }) : super(key: key);

  final int currentLength;
  final int maxLength;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Text(
      appLocalizations.textInputCounterLabel(
        currentLength,
        maxLength,
      ),
      style: style ??
          theme.styles.body20.copyWith(
            color: theme.colors.blackAndWhite.shade600,
          ),
    );
  }
}
