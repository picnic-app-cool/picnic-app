import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';

import 'circles_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class CirclesMocks {
  // MVP

  static late MockCircleCreationRuleSelectionPresenter circleCreationRuleSelectionPresenter;
  static late MockCircleCreationRuleSelectionPresentationModel circleCreationRuleSelectionPresentationModel;
  static late MockCircleCreationRuleSelectionInitialParams circleCreationRuleSelectionInitialParams;
  static late MockCircleCreationRuleSelectionNavigator circleCreationRuleSelectionNavigator;

  static late MockCircleSettingsPresenter circleSettingsPresenter;
  static late MockCircleSettingsPresentationModel circleSettingsPresentationModel;
  static late MockCircleSettingsInitialParams circleSettingsInitialParams;
  static late MockCircleSettingsNavigator circleSettingsNavigator;
  static late MockBanUserListPresenter banUserListPresenter;
  static late MockBanUserListPresentationModel banUserListPresentationModel;
  static late MockBanUserListInitialParams banUserListInitialParams;
  static late MockBanUserListNavigator banUserListNavigator;
  static late MockRemoveReasonPresenter removeReasonPresenter;
  static late MockRemoveReasonPresentationModel removeReasonPresentationModel;
  static late MockRemoveReasonInitialParams removeReasonInitialParams;
  static late MockRemoveReasonNavigator removeReasonNavigator;
  static late MockReportedPostPresenter reportedPostPresenter;
  static late MockReportedPostPresentationModel reportedPostPresentationModel;
  static late MockReportedPostInitialParams reportedPostInitialParams;
  static late MockReportedContentNavigator reportedPostNavigator;

  static late MockReportedMessagePresenter reportedMessagePresenter;
  static late MockReportedMessagePresentationModel reportedMessagePresentationModel;
  static late MockReportedMessageInitialParams reportedMessageInitialParams;
  static late MockReportedMessageNavigator reportedMessageNavigator;

  static late MockBanUserPresenter banUserPresenter;
  static late MockBanUserPresentationModel banUserPresentationModel;
  static late MockBanUserInitialParams banUserInitialParams;
  static late MockBanUserNavigator banUserNavigator;
  static late MockCircleMemberSettingsPresenter circleMemberSettingsPresenter;
  static late MockCircleMemberSettingsPresentationModel circleMemberSettingsPresentationModel;
  static late MockCircleMemberSettingsInitialParams circleMemberSettingsInitialParams;
  static late MockCircleMemberSettingsNavigator circleMemberSettingsNavigator;
  static late MockInviteUserListPresenter inviteUserListPresenter;
  static late MockInviteUserListPresentationModel inviteUserListPresentationModel;
  static late MockInviteUserListInitialParams inviteUserListInitialParams;
  static late MockInviteUserListNavigator inviteUserListNavigator;

  static late MockCircleGroupsSelectionPresenter circleGroupsSelectionPresenter;
  static late MockCircleGroupsSelectionPresentationModel circleGroupsSelectionPresentationModel;
  static late MockCircleGroupsSelectionInitialParams circleGroupsSelectionInitialParams;
  static late MockCircleGroupsSelectionNavigator circleGroupsSelectionNavigator;

  static late MockCircleDetailsPresenter circleDetailsPresenter;
  static late MockCircleDetailsPresentationModel circleDetailsPresentationModel;
  static late MockCircleDetailsInitialParams circleDetailsInitialParams;
  static late MockCircleDetailsNavigator circleDetailsNavigator;

  static late MockEditRulesPresenter editRulesPresenter;
  static late MockEditRulesPresentationModel editRulesPresentationModel;
  static late MockEditRulesInitialParams editRulesInitialParams;
  static late MockEditRulesNavigator editRulesNavigator;

  static late MockBlacklistedWordsPresenter blacklistedWordsPresenter;
  static late MockBlacklistedWordsPresentationModel blacklistedWordsPresentationModel;
  static late MockBlacklistedWordsInitialParams blacklistedWordsInitialParams;
  static late MockBlacklistedWordsNavigator blacklistedWordsNavigator;

  static late MockAddBlackListWordPresenter addBlackListWordPresenter;
  static late MockAddBlackListWordPresentationModel addBlackListWordPresentationModel;
  static late MockAddBlackListWordInitialParams addBlackListWordInitialParams;
  static late MockAddBlackListWordNavigator addBlackListWordNavigator;

  static late MockGetRelatedMessagesUseCase getRelatedMessagesUseCase;
  static late MockGetRelatedChatMessagesFeedUseCase getRelatedChatMessagesFeedUseCase;

  static late MockEditCirclePresenter editCirclePresenter;
  static late MockEditCirclePresentationModel editCirclePresentationModel;
  static late MockEditCircleInitialParams editCircleInitialParams;
  static late MockEditCircleNavigator editCircleNavigator;

  static late MockReportsListPresenter reportsListPresenter;
  static late MockReportsListPresentationModel reportsListPresentationModel;
  static late MockReportsListInitialParams reportsListInitialParams;
  static late MockReportsListNavigator reportsListNavigator;

  static late MockBannedUsersPresenter bannedUsersPresenter;
  static late MockBannedUsersPresentationModel bannedUsersPresentationModel;
  static late MockBannedUsersInitialParams bannedUsersInitialParams;
  static late MockBannedUsersNavigator bannedUsersNavigator;

  static late MockMembersNavigator membersNavigator;

  static late MockRolesListPresenter rolesListPresenter;
  static late MockRolesListPresentationModel rolesListPresentationModel;
  static late MockRolesListInitialParams rolesListInitialParams;
  static late MockRolesListNavigator rolesListNavigator;

  static late MockCircleRolePresenter circleRolePresenter;
  static late MockCircleRolePresentationModel circleRolePresentationModel;
  static late MockCircleRoleInitialParams circleRoleInitialParams;
  static late MockCircleRoleNavigator circleRoleNavigator;

  static late MockUserRolesPresenter userRolesPresenter;
  static late MockUserRolesPresentationModel userRolesPresentationModel;
  static late MockUserRolesInitialParams userRolesInitialParams;
  static late MockUserRolesNavigator userRolesNavigator;

  static late MockResolveReportWithNoActionPresenter resolveReportWithNoActionPresenter;
  static late MockResolveReportWithNoActionPresentationModel resolveReportWithNoActionPresentationModel;
  static late MockResolveReportWithNoActionInitialParams resolveReportWithNoActionInitialParams;
  static late MockResolveReportWithNoActionNavigator resolveReportWithNoActionNavigator;

  static late MockCircleConfigPresenter circleConfigPresenter;
  static late MockCircleConfigPresentationModel circleConfigPresentationModel;
  static late MockCircleConfigInitialParams circleConfigInitialParams;
  static late MockCircleConfigNavigator circleConfigNavigator;

  static late MockDiscoverPodsPresenter discoverPodsPresenter;
  static late MockDiscoverPodsPresentationModel discoverPodsPresentationModel;
  static late MockDiscoverPodsInitialParams discoverPodsInitialParams;
  static late MockDiscoverPodsNavigator discoverPodsNavigator;

  static late MockPodWebViewPresenter podWebViewPresenter;
  static late MockPodWebViewPresentationModel podWebViewPresentationModel;
  static late MockPodWebViewInitialParams podWebViewInitialParams;
  static late MockPodWebViewNavigator podWebViewNavigator;

  static late MockAddCirclePodPresenter addCirclePodPresenter;
  static late MockAddCirclePodPresentationModel addCirclePodPresentationModel;
  static late MockAddCirclePodInitialParams addCirclePodInitialParams;
  static late MockAddCirclePodNavigator addCirclePodNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetRoyaltyFailure getRoyaltyFailure;
  static late MockGetRoyaltyUseCase getRoyaltyUseCase;

  static late MockEditRulesFailure editRulesFailure;
  static late MockEditRulesUseCase editRulesUseCase;

  static late MockGetCircleDetailsFailure getCircleDetailsFailure;
  static late MockGetCircleDetailsUseCase getCircleDetailsUseCase;
  static late MockGetCircleMembersByRoleUseCase getCircleMembersByRoleUseCase;

  static late MockGetBannedUsersFailure getBannedUsersFailure;
  static late MockGetBannedUsersUseCase getBannedUsersUseCase;
  static late MockGetReportsFailure getReportsFailure;
  static late MockGetReportsUseCase getReportsUseCase;

  static late MockGetCircleMembersFailure getCircleMembersFailure;
  static late MockGetCircleMembersUseCase getCircleMembersUseCase;

  static late MockUnbanUserUseCase unbanUserUseCase;
  static late MockBanUserUseCase banUserUseCase;
  static late MockBanUserFailure banUserFailure;
  static late MockUnbanUserFailure unbanUserFailure;

  static late MockInviteUserToCircleFailure inviteUserToCircleFailure;
  static late MockInviteUserToCircleUseCase inviteUserToCircleUseCase;

  static late MockJoinCircleUseCase joinCircleUseCase;
  static late MockJoinCirclesUseCase joinCirclesUseCase;
  static late MockUpdateCircleMemberRoleFailure updateCircleMemberRoleFailure;

  static late MockSearchNonMemberUsersFailure searchNonMemberUsersFailure;
  static late MockSearchNonMemberUsersUseCase searchNonMemberUsersUseCase;

  static late MockGetBlacklistedWordsFailure getBlacklistedWordsFailure;
  static late MockGetBlacklistedWordsUseCase getBlacklistedWordsUseCase;

  static late MockAddBlacklistedWordsFailure addBlacklistedWordsFailure;
  static late MockAddBlacklistedWordsUseCase addBlacklistedWordsUseCase;

  static late MockRemoveBlacklistedWordsFailure removeBlacklistedWordsFailure;
  static late MockRemoveBlacklistedWordsUseCase removeBlacklistedWordsUseCase;

  static late MockGetCircleSortedPostsFailure getCircleSortedPostsFailure;
  static late MockGetCircleSortedPostsUseCase getCircleSortedPostsUseCase;

  static late MockCreateCircleRoleFailure createCircleRoleFailure;
  static late MockCreateCircleRoleUseCase createCircleRoleUseCase;

  static late MockGetCircleRoleFailure getCircleRoleFailure;
  static late MockGetCircleRolesUseCase getCircleRoleUseCase;

  static late MockUpdateCircleRoleFailure updateCircleRoleFailure;
  static late MockUpdateCircleRoleUseCase updateCircleRoleUseCase;

  static late MockDeleteRoleFailure deleteRoleFailure;
  static late MockDeleteRoleUseCase deleteRoleUseCase;

  static late MockAssignUserRoleFailure assignUserRoleFailure;
  static late MockAssignUserRoleUseCase assignUserRoleUseCase;

  static late MockUnAssignUserRoleFailure unAssignUserRoleFailure;
  static late MockUnAssignUserRoleUseCase unAssignUserRoleUseCase;

  static late MockGetRolesForUserFailure getRolesForUserFailure;
  static late MockGetUserRolesInCircleUseCase getUserRolesInCircleUseCase;

  static late MockGetLastUsedSortingOptionFailure getLastUsedSortingOptionFailure;
  static late MockGetLastUsedSortingOptionUseCase getLastUsedSortingOptionUseCase;

  static late MockGetDefaultCircleConfigFailure getDefaultCircleConfigFailure;
  static late MockGetDefaultCircleConfigUseCase getDefaultCircleConfigUseCase;

  static late MockGetPodsFailure getPodsFailure;
  static late MockGetPodsUseCase getPodsUseCase;

  static late MockVotePodsFailure votePodsFailure;
  static late MockVotePodsUseCase votePodsUseCase;

  static late MockUnVotePodsFailure unVotePodsFailure;
  static late MockUnVotePodsUseCase unVotePodsUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockCirclePostsRepository circlePostsRepository;
  static late MockCircleReportsRepository circleReportsRepository;
  static late MockCircleModeratorActionsRepository circleModeratorActionsRepository;

