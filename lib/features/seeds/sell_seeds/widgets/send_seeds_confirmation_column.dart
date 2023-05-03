import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class SendSeedsConfirmationColumn extends StatelessWidget {
  const SendSeedsConfirmationColumn({
    Key? key,
    required this.recipient,
    required this.onTapClose,
    required this.onTapSendSeeds,
    required this.circleName,
    required this.seedAmount,
  }) : super(key: key);

  final PublicProfile recipient;
  final VoidCallback onTapClose;
  final VoidCallback onTapSendSeeds;
  final String circleName;
  final int seedAmount;

  static const _avatarSize = 40.0;
  @override
  Widget build(BuildContext context) {
    final themeData = PicnicTheme.of(context);
    final colors = themeData.colors;
    final styles = themeData.styles;
    final blackAndWithe600 = colors.blackAndWhite.shade600;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(16),
          Text(
            appLocalizations.sendSeeds,
            style: themeData.styles.title30,
            textAlign: TextAlign.left,
          ),
          const Gap(4),
          Text(
            appLocalizations.seedAmountConfirmation(seedAmount, circleName),
            style: themeData.styles.body20.copyWith(color: blackAndWithe600),
            textAlign: TextAlign.left,
          ),
          PicnicListItem(
            title: recipient.username,
            titleStyle: styles.title10,
            leading: PicnicAvatar(
              size: _avatarSize,
              boxFit: PicnicAvatarChildBoxFit.cover,
              imageSource: PicnicImageSource.url(recipient.profileImageUrl),
            ),
          ),
          PicnicButton(
            title: appLocalizations.sendSeedsConfirmation,
            onTap: onTapSendSeeds,
            color: colors.green,
          ),
          const Gap(16),
          Center(
            child: PicnicTextButton(
              label: appLocalizations.cancelAction,
              onTap: onTapClose,
              labelStyle: themeData.styles.caption20.copyWith(color: blackAndWithe600),
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
