import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/chat_member.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/chat_role.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class ChatMoreMembersTab extends StatelessWidget {
  const ChatMoreMembersTab({
    Key? key,
    required this.members,
    required this.onTapRemove,
    required this.onTapUser,
    required this.onLoadMore,
    required this.isRemoveUserEnabled,
  }) : super(key: key);

  final PaginatedList<ChatMember> members;
  final ValueChanged<ChatMember> onTapRemove;
  final ValueChanged<ChatMember> onTapUser;
  final Future<void> Function() onLoadMore;
  final bool isRemoveUserEnabled;

  static const _listItemHeight = 60.0;
  static const _avatarSize = 40.0;
  static const _closeButtonSize = 20.0;
  static const _padding = EdgeInsets.symmetric(horizontal: 14.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleSubtitle20 = theme.styles.subtitle20;
    final pinkColor = theme.colors.pink.shade500;
    const blueColor = PicnicColors.bluishCyan;

    final adminLabel = Text(
      appLocalizations.adminLabel,
      style: theme.styles.subtitle30.copyWith(color: blueColor),
    );

    return PicnicPagingListView<ChatMember>(
      padding: _padding,
      paginatedList: members,
      loadMore: onLoadMore,
      loadingBuilder: (_) => const PicnicLoadingIndicator(),
      separatorBuilder: (context, index) => const Gap(16),
      itemBuilder: (context, item) {
        final user = item.user;
        final title = user.username;
        final imageUrl = user.profileImageUrl;

        final removeButton = InkWell(
          onTap: () => onTapRemove(item),
          child: Assets.images.closeSquare.image(width: _closeButtonSize, color: pinkColor),
        );

        final trailing = item.role == ChatRole.director
            ? adminLabel
            : isRemoveUserEnabled
                ? removeButton
                : const SizedBox.shrink();

        return PicnicListItem(
          height: _listItemHeight,
          onTap: () => onTapUser(item),
          title: title,
          titleStyle: textStyleSubtitle20,
          leading: PicnicAvatar(
            size: _avatarSize,
            boxFit: PicnicAvatarChildBoxFit.cover,
            backgroundColor: PicnicColors.primaryButtonBlue,
            imageSource: PicnicImageSource.url(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          trailing: trailing,
        );
      },
    );
  }
}
