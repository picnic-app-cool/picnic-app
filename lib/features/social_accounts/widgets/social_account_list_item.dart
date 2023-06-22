import 'package:flutter/cupertino.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class SocialAccountListItem extends StatelessWidget {
  const SocialAccountListItem({
    required this.username,
    required this.linkedDate,
    required this.onTapOpenExternalUrl,
    required this.type,
    this.onTapUnlinkSocialAccount,
  });

  final String username;
  final String linkedDate;
  final SocialNetworkType type;
  final VoidCallback onTapOpenExternalUrl;
  final VoidCallback? onTapUnlinkSocialAccount;

  static const _socialNetworkImageSize = 20.0;
  static const _verifiedBadgeSize = 14.0;
  static const _navigateOutIconSize = 24.0;
  static const _listItemBorderRadius = 12.0;
  static const _listItemBorderWidth = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final darkBlue = colors.darkBlue;
    final iconPath = _getIconPath();
    final subtitle = appLocalizations.connectedAt(linkedDate);
    return PicnicListItem(
      title: username,
      titleStyle: theme.styles.link15.copyWith(color: darkBlue.shade800),
      titleBadge: Image.asset(
        Assets.images.verificationBadgeGrey.path,
        width: _verifiedBadgeSize,
        height: _verifiedBadgeSize,
      ),
      subTitle: subtitle,
      subTitleStyle: theme.styles.body10.copyWith(color: darkBlue),
      leading: Image.asset(
        iconPath,
        height: _socialNetworkImageSize,
        width: _socialNetworkImageSize,
      ),
      trailing: Row(
        children: [
          GestureDetector(
            onTap: onTapOpenExternalUrl,
            child: Image.asset(
              Assets.images.navigateOut.path,
              width: _navigateOutIconSize,
              height: _navigateOutIconSize,
              color: darkBlue,
            ),
          ),
          if (onTapUnlinkSocialAccount != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: onTapUnlinkSocialAccount,
                child: Image.asset(
                  Assets.images.close.path,
                  color: colors.pink,
                ),
              ),
            ),
        ],
      ),
      borderRadius: _listItemBorderRadius,
      borderColor: darkBlue.shade400,
      borderWidth: _listItemBorderWidth,
    );
  }

  String _getIconPath() {
    if (type == SocialNetworkType.discord) {
      return Assets.images.discordSocialNetwork.path;
    } else if (type == SocialNetworkType.roblox) {
      return Assets.images.roblox.path;
    }
    return Assets.images.roundedPlaceholderImage.path;
  }
}
