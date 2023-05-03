import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

//TODO: UI - Settings -  Community Guidelines - Refactor : Change Source of hardcoded text : https://picnic-app.atlassian.net/browse/PG-1529
//TODO: Receive text from backend: https://picnic-app.atlassian.net/browse/PG-1217
class GetVerifiedList extends StatelessWidget {
  const GetVerifiedList({
    super.key,
    required this.onTapCommunityGuidelines,
    required this.onTapApply,
    required this.applyUrl,
  });

  final VoidCallback onTapCommunityGuidelines;
  final Function(String) onTapApply;
  final String applyUrl;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeStyles = theme.styles;
    final titleStyle = themeStyles.title40;
    final subTitleStyle = themeStyles.title30;
    final contentStyle = themeStyles.body20;
    final contentStyleGreen = contentStyle.copyWith(color: theme.colors.green.shade600);

    final onTapHyperLinkTuText = TextSpan(
      text: appLocalizations.getVerifiedIntro2,
      style: contentStyleGreen,
      recognizer: TapGestureRecognizer()..onTap = () => onTapCommunityGuidelines(),
    );

    final onTapHyperLinkCgText = TextSpan(
      text: appLocalizations.getVerifiedIntro4,
      style: contentStyleGreen,
      recognizer: TapGestureRecognizer()..onTap = () => onTapCommunityGuidelines(),
    );

    final onTapHyperLinkApplyVText = TextSpan(
      text: appLocalizations.applyForVerification,
      style: contentStyleGreen,
      recognizer: TapGestureRecognizer()..onTap = () => onTapApply(applyUrl),
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(16.0),
          Text(
            appLocalizations.getVerifiedContentTitle,
            style: titleStyle,
          ),
          const Gap(24),
          Text(
            appLocalizations.getVerifiedContentSubTitle,
            style: subTitleStyle,
          ),
          const Gap(8),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: contentStyle,
                  text: appLocalizations.getVerifiedIntro1,
                ),
                onTapHyperLinkTuText,
                TextSpan(
                  style: contentStyle,
                  text: appLocalizations.getVerifiedIntro3,
                ),
                onTapHyperLinkCgText,
                TextSpan(
                  text: appLocalizations.getVerifiedIntro5,
                  style: contentStyle,
                ),
              ],
            ),
          ),
          const Gap(24),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: appLocalizations.getVerifiedContentList,
                  style: contentStyle,
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: appLocalizations.getVerifiedContentList2,
                  style: contentStyle,
                ),
                TextSpan(
                  text: appLocalizations.areVerifiedUsers,
                  style: contentStyle,
                ),
              ],
            ),
          ),
          const Gap(24),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                onTapHyperLinkApplyVText,
                TextSpan(
                  style: contentStyle,
                  text: appLocalizations.getVerifiedContentEnd,
                ),
              ],
            ),
          ),
          const Gap(22),
          PicnicButton(
            onTap: () => onTapApply(applyUrl),
            title: appLocalizations.applyForVerificationAction,
          ),
          const Gap(22),
        ],
      ),
    );
  }
}