//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP

    circleCreationRuleSelectionPresenter = MockCircleCreationRuleSelectionPresenter();
    circleCreationRuleSelectionPresentationModel = MockCircleCreationRuleSelectionPresentationModel();
    circleCreationRuleSelectionInitialParams = MockCircleCreationRuleSelectionInitialParams();
    circleCreationRuleSelectionNavigator = MockCircleCreationRuleSelectionNavigator();

    circleSettingsPresenter = MockCircleSettingsPresenter();
    circleSettingsPresentationModel = MockCircleSettingsPresentationModel();
    circleSettingsInitialParams = MockCircleSettingsInitialParams();
    circleSettingsNavigator = MockCircleSettingsNavigator();
    removeReasonPresenter = MockRemoveReasonPresenter();
    removeReasonPresentationModel = MockRemoveReasonPresentationModel();
    removeReasonInitialParams = MockRemoveReasonInitialParams();
    removeReasonNavigator = MockRemoveReasonNavigator();
    reportedPostPresenter = MockReportedPostPresenter();
    reportedPostPresentationModel = MockReportedPostPresentationModel();
    reportedPostInitialParams = MockReportedPostInitialParams();
    reportedPostNavigator = MockReportedContentNavigator();
    reportedMessagePresenter = MockReportedMessagePresenter();
    reportedMessagePresentationModel = MockReportedMessagePresentationModel();
    reportedMessageInitialParams = MockReportedMessageInitialParams();
    reportedMessageNavigator = MockReportedMessageNavigator();
    banUserListPresenter = MockBanUserListPresenter();
    banUserListPresentationModel = MockBanUserListPresentationModel();
    banUserListInitialParams = MockBanUserListInitialParams();
    banUserListNavigator = MockBanUserListNavigator();
    inviteUserListPresenter = MockInviteUserListPresenter();
    inviteUserListPresentationModel = MockInviteUserListPresentationModel();
    inviteUserListInitialParams = MockInviteUserListInitialParams();
    inviteUserListNavigator = MockInviteUserListNavigator();
    circleMemberSettingsPresenter = MockCircleMemberSettingsPresenter();
    circleMemberSettingsPresentationModel = MockCircleMemberSettingsPresentationModel();
    circleMemberSettingsInitialParams = MockCircleMemberSettingsInitialParams();
    circleMemberSettingsNavigator = MockCircleMemberSettingsNavigator();
    banUserPresenter = MockBanUserPresenter();
    banUserPresentationModel = MockBanUserPresentationModel();
    banUserInitialParams = MockBanUserInitialParams();
    banUserNavigator = MockBanUserNavigator();
    circleGroupsSelectionPresenter = MockCircleGroupsSelectionPresenter();
    circleGroupsSelectionPresentationModel = MockCircleGroupsSelectionPresentationModel();
    circleGroupsSelectionInitialParams = MockCircleGroupsSelectionInitialParams();
    circleGroupsSelectionNavigator = MockCircleGroupsSelectionNavigator();
    circleDetailsPresenter = MockCircleDetailsPresenter();
    circleDetailsPresentationModel = MockCircleDetailsPresentationModel();
    circleDetailsInitialParams = MockCircleDetailsInitialParams();
    circleDetailsNavigator = MockCircleDetailsNavigator();

    editRulesPresenter = MockEditRulesPresenter();
    editRulesPresentationModel = MockEditRulesPresentationModel();
    editRulesInitialParams = MockEditRulesInitialParams();
    editRulesNavigator = MockEditRulesNavigator();

    blacklistedWordsPresenter = MockBlacklistedWordsPresenter();
    blacklistedWordsPresentationModel = MockBlacklistedWordsPresentationModel();
    blacklistedWordsInitialParams = MockBlacklistedWordsInitialParams();
    blacklistedWordsNavigator = MockBlacklistedWordsNavigator();

    addBlackListWordPresenter = MockAddBlackListWordPresenter();
    addBlackListWordPresentationModel = MockAddBlackListWordPresentationModel();
    addBlackListWordInitialParams = MockAddBlackListWordInitialParams();
    addBlackListWordNavigator = MockAddBlackListWordNavigator();

    getRelatedMessagesUseCase = MockGetRelatedMessagesUseCase();
    getRelatedChatMessagesFeedUseCase = MockGetRelatedChatMessagesFeedUseCase();

    editCirclePresenter = MockEditCirclePresenter();
    editCirclePresentationModel = MockEditCirclePresentationModel();
    editCircleInitialParams = MockEditCircleInitialParams();
    editCircleNavigator = MockEditCircleNavigator();

    reportsListPresenter = MockReportsListPresenter();
    reportsListPresentationModel = MockReportsListPresentationModel();
    reportsListInitialParams = MockReportsListInitialParams();
    reportsListNavigator = MockReportsListNavigator();

    bannedUsersPresenter = MockBannedUsersPresenter();
    bannedUsersPresentationModel = MockBannedUsersPresentationModel();
    bannedUsersInitialParams = MockBannedUsersInitialParams();
    bannedUsersNavigator = MockBannedUsersNavigator();

    membersNavigator = MockMembersNavigator();

    resolveReportWithNoActionPresenter = MockResolveReportWithNoActionPresenter();
    resolveReportWithNoActionPresentationModel = MockResolveReportWithNoActionPresentationModel();
    resolveReportWithNoActionInitialParams = MockResolveReportWithNoActionInitialParams();
    resolveReportWithNoActionNavigator = MockResolveReportWithNoActionNavigator();

    rolesListPresenter = MockRolesListPresenter();
    rolesListPresentationModel = MockRolesListPresentationModel();
    rolesListInitialParams = MockRolesListInitialParams();
    rolesListNavigator = MockRolesListNavigator();

    circleRolePresenter = MockCircleRolePresenter();
    circleRolePresentationModel = MockCircleRolePresentationModel();
    circleRoleInitialParams = MockCircleRoleInitialParams();
    circleRoleNavigator = MockCircleRoleNavigator();

    userRolesPresenter = MockUserRolesPresenter();
    userRolesPresentationModel = MockUserRolesPresentationModel();
    userRolesInitialParams = MockUserRolesInitialParams();
    userRolesNavigator = MockUserRolesNavigator();

    circleConfigPresenter = MockCircleConfigPresenter();
    circleConfigPresentationModel = MockCircleConfigPresentationModel();
    circleConfigInitialParams = MockCircleConfigInitialParams();
    circleConfigNavigator = MockCircleConfigNavigator();

    discoverPodsPresenter = MockDiscoverPodsPresenter();
    discoverPodsPresentationModel = MockDiscoverPodsPresentationModel();
    discoverPodsInitialParams = MockDiscoverPodsInitialParams();
    discoverPodsNavigator = MockDiscoverPodsNavigator();

    podWebViewPresenter = MockPodWebViewPresenter();
    podWebViewPresentationModel = MockPodWebViewPresentationModel();
    podWebViewInitialParams = MockPodWebViewInitialParams();
    podWebViewNavigator = MockPodWebViewNavigator();

    discoverPodsPresenter = MockDiscoverPodsPresenter();
    discoverPodsPresentationModel = MockDiscoverPodsPresentationModel();
    discoverPodsInitialParams = MockDiscoverPodsInitialParams();
    discoverPodsNavigator = MockDiscoverPodsNavigator();

    podWebViewPresenter = MockPodWebViewPresenter();
    podWebViewPresentationModel = MockPodWebViewPresentationModel();
    podWebViewInitialParams = MockPodWebViewInitialParams();
    podWebViewNavigator = MockPodWebViewNavigator();

    addCirclePodPresenter = MockAddCirclePodPresenter();
    addCirclePodPresentationModel = MockAddCirclePodPresentationModel();
    addCirclePodInitialParams = MockAddCirclePodInitialParams();
    addCirclePodNavigator = MockAddCirclePodNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getRoyaltyFailure = MockGetRoyaltyFailure();
    getRoyaltyUseCase = MockGetRoyaltyUseCase();

    editRulesFailure = MockEditRulesFailure();
    editRulesUseCase = MockEditRulesUseCase();

    getCircleDetailsFailure = MockGetCircleDetailsFailure();
    getCircleDetailsUseCase = MockGetCircleDetailsUseCase();
    getCircleMembersByRoleUseCase = MockGetCircleMembersByRoleUseCase();

    getBannedUsersFailure = MockGetBannedUsersFailure();
    getBannedUsersUseCase = MockGetBannedUsersUseCase();

    getCircleMembersFailure = MockGetCircleMembersFailure();
    getCircleMembersUseCase = MockGetCircleMembersUseCase();

    unbanUserFailure = MockUnbanUserFailure();
    banUserFailure = MockBanUserFailure();

    unbanUserUseCase = MockUnbanUserUseCase();
    banUserUseCase = MockBanUserUseCase();

    unbanUserUseCase = MockUnbanUserUseCase();

    getReportsFailure = MockGetReportsFailure();
    getReportsUseCase = MockGetReportsUseCase();

    inviteUserToCircleFailure = MockInviteUserToCircleFailure();
    inviteUserToCircleUseCase = MockInviteUserToCircleUseCase();

    joinCircleUseCase = MockJoinCircleUseCase();
    joinCirclesUseCase = MockJoinCirclesUseCase();
    updateCircleMemberRoleFailure = MockUpdateCircleMemberRoleFailure();

    searchNonMemberUsersFailure = MockSearchNonMemberUsersFailure();
    searchNonMemberUsersUseCase = MockSearchNonMemberUsersUseCase();

    getBlacklistedWordsFailure = MockGetBlacklistedWordsFailure();
    getBlacklistedWordsUseCase = MockGetBlacklistedWordsUseCase();

    addBlacklistedWordsFailure = MockAddBlacklistedWordsFailure();
    addBlacklistedWordsUseCase = MockAddBlacklistedWordsUseCase();

    removeBlacklistedWordsFailure = MockRemoveBlacklistedWordsFailure();
    removeBlacklistedWordsUseCase = MockRemoveBlacklistedWordsUseCase();

    getCircleSortedPostsFailure = MockGetCircleSortedPostsFailure();
    getCircleSortedPostsUseCase = MockGetCircleSortedPostsUseCase();

    createCircleRoleFailure = MockCreateCircleRoleFailure();
    createCircleRoleUseCase = MockCreateCircleRoleUseCase();

    getCircleRoleFailure = MockGetCircleRoleFailure();
    getCircleRoleUseCase = MockGetCircleRolesUseCase();

    updateCircleRoleFailure = MockUpdateCircleRoleFailure();
    updateCircleRoleUseCase = MockUpdateCircleRoleUseCase();

    deleteRoleFailure = MockDeleteRoleFailure();
    deleteRoleUseCase = MockDeleteRoleUseCase();

    assignUserRoleFailure = MockAssignUserRoleFailure();
    assignUserRoleUseCase = MockAssignUserRoleUseCase();

    unAssignUserRoleFailure = MockUnAssignUserRoleFailure();
    unAssignUserRoleUseCase = MockUnAssignUserRoleUseCase();

    getRolesForUserFailure = MockGetRolesForUserFailure();
    getUserRolesInCircleUseCase = MockGetUserRolesInCircleUseCase();

    getLastUsedSortingOptionFailure = MockGetLastUsedSortingOptionFailure();
    getLastUsedSortingOptionUseCase = MockGetLastUsedSortingOptionUseCase();

    getDefaultCircleConfigFailure = MockGetDefaultCircleConfigFailure();
    getDefaultCircleConfigUseCase = MockGetDefaultCircleConfigUseCase();

    getPodsFailure = MockGetPodsFailure();
    getPodsUseCase = MockGetPodsUseCase();

    votePodsFailure = MockVotePodsFailure();
    votePodsUseCase = MockVotePodsUseCase();

    unVotePodsFailure = MockUnVotePodsFailure();
    unVotePodsUseCase = MockUnVotePodsUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    circlePostsRepository = MockCirclePostsRepository();
    circleReportsRepository = MockCircleReportsRepository();
    circleModeratorActionsRepository = MockCircleModeratorActionsRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP

    registerFallbackValue(MockCircleCreationRuleSelectionPresenter());
    registerFallbackValue(MockCircleCreationRuleSelectionPresentationModel());
    registerFallbackValue(MockCircleCreationRuleSelectionInitialParams());
    registerFallbackValue(MockCircleCreationRuleSelectionNavigator());

    registerFallbackValue(MockCircleSettingsPresenter());
    registerFallbackValue(MockCircleSettingsPresentationModel());
    registerFallbackValue(MockCircleSettingsInitialParams());
    registerFallbackValue(MockCircleSettingsNavigator());
    registerFallbackValue(MockRemoveReasonPresenter());
    registerFallbackValue(MockRemoveReasonPresentationModel());
    registerFallbackValue(MockRemoveReasonInitialParams());
    registerFallbackValue(MockRemoveReasonNavigator());
    registerFallbackValue(MockReportedPostPresenter());
    registerFallbackValue(MockReportedPostPresentationModel());
    registerFallbackValue(MockReportedPostInitialParams());
    registerFallbackValue(MockReportedContentNavigator());
    registerFallbackValue(MockReportedMessagePresenter());
    registerFallbackValue(MockReportedMessagePresentationModel());
    registerFallbackValue(MockReportedMessageInitialParams());
    registerFallbackValue(MockReportedMessageNavigator());
    registerFallbackValue(MockBanUserListPresenter());
    registerFallbackValue(MockBanUserListPresentationModel());
    registerFallbackValue(MockBanUserListInitialParams());
    registerFallbackValue(MockBanUserListNavigator());
    registerFallbackValue(MockInviteUserListPresenter());
    registerFallbackValue(MockInviteUserListPresentationModel());
    registerFallbackValue(MockInviteUserListInitialParams());
    registerFallbackValue(MockInviteUserListNavigator());
    registerFallbackValue(MockCircleMemberSettingsPresenter());
    registerFallbackValue(MockCircleMemberSettingsPresentationModel());
    registerFallbackValue(MockCircleMemberSettingsInitialParams());
    registerFallbackValue(MockCircleMemberSettingsNavigator());
    registerFallbackValue(MockBanUserPresenter());
    registerFallbackValue(MockBanUserPresentationModel());
    registerFallbackValue(MockBanUserInitialParams());
    registerFallbackValue(MockBanUserNavigator());
    registerFallbackValue(MockCircleGroupsSelectionPresenter());
    registerFallbackValue(MockCircleGroupsSelectionPresentationModel());
    registerFallbackValue(MockCircleGroupsSelectionInitialParams());
    registerFallbackValue(MockCircleGroupsSelectionNavigator());
    registerFallbackValue(MockCircleDetailsPresenter());
    registerFallbackValue(MockCircleDetailsPresentationModel());
    registerFallbackValue(MockCircleDetailsInitialParams());
    registerFallbackValue(MockCircleDetailsNavigator());

    registerFallbackValue(MockEditRulesPresenter());
    registerFallbackValue(MockEditRulesPresentationModel());
    registerFallbackValue(MockEditRulesInitialParams());
    registerFallbackValue(MockEditRulesNavigator());

    registerFallbackValue(MockBlacklistedWordsPresenter());
    registerFallbackValue(MockBlacklistedWordsPresentationModel());
    registerFallbackValue(MockBlacklistedWordsInitialParams());
    registerFallbackValue(MockBlacklistedWordsNavigator());

    registerFallbackValue(MockAddBlackListWordPresenter());
    registerFallbackValue(MockAddBlackListWordPresentationModel());
    registerFallbackValue(MockAddBlackListWordInitialParams());
    registerFallbackValue(MockAddBlackListWordNavigator());

    registerFallbackValue(MockGetRelatedMessagesUseCase());
    registerFallbackValue(MockGetRelatedChatMessagesFeedUseCase());

    registerFallbackValue(MockEditCirclePresenter());
    registerFallbackValue(MockEditCirclePresentationModel());
    registerFallbackValue(MockEditCircleInitialParams());
    registerFallbackValue(MockEditCircleNavigator());

    registerFallbackValue(MockReportsListPresenter());
    registerFallbackValue(MockReportsListPresentationModel());
    registerFallbackValue(MockReportsListInitialParams());
    registerFallbackValue(MockReportsListNavigator());

    registerFallbackValue(MockBannedUsersPresenter());
    registerFallbackValue(MockBannedUsersPresentationModel());
    registerFallbackValue(MockBannedUsersInitialParams());
    registerFallbackValue(MockBannedUsersNavigator());

    registerFallbackValue(MockMembersNavigator());

    registerFallbackValue(MockRolesListPresenter());
    registerFallbackValue(MockRolesListPresentationModel());
    registerFallbackValue(MockRolesListInitialParams());
    registerFallbackValue(MockRolesListNavigator());

    registerFallbackValue(MockCircleRolePresenter());
    registerFallbackValue(MockCircleRolePresentationModel());
    registerFallbackValue(MockCircleRoleInitialParams());
    registerFallbackValue(MockCircleRoleNavigator());

    registerFallbackValue(MockUserRolesPresenter());
    registerFallbackValue(MockUserRolesPresentationModel());
    registerFallbackValue(MockUserRolesInitialParams());
    registerFallbackValue(MockUserRolesNavigator());

    registerFallbackValue(MockResolveReportWithNoActionPresenter());
    registerFallbackValue(MockResolveReportWithNoActionPresentationModel());
    registerFallbackValue(MockResolveReportWithNoActionInitialParams());
    registerFallbackValue(MockResolveReportWithNoActionNavigator());

    registerFallbackValue(MockCircleConfigPresenter());
    registerFallbackValue(MockCircleConfigPresentationModel());
    registerFallbackValue(MockCircleConfigInitialParams());
    registerFallbackValue(MockCircleConfigNavigator());

    registerFallbackValue(MockDiscoverPodsPresenter());
    registerFallbackValue(MockDiscoverPodsPresentationModel());
    registerFallbackValue(MockDiscoverPodsInitialParams());
    registerFallbackValue(MockDiscoverPodsNavigator());

    registerFallbackValue(MockPodWebViewPresenter());
    registerFallbackValue(MockPodWebViewPresentationModel());
    registerFallbackValue(MockPodWebViewInitialParams());
    registerFallbackValue(MockPodWebViewNavigator());

    registerFallbackValue(MockDiscoverPodsPresenter());
    registerFallbackValue(MockDiscoverPodsPresentationModel());
    registerFallbackValue(MockDiscoverPodsInitialParams());
    registerFallbackValue(MockDiscoverPodsNavigator());

    registerFallbackValue(MockPodWebViewPresenter());
    registerFallbackValue(MockPodWebViewPresentationModel());
    registerFallbackValue(MockPodWebViewInitialParams());
    registerFallbackValue(MockPodWebViewNavigator());

    registerFallbackValue(MockAddCirclePodPresenter());
    registerFallbackValue(MockAddCirclePodPresentationModel());
    registerFallbackValue(MockAddCirclePodInitialParams());
    registerFallbackValue(MockAddCirclePodNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetRoyaltyFailure());
    registerFallbackValue(MockGetRoyaltyUseCase());
    registerFallbackValue(MockEditRulesFailure());
    registerFallbackValue(MockEditRulesUseCase());

    registerFallbackValue(MockGetCircleDetailsFailure());
    registerFallbackValue(MockGetCircleDetailsUseCase());
    registerFallbackValue(MockGetCircleMembersByRoleUseCase());

    registerFallbackValue(MockGetBannedUsersFailure());
    registerFallbackValue(MockGetBannedUsersUseCase());
    registerFallbackValue(MockGetReportsUseCase());

    registerFallbackValue(MockGetCircleMembersFailure());
    registerFallbackValue(MockGetCircleMembersUseCase());

    registerFallbackValue(MockBanUserFailure());
    registerFallbackValue(MockUnbanUserFailure());
    registerFallbackValue(MockUnbanUserUseCase());
    registerFallbackValue(MockBanUserUseCase());

    registerFallbackValue(MockInviteUserToCircleFailure());
    registerFallbackValue(MockInviteUserToCircleUseCase());

    registerFallbackValue(MockUpdateCircleMemberRoleFailure());

    registerFallbackValue(MockSearchNonMemberUsersFailure());
    registerFallbackValue(MockSearchNonMemberUsersUseCase());

    registerFallbackValue(MockGetBlacklistedWordsFailure());
    registerFallbackValue(MockGetBlacklistedWordsUseCase());

    registerFallbackValue(MockAddBlacklistedWordsFailure());
    registerFallbackValue(MockAddBlacklistedWordsUseCase());

    registerFallbackValue(MockRemoveBlacklistedWordsFailure());
    registerFallbackValue(MockRemoveBlacklistedWordsUseCase());

    registerFallbackValue(const ListGroupsInput.empty());

    registerFallbackValue(MockGetCircleSortedPostsFailure());
    registerFallbackValue(MockGetCircleSortedPostsUseCase());

    registerFallbackValue(MockCreateCircleRoleFailure());
    registerFallbackValue(MockCreateCircleRoleUseCase());

    registerFallbackValue(MockGetCircleRoleFailure());
    registerFallbackValue(MockGetCircleRolesUseCase());

    registerFallbackValue(MockUpdateCircleRoleFailure());
    registerFallbackValue(MockUpdateCircleRoleUseCase());

    registerFallbackValue(MockDeleteRoleFailure());
    registerFallbackValue(MockDeleteRoleUseCase());

    registerFallbackValue(MockAssignUserRoleFailure());
    registerFallbackValue(MockAssignUserRoleUseCase());

    registerFallbackValue(MockUnAssignUserRoleFailure());
    registerFallbackValue(MockUnAssignUserRoleUseCase());

    registerFallbackValue(MockGetRolesForUserFailure());
    registerFallbackValue(MockGetUserRolesInCircleUseCase());

    registerFallbackValue(MockGetLastUsedSortingOptionFailure());
    registerFallbackValue(MockGetLastUsedSortingOptionUseCase());

    registerFallbackValue(MockGetDefaultCircleConfigFailure());
    registerFallbackValue(MockGetDefaultCircleConfigUseCase());

    registerFallbackValue(MockGetPodsFailure());
    registerFallbackValue(MockGetPodsUseCase());

    registerFallbackValue(MockVotePodsFailure());
    registerFallbackValue(MockVotePodsUseCase());

    registerFallbackValue(MockUnVotePodsFailure());
    registerFallbackValue(MockUnVotePodsUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockCirclePostsRepository());
    registerFallbackValue(MockCircleModeratorActionsRepository());
    registerFallbackValue(MockCircleReportsRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockCircleModeratorActionsRepository());
  }
}
