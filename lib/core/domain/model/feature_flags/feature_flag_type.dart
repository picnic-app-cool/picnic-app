enum FeatureFlagType {
  collectionsEnabled,
  tempBanEnabled,
  royaltyTabEnabled,
  areSeedsEnabled,
  seedsProfileCircleEnabled,
  sendCirclePushEnabled,
  chatInputElectricEnabled,
  chatInputAttachmentEnabled,
  chatSettingOnlineUsersEnabled,
  savedPostsEnabled,
  commentAttachmentEnabled,
  commentInstantCommandsEnabled,
  attachSoundsToPostsEnabled,
  searchBlacklistWordsEnabled,
  followButtonOnDiscoverPageResultsEnabled,
  linkPostCreationEnabled,
  imagePostCreationEnabled,
  videoPostCreationEnabled,
  pollPostCreationEnabled,
  textPostCreationEnabled,
  postOverlayCommentsEnabled,
  nativeMediaPickerInPostCreationEnabled,
  slicesEnabled,
  showPostRemovedBottomSheet,
  manageRolesEnabled,
  isCirclePrivacyDiscoverableEnabled,
  isMuteCircleEnabled,
  showLanguageSearchBar,
  isFirebasePhoneAuthEnabled,
  useDesktopUiOnDesktop,
  signInWithAppleEnabled,
  circleDeleteMultipleMessagesEnabled,
  isLanguageSettingsEnabled,
  phoneContactsSharingEnable,
  mentionsPollPostCreationEnabled,
  showCirclePostSorting,
  signInWithGoogleEnabled,
  mentionUserInChatEnabled,
  areTrendingPostsEnabled,
  enableElectionCircularGraph,
  circlesSeeMoreEnabled,
  searchReportsEnabled,
  filterReportsEnabled,
  customRoles,
  circleConfig,
  attachmentNativePicker,
  enableEectionCountDownWidget,
  signInWithDiscordEnabled,
  seedsTutorialAfterCircleCreation;

  // ignore: long-method
  String get description {
    switch (this) {
      case FeatureFlagType.collectionsEnabled:
        return 'Enable collections feature';
      case FeatureFlagType.tempBanEnabled:
        return 'Enable temp ban';
      case FeatureFlagType.royaltyTabEnabled:
        return 'Enabled royalty tab';
      case FeatureFlagType.areSeedsEnabled:
        return 'Enabled seeds feature';
      case FeatureFlagType.seedsProfileCircleEnabled:
        return 'Enabled seeds counts in profile and circle feature';
      case FeatureFlagType.sendCirclePushEnabled:
        return 'Enable send push for the circle';
      case FeatureFlagType.chatInputElectricEnabled:
        return 'Enabled election feature';
      case FeatureFlagType.chatInputAttachmentEnabled:
        return 'Enabled chat attachments';
      case FeatureFlagType.chatSettingOnlineUsersEnabled:
        return 'Enable chat online';
      case FeatureFlagType.savedPostsEnabled:
        return 'Enabled saved posts';
      case FeatureFlagType.commentAttachmentEnabled:
        return 'Enabled comment attachments';
      case FeatureFlagType.commentInstantCommandsEnabled:
        return 'Enabled instant commands in the chat';
      case FeatureFlagType.attachSoundsToPostsEnabled:
        return 'Enabled attach sound feature';
      case FeatureFlagType.searchBlacklistWordsEnabled:
        return 'Enabled search words blacklist';
      case FeatureFlagType.followButtonOnDiscoverPageResultsEnabled:
        return 'Enabled follow button on discover page';
      case FeatureFlagType.linkPostCreationEnabled:
        return 'Enabled link post creation';
      case FeatureFlagType.imagePostCreationEnabled:
        return 'Enabled omage post creation';
      case FeatureFlagType.videoPostCreationEnabled:
        return 'Enabled video post creation';
      case FeatureFlagType.pollPostCreationEnabled:
        return 'Enabled poll post creation';
      case FeatureFlagType.textPostCreationEnabled:
        return 'Enabled text post creation';
      case FeatureFlagType.postOverlayCommentsEnabled:
        return 'Enable comments in PostOverlay';
      case FeatureFlagType.nativeMediaPickerInPostCreationEnabled:
        return 'Enabled native picker in camera';
      case FeatureFlagType.isMuteCircleEnabled:
        return 'Enable mute circle';
      case FeatureFlagType.slicesEnabled:
        return 'Enable slices';
      case FeatureFlagType.isCirclePrivacyDiscoverableEnabled:
        return 'Enable circle privacy';
      case FeatureFlagType.showPostRemovedBottomSheet:
        return 'Show post removed bottom sheet';
      case FeatureFlagType.manageRolesEnabled:
        return 'Show manage roles button';
      case FeatureFlagType.showLanguageSearchBar:
        return 'Show language search bar';
      case FeatureFlagType.isFirebasePhoneAuthEnabled:
        return 'Enabled firebase phone auth';
      case FeatureFlagType.useDesktopUiOnDesktop:
        return 'Enable desktop ui on desktop';
      case FeatureFlagType.signInWithAppleEnabled:
        return 'Enable "sign in with apple" button';
      case FeatureFlagType.signInWithGoogleEnabled:
        return 'Enable "sign in with google" button';
      case FeatureFlagType.circleDeleteMultipleMessagesEnabled:
        return 'Enable multiple messages deletion in circle chat';
      case FeatureFlagType.phoneContactsSharingEnable:
        return 'Enable sharing to phone contacts';
      case FeatureFlagType.mentionsPollPostCreationEnabled:
        return 'Enable mentions to poll post creation';
      case FeatureFlagType.isLanguageSettingsEnabled:
        return 'Enable language in settings';
      case FeatureFlagType.showCirclePostSorting:
        return 'Enable circle post sorting';
      case FeatureFlagType.mentionUserInChatEnabled:
        return 'Enable mention user in group chat';
      case FeatureFlagType.areTrendingPostsEnabled:
        return 'Enable Trending Posts section on Discover screen';
      case FeatureFlagType.circlesSeeMoreEnabled:
        return 'Enable see more button';
      case FeatureFlagType.enableElectionCircularGraph:
        return 'Enable circular graph for election progress';
      case FeatureFlagType.searchReportsEnabled:
        return 'Enable and see search bar in reports';
      case FeatureFlagType.filterReportsEnabled:
        return 'Enable and see filters in reports';
      case FeatureFlagType.customRoles:
        return 'Enable custom roles';
      case FeatureFlagType.circleConfig:
        return 'Enable circle configuration';
      case FeatureFlagType.attachmentNativePicker:
        return 'Enable native picker for attachment in chats, feed';
      case FeatureFlagType.enableEectionCountDownWidget:
        return 'Enable election countdown widget';
      case FeatureFlagType.signInWithDiscordEnabled:
        return 'Enable sign in with discord';
      case FeatureFlagType.seedsTutorialAfterCircleCreation:
        return 'Enable seeds tutorial after circle creation';
    }
  }

  String get title => name;
}
