import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_page.dart';
import 'package:picnic_app/features/in_app_events/in_app_event_presentable.dart';
import 'package:picnic_app/features/in_app_events/in_app_events_handler_widget.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_presenter.dart';
import 'package:picnic_app/features/in_app_events/unread_chats/unread_chats_presenter.dart';
import 'package:picnic_app/features/main/main_navigator.dart';
import 'package:picnic_app/features/main/main_presentation_model.dart';
import 'package:picnic_app/features/main/main_presenter.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/features/main/widgets/main_pages_query.dart';
import 'package:picnic_app/features/main/widgets/main_pages_view.dart';
import 'package:picnic_app/features/main/widgets/size_reporting_widget.dart';
import 'package:picnic_app/navigation/utils/root_navigator_observer.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_bottom_navigation.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';

//ignore: max
class MainPage extends StatefulWidget with HasPresenter<MainPresenter> {
  const MainPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final MainPresenter presenter;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with PresenterStateMixin<MainViewModel, MainPresenter, MainPage> {
  late RootNavigatorObserver rootNavigatorObserver;
  late List<InAppEventPresentable> inAppEventPresenters;

  static const double _circlesSideMenuWidthPercentage = 0.8;

  @override
  void initState() {
    super.initState();
    rootNavigatorObserver = getIt();
    inAppEventPresenters = [getIt<UnreadChatsPresenter>(), getIt<NotificationsPresenter>()];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InAppEventsHandlerWidget(
      inAppEventsPresenters: inAppEventPresenters,
      child: stateObserver(
        builder: (context, state) {
          final selectedItem = state.selectedTab.item;
          return BottomNavigationSizeQuery(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: state.isCirclesSideMenuOpen ? screenWidth * _circlesSideMenuWidthPercentage : 0,
                  top: 0,
                  right: state.isCirclesSideMenuOpen ? -screenWidth * _circlesSideMenuWidthPercentage : 0,
                  bottom: 0,
                  child: Stack(
                    children: [
                      stateObserver(
                        buildWhen: (prev, next) =>
                            prev.selectedTab != next.selectedTab ||
                            prev.tabs != next.tabs ||
                            prev.overlayTheme != next.overlayTheme ||
                            prev.postToShow != next.postToShow,
                        builder: (context, state) => MainPagesQuery(
                          selectedTab: state.selectedTab,
                          child: MainPagesView(
                            selectedItem: selectedItem,
                            items: state.tabs,
                            onChangedPage: presenter.onSelectedTab,
                            routeName: MainNavigator.routeName,
                            rootNavigatorObserver: rootNavigatorObserver,
                            onPostChanged: presenter.onPostChanged,
                            postToShow: state.postToShow,
                            onCirclesSideMenuToggled: presenter.onCirclesSideMenuToggled,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: stateObserver(
                          builder: (context, state) => SizeReportingWidget(
                            onSizeChange: (value) => BottomNavigationSizeQuery.updateSize(context, value),
                            child: PicnicBottomNavigation(
                              activeItem: selectedItem,
                              items: state.tabButtons,
                              overlayTheme: state.overlayTheme,
                              onTap: presenter.onSelectedTab,
                              showDecoration: selectedItem != PicnicNavItem.feed,
                              onTabSwiped: presenter.onSelectedTab,
                              unreadChatsCount: state.unreadChatsCount,
                              userImageUrl: state.user.profileImageUrl.url,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isCirclesSideMenuOpen)
                  GestureDetector(
                    onTap: () => presenter.onCirclesSideMenuToggled(),
                  ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: state.isCirclesSideMenuOpen ? 0 : -screenWidth * _circlesSideMenuWidthPercentage,
                  top: 0,
                  bottom: 0,
                  child: SizedBox(
                    width: screenWidth * _circlesSideMenuWidthPercentage,
                    child: GestureDetector(
                      onHorizontalDragEnd: handleHorizontalDragEnd,
                      child: CirclesSideMenuPage(
                        initialParams: CirclesSideMenuInitialParams(
                          onCircleSideMenuAction: presenter.onCircleSideMenuAction,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> handleHorizontalDragEnd(DragEndDetails dragDetails) async {
    if (dragDetails.velocity.pixelsPerSecond.dx < 1) {
      presenter.onCirclesSideMenuToggled();
    }
  }
}
