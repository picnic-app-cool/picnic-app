import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class PaginatedUsersListView extends StatelessWidget {
  const PaginatedUsersListView({
    Key? key,
    required this.modsList,
    required this.onTapAdd,
    required this.buttonTitle,
    required this.loadMore,
    required this.onTapUser,
    this.buttonColor,
  }) : super(key: key);

  final PaginatedList<PublicProfile> modsList;
  final Function(PublicProfile) onTapAdd;
  final Function(PublicProfile) onTapUser;
  final Color? buttonColor;
  final String buttonTitle;
  final Future<void> Function() loadMore;

  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return Expanded(
      child: PicnicPagingListView<PublicProfile>(
        paginatedList: modsList,
        loadMore: loadMore,
        padding: const EdgeInsets.all(8.0),
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, mod) => PicnicListItem(
          height: null,
          title: mod.username,
          titleStyle: theme.styles.title10,
          leading: PicnicAvatar(
            size: _avatarSize,
            boxFit: PicnicAvatarChildBoxFit.cover,
            isVerified: mod.isVerified,
            imageSource: PicnicImageSource.imageUrl(
              mod.profileImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          trailing: PicnicButton(
            title: buttonTitle,
            onTap: () => onTapAdd(mod),
            color: buttonColor ?? theme.colors.green,
          ),
          onTap: () => onTapUser(mod),
        ),
      ),
    );
  }
}
