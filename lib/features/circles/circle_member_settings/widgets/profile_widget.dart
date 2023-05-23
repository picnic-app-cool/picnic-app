import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
    required this.publicProfile,
    required this.onTapProfile,
  }) : super(key: key);

  final PublicProfile publicProfile;
  final VoidCallback onTapProfile;

  static const double _badgeSize = 20.0;
  static const double _avatarSize = 72;

  @override
  Widget build(BuildContext context) {
    final styles = PicnicTheme.of(context).styles;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 16.0),
      child: Row(
        children: [
          PicnicAvatar(
            onTap: onTapProfile,
            size: _avatarSize,
            boxFit: PicnicAvatarChildBoxFit.cover,
            imageSource: PicnicImageSource.url(
              publicProfile.profileImageUrl,
              fit: BoxFit.cover,
            ),
            placeholder: () => DefaultAvatar.user(avatarSize: _avatarSize),
          ),
          const Gap(8),
          InkWell(
            onTap: onTapProfile,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  publicProfile.user.fullName,
                  style: styles.title40,
                ),
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => PicnicColors.rainbowGradient.createShader(
                        Rect.fromLTWH(
                          0,
                          0,
                          bounds.width,
                          bounds.height,
                        ),
                      ),
                      child: Text(
                        publicProfile.user.username.formattedUsername,
                        style: styles.body30,
                      ),
                    ),
                    if (publicProfile.isVerified) ...[
                      const Gap(2),
                      Assets.images.verificationBadgePink.image(width: _badgeSize),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
