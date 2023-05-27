import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class RecipientsList extends StatelessWidget {
  const RecipientsList({
    Key? key,
    required this.onTapSelectRecipient,
    required this.loadMore,
    required this.recipients,
  }) : super(key: key);

  final Function(PublicProfile) onTapSelectRecipient;
  final Future<void> Function() loadMore;
  final PaginatedList<PublicProfile> recipients;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Expanded(
      child: PicnicPagingListView<PublicProfile>(
        paginatedList: recipients,
        loadMore: loadMore,
        loadingBuilder: (_) => const PicnicLoadingIndicator(),
        separatorBuilder: (context, index) => const Gap(2),
        itemBuilder: (context, publicProfile) {
          final trailing = PicnicButton(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
            ),
            title: appLocalizations.chooseAction,
            onTap: () => onTapSelectRecipient(publicProfile),
            titleColor: theme.colors.blackAndWhite.shade100,
            color: theme.colors.blue,
          );
          final picnicAvatar = PicnicAvatar(
            backgroundColor: theme.colors.lightBlue.shade100,
            size: 40.0,
            boxFit: PicnicAvatarChildBoxFit.cover,
            isVerified: publicProfile.isVerified,
            imageSource: PicnicImageSource.url(
              publicProfile.profileImageUrl,
              fit: BoxFit.cover,
            ),
            placeholder: () => DefaultAvatar.user(),
          );
          return PicnicListItem(
            leading: picnicAvatar,
            title: publicProfile.username,
            titleStyle: theme.styles.subtitle20,
            trailing: trailing,
          );
        },
      ),
    );
  }
}
