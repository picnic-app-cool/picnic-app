import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class UsersPaginatedListView extends StatelessWidget {
  const UsersPaginatedListView({
    Key? key,
    required this.usersList,
    required this.loadMore,
    required this.onTapAdd,
    required this.buttonTitle,
    required this.selectedButtonTitle,
    this.buttonColor,
  }) : super(key: key);

  final PaginatedList<Selectable<PublicProfile>> usersList;
  final Future<void> Function() loadMore;
  final Function(PublicProfile) onTapAdd;
  final Color? buttonColor;
  final String buttonTitle;
  final String selectedButtonTitle;

  static const _avatarSize = 45.0;
  static const _height = 56.0;
  static const _borderButtonWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final buttonColor = this.buttonColor ?? theme.colors.green;

    return Expanded(
      child: PicnicPagingListView<Selectable<PublicProfile>>(
        paginatedList: usersList,
        loadMore: loadMore,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        itemBuilder: (context, user) => PicnicListItem(
          height: _height,
          title: user.item.username,
          titleStyle: theme.styles.title10,
          leading: PicnicAvatar(
            backgroundColor: theme.colors.lightBlue.shade100,
            isVerified: user.item.isVerified,
            size: _avatarSize,
            boxFit: PicnicAvatarChildBoxFit.cover,
            imageSource: PicnicImageSource.url(
              user.item.profileImageUrl,
              fit: BoxFit.cover,
            ),
            placeholder: () => DefaultAvatar.user(),
          ),
          trailing: user.selected
              ? PicnicButton(
                  title: selectedButtonTitle,
                  titleColor: buttonColor,
                  style: PicnicButtonStyle.outlined,
                  borderColor: buttonColor,
                  borderWidth: _borderButtonWidth,
                )
              : PicnicButton(
                  title: buttonTitle,
                  onTap: () => onTapAdd(user.item),
                  color: buttonColor,
                ),
        ),
      ),
    );
  }
}
