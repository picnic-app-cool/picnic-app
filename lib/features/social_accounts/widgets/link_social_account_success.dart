import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';
import 'package:picnic_app/features/social_accounts/widgets/social_account_list_item.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/bottom_sheet_top_indicator.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class LinkSocialAccountSuccess extends StatelessWidget {
  const LinkSocialAccountSuccess({
    required this.socialNetworkType,
    required this.username,
    required this.linkedDate,
    required this.picnicUserImageUrl,
    required this.onTapOpenExternalUrl,
  });

  final SocialNetworkType socialNetworkType;
  final String username;
  final String linkedDate;
  final String picnicUserImageUrl;
  final VoidCallback onTapOpenExternalUrl;

  static const _picnicUserImageSize = 72.0;
  static const _greenCheckMarkSize = 39.0;
  static const _appsCircleSize = 32.0;
  static const _innerIconPadding = 6.0;
  static const _heightFactor = 0.45;
  static const _lineConnectingImagesHeight = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final socialNetworkName = _getSocialNetworkName();
    final white = colors.blackAndWhite.shade100;
    final darkBlueShade400 = colors.darkBlue.shade400;
    return FractionallySizedBox(
      heightFactor: _heightFactor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Center(
              child: BottomSheetTopIndicator(),
            ),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PicnicAvatar(
                  size: _picnicUserImageSize,
                  boxFit: PicnicAvatarChildBoxFit.cover,
                  imageSource: PicnicImageSource.url(
                    ImageUrl(picnicUserImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Divider(
                          height: _lineConnectingImagesHeight,
                          color: colors.darkBlue.shade500,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: _appsCircleSize,
                            height: _appsCircleSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: white,
                              border: Border.all(
                                color: darkBlueShade400,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(_innerIconPadding),
                              child: Image.asset(
                                _getIconPath(),
                              ),
                            ),
                          ),
                          Image.asset(
                            Assets.images.greenCheckmark.path,
                            width: _greenCheckMarkSize,
                            height: _greenCheckMarkSize,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            width: _appsCircleSize,
                            height: _appsCircleSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: white,
                              border: Border.all(
                                color: darkBlueShade400,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(_innerIconPadding),
                              child: Image.asset(
                                Assets.images.picnicLogo.path,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PicnicAvatar(
                  size: _picnicUserImageSize,
                  boxFit: PicnicAvatarChildBoxFit.cover,
                  imageSource: PicnicImageSource.url(
                    ImageUrl(picnicUserImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const Gap(16),
            Text(
              appLocalizations.congratulations,
              style: theme.styles.link30.copyWith(color: colors.darkBlue.shade800),
            ),
            const Gap(6),
            Text(
              appLocalizations.linkedAccountSuccessfully(socialNetworkName),
              style: theme.styles.body20.copyWith(color: colors.darkBlue.shade600),
            ),
            const Gap(16),
            SocialAccountListItem(
              username: username,
              linkedDate: linkedDate,
              onTapOpenExternalUrl: onTapOpenExternalUrl,
              type: socialNetworkType,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  String _getSocialNetworkName() {
    if (socialNetworkType == SocialNetworkType.discord) {
      return 'Discord';
    } else if (socialNetworkType == SocialNetworkType.roblox) {
      return 'Roblox';
    }
    return '';
  }

  String _getIconPath() {
    if (socialNetworkType == SocialNetworkType.discord) {
      return Assets.images.discordSocialNetwork.path;
    } else if (socialNetworkType == SocialNetworkType.roblox) {
      return Assets.images.roblox.path;
    }
    return Assets.images.roundedPlaceholderImage.path;
  }
}
