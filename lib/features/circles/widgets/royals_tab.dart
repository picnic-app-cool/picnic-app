import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/domain/model/royalty.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class RoyalsTab extends StatelessWidget {
  const RoyalsTab({
    Key? key,
    required this.royalties,
    required this.onTapView,
    required this.loadMore,
  }) : super(key: key);

  final PaginatedList<Royalty> royalties;
  final Function(Royalty) onTapView;
  final Future<void> Function() loadMore;

  static const _avatarSize = 35.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: PicnicPagingListView<Royalty>(
        paginatedList: royalties,
        loadMore: loadMore,
        loadingBuilder: (BuildContext context) => const Center(child: PicnicLoadingIndicator()),
        itemBuilder: (context, royalty) {
          return PicnicListItem(
            title: royalty.user.username,
            titleStyle: styles.body10,
            leading: PicnicAvatar(
              size: _avatarSize,
              iFollow: royalty.user.iFollow,
              isCrowned: royalty.user.isVerified,
              backgroundColor: colors.lightBlue.shade200,
              imageSource: PicnicImageSource.asset(
                ImageUrl(royalty.user.profileImageUrl.url),
              ),
            ),
            trailing: Row(
              children: [
                Text(
                  "${Constants.heartEmoji} ${royalty.points}",
                  style: styles.body20.copyWith(color: colors.blackAndWhite.shade700),
                ),
              ],
            ),
            onTap: () => onTapView(royalty),
          );
        },
      ),
    );
  }
}
