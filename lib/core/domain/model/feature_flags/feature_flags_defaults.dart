import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';

class FeatureFlagsDefaults extends Equatable {
  const FeatureFlagsDefaults({Map<FeatureFlagType, bool>? overridenFlags})
      : _overridenFlags = overridenFlags ?? const {};

  const FeatureFlagsDefaults.empty() : _overridenFlags = const {};

  final Map<FeatureFlagType, bool> _overridenFlags;

  @override
  List<Object?> get props => [_overridenFlags];

  // ignore: long-method
  bool defaultState(FeatureFlagType key) {
    final overridenFlag = _overridenFlags[key];
    if (overridenFlag != null) {
      return overridenFlag;
    }

    switch (key) {
      case FeatureFlagType.collectionsEnabled:
        return true;
      case FeatureFlagType.tempBanEnabled:
        return false;
      case FeatureFlagType.royaltyTabEnabled:
        return false;
      case FeatureFlagType.areSeedsEnabled:
        return false;
      case FeatureFlagType.sendCirclePushEnabled:
        return false;
      case FeatureFlagType.chatInputElectricEnabled:
        return false;
      case FeatureFlagType.chatInputAttachmentEnabled:
        return true;
      case FeatureFlagType.chatSettingOnlineUsersEnabled:
        return false;
      case FeatureFlagType.savedPostsEnabled:
        return true;
      case FeatureFlagType.commentAttachmentEnabled:
        return false;
      case FeatureFlagType.commentInstantCommandsEnabled:
        return false;
      case FeatureFlagType.attachSoundsToPostsEnabled:
        return false;
      case FeatureFlagType.searchBlacklistWordsEnabled:
        return true;
      case FeatureFlagType.followButtonOnDiscoverPageResultsEnabled:
        return true;
      case FeatureFlagType.linkPostCreationEnabled:
        return true;
      case FeatureFlagType.imagePostCreationEnabled:
        return true;
      case FeatureFlagType.videoPostCreationEnabled:
        return true;
      case FeatureFlagType.pollPostCreationEnabled:
        return true;
      case FeatureFlagType.textPostCreationEnabled:
        return true;
      case FeatureFlagType.postOverlayCommentsEnabled:
        return false;
      case FeatureFlagType.nativeMediaPickerInPostCreationEnabled:
        return true;
      case FeatureFlagType.isMuteCircleEnabled:
        return false;
      case FeatureFlagType.isCirclePrivacyDiscoverableEnabled:
        return false;
      case FeatureFlagType.slicesEnabled:
        return false;
      case FeatureFlagType.showPostRemovedBottomSheet:
        return false;
      case FeatureFlagType.showLanguageSearchBar:
        return false;
      case FeatureFlagType.isFirebasePhoneAuthEnabled:
        return true;
      case FeatureFlagType.useDesktopUiOnDesktop:
        return false;
      case FeatureFlagType.signInWithAppleEnabled:
        return true;
      case FeatureFlagType.signInWithGoogleEnabled:
        return true;
      case FeatureFlagType.circleDeleteMultipleMessagesEnabled:
        return false;
      case FeatureFlagType.manageRolesEnabled:
        return true;
      case FeatureFlagType.showCirclePostSorting:
        return true;
      case FeatureFlagType.isLanguageSettingsEnabled:
        return true;
      case FeatureFlagType.mentionUserInChatEnabled:
        return false;
      case FeatureFlagType.phoneContactsSharingEnable:
        return true;
      case FeatureFlagType.mentionsPollPostCreationEnabled:
        return false;
      case FeatureFlagType.seedsProfileCircleEnabled:
        return true;
      case FeatureFlagType.areTrendingPostsEnabled:
        return false;
      case FeatureFlagType.circlesSeeMoreEnabled:
        return false;
      case FeatureFlagType.enableElectionCircularGraph:
        return false;
      case FeatureFlagType.searchReportsEnabled:
        return false;
      case FeatureFlagType.filterReportsEnabled:
        return true;
      case FeatureFlagType.customRoles:
        return true;
      case FeatureFlagType.circleConfig:
        return true;
      case FeatureFlagType.attachmentNativePicker:
        return false;
      case FeatureFlagType.enableEectionCountDownWidget:
        return false;
      case FeatureFlagType.signInWithDiscordEnabled:
        return true;
    }
  }

  FeatureFlagsDefaults copyWith({Map<FeatureFlagType, bool>? overridenFlags}) => FeatureFlagsDefaults(
        overridenFlags: overridenFlags ?? _overridenFlags,
      );
}
