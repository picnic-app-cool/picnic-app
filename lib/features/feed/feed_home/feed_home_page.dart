import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/feed/domain/model/feed.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presenter.dart';
import 'package:picnic_app/features/feed/feed_home/widgets/empty_feeds_view.dart';
import 'package:picnic_app/features/feed/feed_home/widgets/feeds_page_view.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_page.dart';
import 'package:picnic_app/features/feed/widgets/feed_top_nav_bar.dart';
import 'package:picnic_app/ui/widgets/view_in_foreground_detector.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class FeedHomePage extends StatefulWidget with HasPresenter<FeedHomePresenter> {
  const FeedHomePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final FeedHomePresenter presenter;

  @override
  State<FeedHomePage> createState() => _FeedHomePageState();
}

class _FeedHomePageState extends State<FeedHomePage>
    with PresenterStateMixin<FeedHomeViewModel, FeedHomePresenter, FeedHomePage> {
  @override
  void initState() {
    super.initState();
    presenter.init();
  }

  @override
  Widget build(BuildContext context) {
    return ViewInForegroundDetector(
      viewDidAppear: presenter.onUpdateFeedsList,
      child: stateObserver(
        builder: (ctx, state) {
          if (state.isLoading) {
            return const PicnicLoadingIndicator();
          }
          if (state.feeds.isEmpty) {
            return const EmptyFeedsView();
          }

          //TODO: https://picnic-app.atlassian.net/browse/GS-8589
          return Material(
            color: PicnicTheme.of(context).colors.blackAndWhite.shade100,
            child: SizedBox.expand(
              child: Stack(
                children: [
                  if (state.selectedFeed != const Feed.empty())
                    Positioned.fill(
                      child: FeedsPageView(
                        onFeedChangedByIndex: presenter.onFeedChangedByIndex,
                        selectedFeedIndex: state.selectedFeedIndex,
                        onPostChanged: presenter.onPostChanged,
                        feedsList: state.feeds,
                        localPost: state.forYouLocalPost,
                        localPostFeedIndex: Constants.forYouFeedIndex,
                      ),
                    ),
                  Positioned.fill(
                    child: PostUploadingProgressPage(
                      initialParams: PostUploadingProgressInitialParams(
                        onPostToBeShown: presenter.onLocalPostChanged,
                      ),
                    ),
                  ),
                  SafeArea(
                    child: stateObserver(
                      builder: (context, state) => FeedTopNavBar(
                        overlayTheme: state.overlayTheme,
                        onTapNotifications: presenter.onTapNotifications,
                        tabs: state.feeds,
                        selectedTab: state.selectedFeed,
                        onTabChanged: presenter.onFeedChanged,
                        onTapCirclesSideMenu: presenter.onTapCirclesSideMenu,
                        unreadNotificationsCount: state.unreadNotificationsCount.count,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
