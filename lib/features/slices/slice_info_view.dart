import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/text/picnic_markdown_text.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SliceInfoView extends StatelessWidget {
  const SliceInfoView({
    Key? key,
    required this.onTapReport,
    required this.circleName,
    required this.circleEmoji,
    required this.circleImage,
    required this.circleRules,
  }) : super(key: key);

  final VoidCallback onTapReport;
  final String circleName;
  final String circleEmoji;
  final String circleImage;
  final String circleRules;

  static const _borderRadius = 16.0;
  static const _blurRadius = 30.0;
  static const _offset = Offset(0, 10);

  static const _boxShadowOpacity = 0.05;
  static const _buttonBorderWidth = 2.0;
  static const _avatarSize = 60.0;
  static const _emojiSize = 28.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final pink = colors.pink.shade500;
    final blackAndWhite = colors.blackAndWhite;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: _blurRadius,
                  color: blackAndWhite.shade900.withOpacity(_boxShadowOpacity),
                  offset: _offset,
                ),
              ],
              color: colors.blackAndWhite.shade100,
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PicnicCircleAvatar(
                  emoji: circleEmoji,
                  image: circleImage,
                  avatarSize: _avatarSize,
                  emojiSize: _emojiSize,
                  bgColor: theme.colors.green.shade200,
                ),
                const Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      circleName,
                      style: styles.body30,
                    ),
                    const Gap(8),
                    PicnicButton(
                      title: appLocalizations.reportToCircleOwners,
                      borderColor: pink,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      style: PicnicButtonStyle.outlined,
                      titleStyle: theme.styles.title10.copyWith(color: pink),
                      borderWidth: _buttonBorderWidth,
                      borderRadius: const PicnicButtonRadius.semiRound(),
                      onTap: onTapReport,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(16),
          Text(
            appLocalizations.circleRulesTitle,
            style: styles.title30,
          ),
          const Gap(8),
          PicnicMarkdownText(
            markdownSource: circleRules,
            textStyle: styles.body20,
          ),
        ],
      ),
    );
  }
}
