import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presentation_model.dart';
import 'package:picnic_app/features/circles/banned_users/banned_users_presenter.dart';
import 'package:picnic_app/features/circles/banned_users/widgets/banned_user_widget.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class BannedUsersPage extends StatefulWidget with HasPresenter<BannedUsersPresenter> {
  const BannedUsersPage({
    super.key,
    required this.presenter,
  });

  @override
  final BannedUsersPresenter presenter;

  @override
  State<BannedUsersPage> createState() => _BannedUsersPageState();
}

class _BannedUsersPageState extends State<BannedUsersPage>
    with PresenterStateMixin<BannedUsersViewModel, BannedUsersPresenter, BannedUsersPage> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final pinkColor = theme.colors.pink;
    return Scaffold(
      appBar: PicnicAppBar(
        child: Text(
          appLocalizations.banAction,
          style: styles.subtitle30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.bannedUsersLabel,
                    style: styles.subtitle40,
                  ),
                  PicnicTextButton(
                    label: appLocalizations.banAction,
                    onTap: presenter.onTapBan,
                    labelStyle: styles.subtitle30.copyWith(color: pinkColor),
                    padding: EdgeInsets.zero,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: stateObserver(
                  buildWhen: (previous, current) => previous.bannedUsers != current.bannedUsers,
                  builder: (context, state) {
                    return PicnicPagingListView<BannedUser>(
                      paginatedList: state.bannedUsers,
                      loadMore: presenter.onLoadMoreBannedUsers,
                      loadingBuilder: (BuildContext context) => const Center(child: PicnicLoadingIndicator()),
                      separatorBuilder: (_, __) => const Gap(8),
                      itemBuilder: (context, user) {
                        return BannedUserWidget(
                          user: user,
                          onTapUnban: presenter.onTapUnban,
                          circle: state.circle,
                          currentTimeProvider: state.currentTimeProvider,
                          onTapBannedUser: presenter.onTapBannedUser,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
