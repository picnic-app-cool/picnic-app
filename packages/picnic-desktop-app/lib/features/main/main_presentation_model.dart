import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_desktop_app/features/main/main_initial_params.dart';
import 'package:picnic_desktop_app/ui/widgets/navigation_rail/picnic_nav_item.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class MainPresentationModel implements MainViewModel {
  /// Creates the initial state
  MainPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    MainInitialParams initialParams,
    UserStore userStore,
  )   : privateProfile = userStore.privateProfile,
        selectedTab = PicnicNavItemId.chats;

  /// Used for the copyWith method
  MainPresentationModel._({
    required this.selectedTab,
    required this.privateProfile,
  });

  @override
  final PrivateProfile privateProfile;

  @override
  final PicnicNavItemId selectedTab;

  @override
  List<PicnicNavItemId> get tabs => [
        PicnicNavItemId.feed,
        PicnicNavItemId.feedChat,
      ];

  @override
  List<PicnicNavItemId> get recentTabs => [
        PicnicNavItemId.chats,
      ];

  MainPresentationModel copyWith({
    PicnicNavItemId? selectedTab,
    PrivateProfile? privateProfile,
  }) {
    return MainPresentationModel._(
      selectedTab: selectedTab ?? this.selectedTab,
      privateProfile: privateProfile ?? this.privateProfile,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class MainViewModel {
  List<PicnicNavItemId> get tabs;

  List<PicnicNavItemId> get recentTabs;

  PicnicNavItemId get selectedTab;

  PrivateProfile get privateProfile;
}
