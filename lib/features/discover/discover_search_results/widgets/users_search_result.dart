import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item_with_avatar_button.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class UsersSearchResult extends StatelessWidget {
  const UsersSearchResult({
    super.key,
    required this.users,
    required this.onTapFollowButton,
    required this.onTapView,
    this.showFollowButton = true,
  });

  final void Function(PublicProfile user)? onTapFollowButton;
  final List<PublicProfile> users;
  final Function(Id) onTapView;
  final bool showFollowButton;
  static const _avatarSize = 50.0;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final currentUser = users[index];
            final theme = PicnicTheme.of(context);
            final colors = theme.colors;

            final picnicAvatar = PicnicAvatar(
              size: _avatarSize,
              backgroundColor: colors.blackAndWhite.shade200,
              imageSource: PicnicImageSource.url(currentUser.profileImageUrl, fit: BoxFit.cover),
              placeholder: () => DefaultAvatar.user(),
              isVerified: currentUser.isVerified,
              boxFit: PicnicAvatarChildBoxFit.cover,
            );

            return PicnicListItemWithAvatarButton(
              onTapButton: () => onTapFollowButton?.call(currentUser),
              activeText: appLocalizations.followingAction,
              title: currentUser.username,
              passiveText: appLocalizations.followButtonActionTitle,
              isActive: currentUser.iFollow,
              onTapView: () => onTapView(currentUser.id),
              showFollowButton: showFollowButton,
              picnicAvatar: picnicAvatar,
            );
          },
          childCount: users.length,
        ),
      );
}
