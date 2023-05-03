import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class NotificationsListLeadingAvatar extends StatelessWidget {
  const NotificationsListLeadingAvatar({super.key, required this.notification});

  final ProfileNotification notification;

  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return notification.userAvatar.isNotEmpty
        ? PicnicAvatar(
            boxFit: PicnicAvatarChildBoxFit.cover,
            size: _avatarSize,
            backgroundColor: PicnicTheme.of(context).colors.lightBlue.shade100,
            imageSource: PicnicImageSource.url(
              ImageUrl(notification.userAvatar),
              fit: BoxFit.cover,
            ),
          )
        : const SizedBox.shrink();
  }
}
