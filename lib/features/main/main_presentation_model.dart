import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
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
    UserStore userStore,
  )   : selectedTab = SelectedTabInfo(
          initialOpenTime: currentTimeProvider.currentTime,
          item: PicnicNavItem.feed,
        ),
        postOverlayTheme = PostOverlayTheme.dark,
        postToShow = initialParams.postToShow,
        unreadChatsCount = unreadCountersStore.unreadChats.length,
        isCirclesSideMenuOpen = false,
        user = userStore.privateProfile;

  /// Used for the copyWith method
  MainPresentationModel._({
    required this.selectedTab,
    required this.postOverlayTheme,
    required this.postToShow,
    required this.unreadChatsCount,
    required this.isCirclesSideMenuOpen,
    required this.user,
  });

  @override
  final SelectedTabInfo selectedTab;

  @override
  final Post postToShow;

  @override
  final int unreadChatsCount;

  @override
  final bool isCirclesSideMenuOpen;

  @override
  final PrivateProfile user;

  final PostOverlayTheme postOverlayTheme;

  @override
  PostOverlayTheme get overlayTheme => (selectedTab.item == PicnicNavItem.chat ||
          selectedTab.item == PicnicNavItem.discover ||
          selectedTab.item == PicnicNavItem.profile)
      ? PostOverlayTheme.dark
      : postOverlayTheme;

  @override
  List<PicnicNavItem> get tabs => [
        PicnicNavItem.feed,
        PicnicNavItem.discover,
        PicnicNavItem.chat,
        PicnicNavItem.profile,
      ];

  @override
  List<PicnicNavItem> get tabButtons => [
        PicnicNavItem.feed,
        PicnicNavItem.discover,
        PicnicNavItem.add,
        PicnicNavItem.chat,
        PicnicNavItem.profile,
      ];

  MainPresentationModel copyWith({
    SelectedTabInfo? selectedTab,
    PostOverlayTheme? postOverlayTheme,
    DateTime? selectedTabAt,
    Post? postToShow,
    int? unreadChatsCount,
    bool? isCirclesSideMenuOpen,
    PrivateProfile? user,
  }) {
    return MainPresentationModel._(
      selectedTab: selectedTab ?? this.selectedTab,
      postOverlayTheme: postOverlayTheme ?? this.postOverlayTheme,
      postToShow: postToShow ?? this.postToShow,
      unreadChatsCount: unreadChatsCount ?? this.unreadChatsCount,
      isCirclesSideMenuOpen: isCirclesSideMenuOpen ?? this.isCirclesSideMenuOpen,
      user: user ?? this.user,
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

  PrivateProfile get user;
}
