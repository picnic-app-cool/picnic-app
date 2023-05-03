import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/domain/model/user_type.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatSuggestedUsersListItem extends StatelessWidget {
  const ChatSuggestedUsersListItem({
    required this.user,
    required this.onTapSuggestedMention,
    super.key,
  });

  final UserMention user;
  final ValueChanged<UserMention> onTapSuggestedMention;

  static const _avatarSize = 36.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTapSuggestedMention(user),
      child: Row(
        children: [
          PicnicAvatar(
            boxFit: PicnicAvatarChildBoxFit.cover,
            size: _avatarSize,
            backgroundColor: colors.lightBlue.shade200,
            imageSource: PicnicImageSource.url(
              ImageUrl(user.avatar),
              fit: BoxFit.cover,
              width: _avatarSize,
              height: _avatarSize,
            ),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.userType == UserType.contact)
                  Text(
                    user.contactPhoneNumber.label,
                    style: theme.styles.body20,
                    overflow: TextOverflow.ellipsis,
                  ),
                Text(
                  user.name,
                  style: styles.caption10,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(4),
          Text(
            // TODO: Hardcoded due to BE implementation
            // https://picnic-app.atlassian.net/browse/GS-4599
            // Should be placed here because it will be part of the model in the future
            user.userType == UserType.picnic ? '1k ${appLocalizations.followers}' : user.contactPhoneNumber.number,
            style: styles.caption10.copyWith(color: colors.blackAndWhite.shade600),
          ),
        ],
      ),
    );
  }
}
