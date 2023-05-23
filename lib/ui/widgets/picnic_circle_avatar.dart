import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicCircleAvatar extends StatelessWidget {
  const PicnicCircleAvatar({
    required this.avatarSize,
    required this.emojiSize,
    this.image = '',
    this.emoji = '😃',
    this.bgColor,
    this.isVerified = false,
    this.placeholder,
    this.borderColor,
    this.borderPercentage = PicnicAvatar.defaultBorderPercentage,
    super.key,
  });

  final String image;
  final String emoji;
  final double avatarSize;
  final double emojiSize;
  final Color? bgColor;
  final bool isVerified;
  final Widget? placeholder;
  final Color? borderColor;
  final double borderPercentage;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final avatarBgColor = bgColor ?? theme.colors.green.shade200;
    final avatarPlaceholder = placeholder ?? DefaultAvatar.circle();
    final verifiedBadge = Assets.images.verBadge.path;
    return image.isNotEmpty
        ? PicnicAvatar(
            size: avatarSize,
            imageSource: PicnicImageSource.url(
              ImageUrl(image),
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
            ),
            boxFit: PicnicAvatarChildBoxFit.cover,
            isVerified: isVerified,
            verificationBadgeImage: ImageUrl(verifiedBadge),
            placeholder: () => DefaultAvatar.circle(),
            borderColor: borderColor,
            borderPercentage: borderPercentage,
          )
        : PicnicAvatar(
            size: avatarSize,
            backgroundColor: avatarBgColor,
            imageSource: PicnicImageSource.emoji(
              emoji,
              style: theme.styles.title40.copyWith(
                fontSize: emojiSize,
              ),
            ),
            verificationBadgeImage: ImageUrl(verifiedBadge),
            isVerified: isVerified,
            placeholder: () => avatarPlaceholder,
            borderColor: borderColor,
            borderPercentage: borderPercentage,
          );
  }
}
