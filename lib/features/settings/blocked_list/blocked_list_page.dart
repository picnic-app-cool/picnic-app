// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presentation_model.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presenter.dart';
import 'package:picnic_app/features/settings/blocked_list/widgets/block_user_button.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class BlockedListPage extends StatefulWidget with HasPresenter<BlockedListPresenter> {
  const BlockedListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final BlockedListPresenter presenter;

  @override
  State<BlockedListPage> createState() => _BlockedListPageState();
}

class _BlockedListPageState extends State<BlockedListPage>
    with PresenterStateMixin<BlockedListViewModel, BlockedListPresenter, BlockedListPage> {
  static const _avatarSize = 40.0;

  static const _padding = EdgeInsets.symmetric(horizontal: 12.0);
  static const _listItemHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return DarkStatusBar(
      child: Scaffold(
        appBar: PicnicAppBar(
          backgroundColor: theme.colors.blackAndWhite.shade100,
          titleText: appLocalizations.blockedListTitle,
        ),
        body: Padding(
          padding: _padding,
          child: stateObserver(
            buildWhen: (previous, current) => previous.users != current.users,
            builder: (context, state) => PicnicPagingListView<PublicProfile>(
              paginatedList: state.users,
              loadMore: presenter.loadBlockedList,
              loadingBuilder: (_) => const PicnicLoadingIndicator(),
              itemBuilder: (context, user) {
                return PicnicListItem(
                  onTap: () => presenter.onTapViewUserProfile(user.id),
                  height: _listItemHeight,
                  leading: PicnicAvatar(
                    size: _avatarSize,
                    boxFit: PicnicAvatarChildBoxFit.cover,
                    backgroundColor: theme.colors.lightBlue.shade100,
                    placeholder: () => DefaultAvatar.user(),
                    imageSource: PicnicImageSource.url(
                      user.profileImageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: user.username,
                  titleStyle: theme.styles.subtitle20,
                  trailing: BlockUserButton(
                    onTapToggleBlock: () => presenter.onTapToggleBlock(user),
                    isBlocked: user.isBlocked,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
