import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class NewMessageUsersList extends StatelessWidget {
  const NewMessageUsersList({
    Key? key,
    required this.users,
    required this.loadMore,
    required this.onTapAddRecipient,
  }) : super(key: key);

  final PaginatedList<Selectable<User>> users;
  final Future<void> Function() loadMore;

  final ValueChanged<User> onTapAddRecipient;

  static const _listItemHeight = 60.0;
  static const _avatarSize = 40.0;
  static const _padding = EdgeInsets.symmetric(horizontal: 24.0);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final textStyleSubtitle20 = theme.styles.subtitle20;

    return Expanded(
      child: PicnicPagingListView<Selectable<User>>(
        paginatedList: users,
        loadMore: loadMore,
        itemBuilder: (context, item) {
          final user = item.item;

          final _avatar = PicnicAvatar(
            size: _avatarSize,
            backgroundColor: PicnicColors.primaryButtonBlue,
            boxFit: PicnicAvatarChildBoxFit.cover,
            imageSource: PicnicImageSource.url(
              user.profileImageUrl,
              fit: BoxFit.cover,
            ),
            placeholder: () => DefaultAvatar.user(hash: user.id.hashCode),
          );

          return PicnicListItem(
            height: _listItemHeight,
            onTap: () => onTapAddRecipient(user),
            title: user.username,
            titleStyle: textStyleSubtitle20,
            leading: _avatar,
            trailing: item.selected ? Image.asset(Assets.images.checkboxSquare.path) : null,
          );
        },
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        padding: _padding,
        shrinkWrap: true,
      ),
    );
  }
}
