import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SellSeedsSecondStepForm extends StatelessWidget {
  const SellSeedsSecondStepForm({
    Key? key,
    required this.errorMessage,
    required this.onChangedSeedAmount,
    required this.onTapShowRecipients,
    this.selectedRecipientUserName = '',
  }) : super(key: key);

  final String errorMessage;
  final ValueChanged<int> onChangedSeedAmount;
  final VoidCallback onTapShowRecipients;
  final String selectedRecipientUserName;

  static const double _contentHPadding = 24;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textTheme = theme.styles.body20.copyWith(
      color: theme.colors.blackAndWhite.shade900,
    );

    final hintText = selectedRecipientUserName.isEmpty ? appLocalizations.selectUser : selectedRecipientUserName;
    final hintTextStyle = selectedRecipientUserName.isEmpty ? null : textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _contentHPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(24),
          Text(
            appLocalizations.sendSeeds,
            style: textTheme,
          ),
          const Gap(4),
          PicnicTextInput(
            padding: 0,
            onTap: onTapShowRecipients,
            readOnly: true,
            hintText: hintText,
            hintTextStyle: hintTextStyle,
          ),
          const Gap(24),
          Text(
            appLocalizations.amount,
            style: textTheme,
          ),
          const Gap(4),
          PicnicTextInput(
            onChanged: (text) => onChangedSeedAmount(text.toIntOrZero),
            padding: 0,
            errorText: errorMessage,
            keyboardType: TextInputType.number,
            hintText: appLocalizations.howManySeeds,
          ),
        ],
      ),
    );
  }
}
