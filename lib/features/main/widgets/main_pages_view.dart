import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/logging.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_initial_params.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_page.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_page.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_initial_params.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_page.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/utils/root_navigator_observer.dart';
import 'package:picnic_app/navigation/utils/simple_navigator_observer.dart';
import 'package:picnic_app/ui/widgets/always_keep_alive.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';
import 'package:picnic_app/ui/widgets/nested_navigator.dart';

class MainPagesView extends StatefulWidget {
  const MainPagesView({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChangedPage,
    required this.rootNavigatorObserver,
    required this.routeName,
    required this.onPostChanged,
    required this.postToShow,
    required this.onCirclesSideMenuToggled,
  });

  final PicnicNavItem selectedItem;
  final List<PicnicNavItem> items;
  final ValueChanged<PicnicNavItem> onChangedPage;
  final RootNavigatorObserver rootNavigatorObserver;
  final OnDisplayedPostChangedCallback onPostChanged;
  final Post postToShow;
  final VoidCallback onCirclesSideMenuToggled;

  /// name of the route enclosing this PagesView. used to listen for navigation
  /// changes in root navigator
  final String routeName;

  int get selectedIndex => items.indexOf(selectedItem);

  @override
  State<MainPagesView> createState() => _MainPagesViewState();
}

class _MainPagesViewState extends State<MainPagesView> {
  int _index = 0;
  late PageController _controller;

  late Map<PicnicNavItem, Widget> _pages;
  late NavigatorObserver _navigatorObserver;

  final _keys = Map.fromEntries(
    PicnicNavItem.values.map(
      (e) => MapEntry(e, GlobalKey<NavigatorState>()),
    ),
  );

  GlobalKey<NavigatorState>? get _currentNavigationKey => _keys[widget.items[_controller.currentPage]];

  @override
  void initState() {
    super.initState();
    _navigatorObserver = SimpleNavigatorObserver(
      onDidPush: onDidPush,
      onDidPop: onDidPop,
      onDidRemove: onDidRemove,
    );
    widget.rootNavigatorObserver.registerObserver(_navigatorObserver);

    _pages = {};
    _index = widget.selectedIndex;
    _controller = PageController(initialPage: _index)..addListener(_pageControllerListener);

    WidgetsBinding.instance.addPostFrameCallback((_) => _setChildNavigatorKey(true));
  }

  @override
  void dispose() {
    widget.rootNavigatorObserver.removeObserver(_navigatorObserver);
    AppNavigator.nestedNavigatorKey = null;
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant MainPagesView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem && _controller.currentPage != widget.selectedIndex) {
      _controller.animateToPage(
        widget.selectedIndex,
        duration: const ShortDuration(),
        curve: Curves.easeOutQuad,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _ensurePageWidgets(widget.items);
    return PageView(
      // we want to disable bouncing scroll in horizontal navigation
      physics: const NeverScrollableScrollPhysics(),
      controller: _controller,
      children: widget.items.map(
        (it) {
          return AlwaysKeepAlive(
            child: NestedNavigator(
              navigatorKey: _keys[it]!,
              initialRoute: _pages[it]!,
            ),
          );
        },
      ).toList(),
    );
  }

  void onDidPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setChildNavigatorKey(route.settings.name == widget.routeName);
  }

  void onDidPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setChildNavigatorKey(previousRoute?.settings.name == widget.routeName);
  }

  void onDidRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setChildNavigatorKey(previousRoute?.settings.name == widget.routeName);
  }

  void _pageControllerListener() {
    if (_index != _controller.currentPage) {
      _index = _controller.currentPage;
      // we want all subpages to open in nested navigators by default, thus
      // we replace nestedNavigatorKey with the currently displayed tab's navigator
      _setChildNavigatorKey(true);
    }
  }

  void _setChildNavigatorKey(bool set) => AppNavigator.nestedNavigatorKey = set ? _currentNavigationKey : null;

  void _ensurePageWidgets(List<PicnicNavItem> tabs) {
    final missingTabs = tabs.where((element) => !_pages.keys.contains(element));
    for (final tab in missingTabs) {
      final Widget? page;
      switch (tab) {
        case PicnicNavItem.feed:
          page = getIt<FeedHomePage>(
            param1: FeedHomeInitialParams(
              onPostChanged: widget.onPostChanged,
              postToShow: widget.postToShow,
              onCirclesSideMenuToggled: widget.onCirclesSideMenuToggled,
            ),
          );
          break;
        case PicnicNavItem.discover:
          page = getIt<DiscoverExplorePage>(param1: const DiscoverExploreInitialParams());
          break;
        case PicnicNavItem.add:
          logError("We dont support ${PicnicNavItem.add} as main tab");
          page = const SizedBox.shrink();
          break;
        case PicnicNavItem.chat:
          page = getIt<ChatTabsPage>(param1: const ChatTabsInitialParams());
          break;
        case PicnicNavItem.profile:
          page = getIt<PrivateProfilePage>(param1: const PrivateProfileInitialParams());
          break;
      }
      _pages[tab] = page;
    }
  }
}

extension PicnicNavItemPositions on PageController {
  int get currentPage => page!.round();
}
