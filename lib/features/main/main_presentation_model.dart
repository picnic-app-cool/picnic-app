import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/main/selected_tab_info.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/ui/widgets/bottom_navigation/picnic_nav_item.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class MainPresentationModel implements MainViewModel {
  /// Creates the initial state
  MainPresentationModel.initial(
    MainInitialParams initialParams,
    CurrentTimeProvider currentTimeProvider,
    UnreadCountersStore unreadCountersStore,
  )   : selectedTab = SelectedTabInfo(
          initialOpenTime: currentTimeProvider.currentTime,
          item: PicnicNavItem.feed,
        ),
        postOverlayTheme = PostOverlayTheme.dark,
        postToShow = initialParams.postToShow,
        unreadChatsCount = unreadCountersStore.unreadChats.length,
        isCirclesSideMenuOpen = false;

  /// Used for the copyWith method
  MainPresentationModel._({
    required this.selectedTab,
    required this.postOverlayTheme,
    required this.postToShow,
    required this.unreadChatsCount,
    required this.isCirclesSideMenuOpen,
  });

  @override
  final SelectedTabInfo selectedTab;

  @override
  final Post postToShow;

  @override
  final int unreadChatsCount;

  @override
  final bool isCirclesSideMenuOpen;

  final PostOverlayTheme postOverlayTheme;

  @override
  PostOverlayTheme get overlayTheme =>
      selectedTab.item == PicnicNavItem.chat ? PostOverlayTheme.dark : postOverlayTheme;

  @override
  List<PicnicNavItem> get tabs => [
        PicnicNavItem.feed,
        PicnicNavItem.chat,
      ];

  @override
  List<PicnicNavItem> get tabButtons => [
        PicnicNavItem.feed,
        PicnicNavItem.add,
        PicnicNavItem.chat,
      ];

  MainPresentationModel copyWith({
    SelectedTabInfo? selectedTab,
    PostOverlayTheme? postOverlayTheme,
    DateTime? selectedTabAt,
    Post? postToShow,
    int? unreadChatsCount,
    bool? isCirclesSideMenuOpen,
  }) {
    return MainPresentationModel._(
      selectedTab: selectedTab ?? this.selectedTab,
      postOverlayTheme: postOverlayTheme ?? this.postOverlayTheme,
      postToShow: postToShow ?? this.postToShow,
      unreadChatsCount: unreadChatsCount ?? this.unreadChatsCount,
      isCirclesSideMenuOpen: isCirclesSideMenuOpen ?? this.isCirclesSideMenuOpen,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class MainViewModel {
  PostOverlayTheme get overlayTheme;

  SelectedTabInfo get selectedTab;

  List<PicnicNavItem> get tabs;

  List<PicnicNavItem> get tabButtons;

  Post get postToShow;

  int get unreadChatsCount;

  bool get isCirclesSideMenuOpen;
}
