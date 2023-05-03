// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/notifications/notification_type.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_saved.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_post_shared.dart';
import 'package:picnic_app/features/profile/followers/widgets/follow_user_button.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presenter.dart';
import 'package:picnic_app/features/profile/notifications/widgets/join_button.dart';
import 'package:picnic_app/features/profile/notifications/widgets/notifications_list_leading_avatar.dart';
import 'package:picnic_app/features/profile/notifications/widgets/notifications_list_leading_warning.dart';
import 'package:picnic_app/features/profile/notifications/widgets/notifications_list_trailing_image.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/paging_list/picnic_paging_list_view.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class NotificationsListPage extends StatefulWidget with HasPresenter<NotificationsListPresenter> {
  const NotificationsListPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final NotificationsListPresenter presenter;

  @override
  State<NotificationsListPage> createState() => _NotificationsListPageState();
}

class _NotificationsListPageState extends State<NotificationsListPage>
    with PresenterStateMixin<NotificationsViewModel, NotificationsListPresenter, NotificationsListPage> {
  static const _padding = EdgeInsets.symmetric(horizontal: 12.0);
  static const _titleMaxLines = 2;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;

    return ViewInForegroundDetector(
      viewDidAppear: () => presenter.loadNotifications(fromScratch: true),
      child: RefreshIndicator(
        displacement: Constants.toolbarHeight,
        onRefresh: () => presenter.loadNotifications(fromScratch: true),
        child: DarkStatusBar(
          child: Scaffold(
            appBar: PicnicAppBar(
              backgroundColor: colors.blackAndWhite.shade100,
              titleText: appLocalizations.notificationAppBarTitle,
            ),
            body: Padding(
              padding: _padding,
              child: stateObserver(
                builder: (context, state) => PicnicPagingListView<ProfileNotification>(
                  paginatedList: state.notifications,
                  loadMore: presenter.loadNotifications,
                  loadingBuilder: (_) => const PicnicLoadingIndicator(),
                  itemBuilder: (context, notification) {
                    if (notification.type == NotificationType.unknown) {
                      return const SizedBox.shrink();
                    }
                    return PicnicListItem(
                      leading: notification.when(
                        onGlitterbomb: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onFollow: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onMessage: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onPostComment: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onPostReaction: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onSeedsReceived: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onUnbannedFromApp: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onBannedFromCircle: (_) => const NotificationsListLeadingWarning(),
                        onBannedFromApp: (_) => const NotificationsListLeadingWarning(),
                        onPostRemovedModerator: (_) => const NotificationsListLeadingWarning(),
                        onPostRemovedPicnic: (_) => const NotificationsListLeadingWarning(),
                        onPostReportedModerator: (_) => null,
                        onPostShared: (_) => null,
                        onPostSaved: (_) => null,
                        onUnbannedFromCircle: (_) => null,
                        onUnknown: (_) => null,
                        onElectionAboutToLoose: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onElectionSomeonePassed: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onUserJoinedCircle: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onUserInvitedToCircle: (_) => NotificationsListLeadingAvatar(notification: notification),
                        onPost: (_) => null,
                        onCircle: (_) => null,
                        onUser: (notification) => NotificationsListLeadingAvatar(notification: notification),
                      ),
                      maxLines: _titleMaxLines,
                      titleTextOverflow: TextOverflow.ellipsis,
                      title: notification.when(
                        onGlitterbomb: (_) => notification.name,
                        onFollow: (_) => notification.name,
                        onMessage: (_) => notification.name,
                        onPostComment: (_) => notification.name,
                        onPostReaction: (_) => notification.name,
                        onSeedsReceived: (notification) =>
                            appLocalizations.notificationSeedsReceivedTitle(notification.circleName),
                        onPostShared: (_) => appLocalizations.notificationSharedPost,
                        onPostSaved: (_) => appLocalizations.notificationSavedPost,
                        onPostReportedModerator: (notification) =>
                            appLocalizations.notificationPostReportedToModeratorTitle(notification.circleName),
                        onBannedFromCircle: (notification) =>
                            appLocalizations.notificationBannedFrom(notification.circleName),
                        onUnbannedFromCircle: (notification) =>
                            appLocalizations.notificationUnbannedFrom(notification.circleName),
                        onUnknown: (_) => notification.name,
                        onBannedFromApp: (_) => appLocalizations.notificationBannedFromApp,
                        onUnbannedFromApp: (_) => appLocalizations.notificationUnbannedFromApp,
                        onPostRemovedModerator: (notification) =>
                            appLocalizations.notificationPostRemovedModerator(notification.circleName),
                        onPostRemovedPicnic: (_) => appLocalizations.notificationPostRemovedPicnic,
                        onElectionAboutToLoose: (notification) =>
                            appLocalizations.notificationElectionUpdateTitleFormat(notification.circleName),
                        onElectionSomeonePassed: (notification) =>
                            appLocalizations.notificationElectionUpdateTitleFormat(notification.circleName),
                        onUserJoinedCircle: (notification) => appLocalizations.notificationUserJoinedCircleTitle,
                        onUserInvitedToCircle: (notification) => appLocalizations.notificationUserInvitedToCircleTitle,
                        onPost: (notification) => notification.name,
                        onCircle: (_) => notification.name,
                        onUser: (notification) => notification.name,
                      ),
                      subTitle: notification.when(
                        onGlitterbomb: (_) => appLocalizations.notificationGlitterbomb,
                        onFollow: (_) => appLocalizations.notificationFollowing,
                        onPostComment: (_) => appLocalizations.notificationPostComment,
                        onPostReaction: (_) => appLocalizations.notificationPostReaction,
                        onSeedsReceived: (notification) =>
                            appLocalizations.notificationSeedsReceivedSubtitle(notification.name),
                        onMessage: (_) => null,
                        onPostShared: (_) => null,
                        onPostSaved: (_) => null,
                        onPostReportedModerator: (notification) =>
                            appLocalizations.notificationPostReportedToModeratorSubtitle(notification.username),
                        onBannedFromCircle: (_) => null,
                        onUnbannedFromCircle: (_) => null,
                        onBannedFromApp: (_) => null,
                        onUnbannedFromApp: (_) => null,
                        onPostRemovedModerator: (_) => null,
                        onPostRemovedPicnic: (_) => null,
                        onUnknown: (_) => null,
                        onElectionAboutToLoose: (notification) =>
                            appLocalizations.notificationElectionAboutToLooseSubtitleFormat(
                          notification.circleName,
                          notification.username,
                        ),
                        onElectionSomeonePassed: (notification) =>
                            appLocalizations.notificationElectionAlreadyTookLeadSubtitleFormat(
                          notification.circleName,
                          notification.username,
                        ),
                        onUserJoinedCircle: (notification) => appLocalizations.notificationUserJoinedCircleSubtitle(
                          notification.circleName,
                          notification.username,
                        ),
                        onUserInvitedToCircle: (notification) =>
                            appLocalizations.notificationUserInvitedToCircleSubtitle(
                          notification.circleName,
                          notification.username,
                        ),
                        onPost: (_) => null,
                        onCircle: (_) => null,
                        onUser: (_) => null,
                      ),
                      subTitleStyle: styles.caption20.copyWith(color: colors.blackAndWhite.shade600),
                      titleStyle: styles.title10,
                      trailing: notification.when(
                        onGlitterbomb: (_) => null,
                        onUnknown: (_) => null,
                        onSeedsReceived: (_) => null,
                        onBannedFromCircle: (_) => null,
                        onUnbannedFromCircle: (_) => null,
                        onBannedFromApp: (_) => null,
                        onUnbannedFromApp: (_) => null,
                        onPostRemovedModerator: (_) => null,
                        onPostRemovedPicnic: (_) => null,
                        onPostReaction: (notification) => NotificationsListTrailingImage(notification.contentImageUrl),
                        onPostComment: (notification) => NotificationsListTrailingImage(notification.contentImageUrl),
                        onPostSaved: (ProfileNotificationPostSaved notification) =>
                            NotificationsListTrailingImage(notification.contentImageUrl),
                        onPostShared: (ProfileNotificationPostShared notification) =>
                            NotificationsListTrailingImage(notification.contentImageUrl),
                        onPostReportedModerator: (notification) =>
                            NotificationsListTrailingImage(notification.contentImageUrl),
                        onMessage: (notification) => NotificationsListTrailingImage(notification.contentImageUrl),
                        onFollow: (notification) {
                          final followButtonColor = theme.colors.green;
                          return FollowUserButton(
                            followingColor: followButtonColor,
                            notFollowingColor: followButtonColor,
                            onTapToggleFollow: state.isFollowProcessing(notification.id)
                                ? null
                                : () => presenter.onTapToggleFollow(
                                      userId: notification.userId,
                                      iFollow: notification.iFollow,
                                    ),
                            isFollowing: notification.iFollow,
                          );
                        },
                        onElectionAboutToLoose: (_) => null,
                        onElectionSomeonePassed: (_) => null,
                        onUserJoinedCircle: (_) => null,
                        onUserInvitedToCircle: (notification) => JoinButton(
                          isJoined: notification.joined,
                          onTapJoin: () => presenter.onTapJoin(notification.circleId),
                        ),
                        onPost: (_) => null,
                        onCircle: (_) => null,
                        onUser: (_) => null,
                      ),
                      onTap: () => presenter.onNotificationBodyTap(notification: notification),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
