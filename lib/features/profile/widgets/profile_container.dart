import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/picnic_stat.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/domain/model/stat_type.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_stats.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({
    Key? key,
    required this.user,
    required this.profileStats,
    required this.onTap,
    required this.openLink,
    required this.isLoadingProfileStats,
    required this.onTapCopy,
  }) : super(key: key);

  final User user;
  final ProfileStats profileStats;
  final Function(StatType) onTap;
  final Function(String) openLink;
  final VoidCallback onTapCopy;

  final bool isLoadingProfileStats;

  static const double _avatarSize = 112;
  static const double _badgeSize = 20.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return Column(
      children: [
        PicnicAvatar(
          key: UniqueKey(),
          size: _avatarSize,
          boxFit: PicnicAvatarChildBoxFit.cover,
          imageSource: PicnicImageSource.url(
            user.profileImageUrl,
            fit: BoxFit.cover,
          ),
          placeholder: () => DefaultAvatar.user(avatarSize: _avatarSize),
        ),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                textAlign: TextAlign.center,
                user.fullName,
                style: styles.title40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => PicnicColors.rainbowGradient.createShader(
                        Rect.fromLTWH(
                          0,
                          0,
                          bounds.width,
                          bounds.height,
                        ),
                      ),
                      child: InkWell(
                        onTap: onTapCopy,
                        child: Text(
                          textAlign: TextAlign.center,
                          user.username.formattedUsername,
                          style: styles.body30,
                        ),
                      ),
                    ),
                  ),
                  if (user.isVerified) ...[
                    const Gap(2),
                    Assets.images.verificationBadgePink.image(width: _badgeSize),
                  ],
                ],
              ),
            ],
          ),
        ),
        const Gap(8),
        if (user.bio.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SelectableLinkify(
              style: styles.body30.copyWith(
                color: colors.blackAndWhite.shade600,
              ),
              textAlign: TextAlign.center,
              onOpen: (link) => openLink(link.url),
              text: user.bio,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
          ),
          const Gap(24),
        ],
        PicnicStats(
          onTap: onTap,
          stats: [
            PicnicStat(
              type: StatType.likes,
              count: profileStats.likes,
            ),
            PicnicStat(
              type: StatType.followers,
              count: profileStats.followers,
            ),
            PicnicStat(
              type: StatType.views,
              count: profileStats.views,
            ),
          ],
          isLoading: isLoadingProfileStats,
          usage: PicnicStatUsage.profile,
        ),
      ],
    );
  }
}
