import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message_input.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_action.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/chat/domain/model/message_action_result/chat_message_reaction_type.dart';
import 'package:picnic_app/features/chat/domain/use_cases/react_on_chat_message_use_case.dart';

import '../../../mocks/stubs.dart';
import 'chat_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class ChatMocks {
  // MVP

  static late MockChatTabsPresenter chatTabsPresenter;
  static late MockChatTabsPresentationModel chatTabsPresentationModel;
  static late MockChatTabsInitialParams chatTabsInitialParams;
  static late MockChatTabsNavigator chatTabsNavigator;
  static late MockNewMessagePresenter newMessagePresenter;
  static late MockNewMessagePresentationModel newMessagePresentationModel;
  static late MockNewMessageInitialParams newMessageInitialParams;
  static late MockNewMessageNavigator newMessageNavigator;
  static late MockChatFeedPresenter chatFeedPresenter;
  static late MockChatFeedPresentationModel chatFeedPresentationModel;
  static late MockChatFeedInitialParams chatFeedInitialParams;
  static late MockChatFeedNavigator chatFeedNavigator;
  static late MockChatMyCirclesPresenter chatMyCirclesPresenter;
  static late MockChatMyCirclesPresentationModel chatMyCirclesPresentationModel;
  static late MockChatMyCirclesInitialParams chatMyCirclesInitialParams;
  static late MockChatMyCirclesNavigator chatMyCirclesNavigator;
  static late MockChatDmsPresenter chatDmsPresenter;
  static late MockChatDmsPresentationModel chatDmsPresentationModel;
  static late MockChatDmsInitialParams chatDmsInitialParams;
  static late MockChatDmsNavigator chatDmsNavigator;
  static late MockSingleChatPresenter singleChatPresenter;
  static late MockSingleChatPresentationModel singleChatPresentationModel;
  static late MockSingleChatInitialParams singleChatInitialParams;
  static late MockSingleChatNavigator singleChatNavigator;
  static late MockGroupChatPresenter groupChatPresenter;
  static late MockGroupChatPresentationModel groupChatPresentationModel;
  static late MockGroupChatInitialParams groupChatInitialParams;
  static late MockGroupChatNavigator groupChatNavigator;

  static late MockGroupChatMorePresenter groupChatMorePresenter;
  static late MockGroupChatMorePresentationModel groupChatMorePresentationModel;
  static late MockGroupChatMoreInitialParams groupChatMoreInitialParams;
  static late MockGroupChatMoreNavigator groupChatMoreNavigator;
  static late MockAddMembersListPresenter addMembersListPresenter;
  static late MockAddMembersListPresentationModel addMembersListPresentationModel;
  static late MockAddMembersListInitialParams addMembersListInitialParams;
  static late MockAddMembersListNavigator addMembersListNavigator;

  static late MockCircleChatPresenter circleChatPresenter;
  static late MockCircleChatPresentationModel circleChatPresentationModel;
  static late MockCircleChatInitialParams circleChatInitialParams;
  static late MockCircleChatNavigator circleChatNavigator;

  static late MockCircleChatSettingsInitialParams circleChatSettingsInitialParams;

  static late MockSingleChatSettingsPresenter singleChatSettingsPresenter;
  static late MockSingleChatSettingsPresentationModel singleChatSettingsPresentationModel;
  static late MockSingleChatSettingsInitialParams singleChatSettingsInitialParams;
  static late MockSingleChatSettingsNavigator singleChatSettingsNavigator;

  static late MockChatDeeplinkRoutingPresenter chatDeeplinkRoutingPresenter;
  static late MockChatDeeplinkRoutingPresentationModel chatDeeplinkRoutingPresentationModel;
  static late MockChatDeeplinkRoutingInitialParams chatDeeplinkRoutingInitialParams;
  static late MockChatDeeplinkRoutingNavigator chatDeeplinkRoutingNavigator;

  static late MockFullscreenImageAttachmentNavigator fullscreenImageAttachmentNavigator;

  static late MockMessageActionsInitialParams messageActionsInitialParams;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetFriendsUseCase getFriendsUseCase;
  static late MockSendChatMessageUseCase sendChatMessageUseCase;
  static late MockGetChatsUseCase getChatsUseCase;
  static late MockGetCircleChatsUseCase getCircleChatsUseCase;
  static late MockGetChatFeedsUseCase getChatFeedsUseCase;
  static late MockGetChatUseCase getChatUseCase;
  static late MockLeaveChatUseCase leaveChatUseCase;
  static late MockJoinChatUseCase joinChatUseCase;
  static late MockChatMessagesUseCase chatMessagesUseCase;
  static late MockGetMessagesInChatUseCase getMessagesInChatUseCase;
  static late MockGetSingleChatMessageUseCase getSingleChatMessageUseCase;
  static late MockGetChatSettingsUseCase getChatSettingsUseCase;
  static late MockUpdateChatSettingsUseCase updateChatSettingsUseCase;
  static late MockGetChatMembersUseCase getChatMembersUseCase;
  static late MockReactOnChatMessageUseCase reactOnChatMessageUseCase;
  static late MockInviteUsersToChatUseCase inviteUsersToChatUseCase;
  static late MockAddUserToChatUseCase addUserToChatUseCase;
  static late MockRemoveUserFromChatUseCase removeUserFromChatUseCase;
  static late MockUpdateChatNameUseCase updateChatNameUseCase;
  static late MockCreateGroupChatUseCase createGroupChatUseCase;
  static late MockCreateSingleChatUseCase createSingleChatUseCase;
  static late MockPrepareChatLiveDataClientUseCase prepareChatLiveDataClientUseCase;
  static late MockDeleteMessageUseCase deleteMessageUseCase;
  static late MockUpdateUsersToMentionByUserUseCase updateUsersToMentionByUserUseCase;
  static late MockUpdateContentByMentionUseCase updateContentByMentionUseCase;
  static late MockUpdateUsersToMentionByMentionsUseCase updateUsersToMentionByMentionsUseCase;

  // FAILURES
  static late MockLeaveChatFailure leaveChatFailure;
  static late MockChatMessagesFailure chatMessagesFailure;
  static late MockGetChatsFailure getChatsFailure;
  static late MockDeleteChatFailure deleteChatFailure;
  static late MockGetFriendsFailure getFriendsFailure;
  static late MockSendChatMessageFailure sendChatMessageFailure;
  static late MockGetChatSettingsFailure getChatSettingsFailure;
  static late MockUpdateChatSettingsFailure updateChatSettingsFailure;
  static late MockGetChatMembersFailure getChatMembersFailure;
  static late MockGetChatParticipantsFailure getChatParticipantsFailure;
  static late MockGetChatParticipantsUseCase getChatParticipantsUseCase;
  static late MockGetUploadChatAttachmentUseCase getUploadChatAttachmentUseCase;
  static late MockSaveAttachmentUseCase saveAttachmentUseCase;
  static late MockGetSingleChatRecipientUseCase getSingleChatRecipientUseCase;
  static late MockGetChatFailure getChatFailure;
  static late MockGetUnreadChatsFailure getChatMetaDataFailure;
  static late MockGetUnreadChatsUseCase getUnreadChatsUseCase;

  static late MockMarkMessageAsReadFailure markMessageAsReadFailure;
  static late MockMarkMessageAsReadUseCase markMessageAsReadUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockChatRepository chatRepository;
  static late MockChatSettingsRepository chatSettingsRepository;
  static late MockLiveEventsRepository chatLiveMessagesRepository;

  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  //OTHERS
  static late MockCentrifugeClient chatMessagesClient;

  static late MockLiveChatsPresenter liveChatsPresenter;
  static late MockGetChatMessagesProvider getChatMessagesProvider;
  static late MockOnChatMessagesUpdatedCallback onChatMessagesUpdatedCallback;

  static List<ChatMessage>? _getChatMessagesProvider({required Id chatId}) => [];

  static void _onChatMessagesUpdatedCallback({required Id chatId, required List<ChatMessage> chatMessages}) {}

  // STORES
  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    chatTabsPresenter = MockChatTabsPresenter();
    chatTabsPresentationModel = MockChatTabsPresentationModel();
    chatTabsInitialParams = MockChatTabsInitialParams();
    chatTabsNavigator = MockChatTabsNavigator();
    newMessagePresenter = MockNewMessagePresenter();
    newMessagePresentationModel = MockNewMessagePresentationModel();
    newMessageInitialParams = MockNewMessageInitialParams();
    newMessageNavigator = MockNewMessageNavigator();
    singleChatPresenter = MockSingleChatPresenter();
    singleChatPresentationModel = MockSingleChatPresentationModel();
    singleChatInitialParams = MockSingleChatInitialParams();
    singleChatNavigator = MockSingleChatNavigator();
    groupChatPresenter = MockGroupChatPresenter();
    groupChatPresentationModel = MockGroupChatPresentationModel();
    groupChatInitialParams = MockGroupChatInitialParams();
    groupChatNavigator = MockGroupChatNavigator();
    groupChatMorePresenter = MockGroupChatMorePresenter();
    groupChatMorePresentationModel = MockGroupChatMorePresentationModel();
    groupChatMoreInitialParams = MockGroupChatMoreInitialParams();
    groupChatMoreNavigator = MockGroupChatMoreNavigator();
    addMembersListPresenter = MockAddMembersListPresenter();
    addMembersListPresentationModel = MockAddMembersListPresentationModel();
    addMembersListInitialParams = MockAddMembersListInitialParams();
    addMembersListNavigator = MockAddMembersListNavigator();
    circleChatPresenter = MockCircleChatPresenter();
    circleChatPresentationModel = MockCircleChatPresentationModel();
    circleChatInitialParams = MockCircleChatInitialParams();
    circleChatNavigator = MockCircleChatNavigator();
    circleChatSettingsInitialParams = MockCircleChatSettingsInitialParams();
    getChatFailure = MockGetChatFailure();
    singleChatSettingsPresenter = MockSingleChatSettingsPresenter();
    singleChatSettingsPresentationModel = MockSingleChatSettingsPresentationModel();
    singleChatSettingsInitialParams = MockSingleChatSettingsInitialParams();
    singleChatSettingsNavigator = MockSingleChatSettingsNavigator();
    chatDeeplinkRoutingPresenter = MockChatDeeplinkRoutingPresenter();
    chatDeeplinkRoutingPresentationModel = MockChatDeeplinkRoutingPresentationModel();
    chatDeeplinkRoutingInitialParams = MockChatDeeplinkRoutingInitialParams();
    chatDeeplinkRoutingNavigator = MockChatDeeplinkRoutingNavigator();
    fullscreenImageAttachmentNavigator = MockFullscreenImageAttachmentNavigator();
    messageActionsInitialParams = MockMessageActionsInitialParams();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getFriendsFailure = MockGetFriendsFailure();
    getFriendsUseCase = MockGetFriendsUseCase();
    sendChatMessageFailure = MockSendChatMessageFailure();
    sendChatMessageUseCase = MockSendChatMessageUseCase();
    chatMessagesFailure = MockChatMessagesFailure();
    chatMessagesUseCase = MockChatMessagesUseCase();
    getChatsFailure = MockGetChatsFailure();
    getChatsUseCase = MockGetChatsUseCase();
    getCircleChatsUseCase = MockGetCircleChatsUseCase();
    getChatFeedsUseCase = MockGetChatFeedsUseCase();
    getChatUseCase = MockGetChatUseCase();
    leaveChatFailure = MockLeaveChatFailure();
    leaveChatUseCase = MockLeaveChatUseCase();
    joinChatUseCase = MockJoinChatUseCase();
    getMessagesInChatUseCase = MockGetMessagesInChatUseCase();
    getSingleChatMessageUseCase = MockGetSingleChatMessageUseCase();
    getChatSettingsUseCase = MockGetChatSettingsUseCase();
    updateChatSettingsUseCase = MockUpdateChatSettingsUseCase();
    getChatMembersUseCase = MockGetChatMembersUseCase();
    reactOnChatMessageUseCase = MockReactOnChatMessageUseCase();
    inviteUsersToChatUseCase = MockInviteUsersToChatUseCase();
    addUserToChatUseCase = MockAddUserToChatUseCase();
    removeUserFromChatUseCase = MockRemoveUserFromChatUseCase();
    updateChatNameUseCase = MockUpdateChatNameUseCase();
    createGroupChatUseCase = MockCreateGroupChatUseCase();
    createSingleChatUseCase = MockCreateSingleChatUseCase();
    deleteChatFailure = MockDeleteChatFailure();
    getUploadChatAttachmentUseCase = MockGetUploadChatAttachmentUseCase();
    saveAttachmentUseCase = MockSaveAttachmentUseCase();
    prepareChatLiveDataClientUseCase = MockPrepareChatLiveDataClientUseCase();
    deleteMessageUseCase = MockDeleteMessageUseCase();
    getChatParticipantsFailure = MockGetChatParticipantsFailure();
    getChatParticipantsUseCase = MockGetChatParticipantsUseCase();

    getSingleChatRecipientUseCase = MockGetSingleChatRecipientUseCase();
    getChatSettingsFailure = MockGetChatSettingsFailure();
    updateChatSettingsFailure = MockUpdateChatSettingsFailure();
    getChatMembersFailure = MockGetChatMembersFailure();
    getChatUseCase = MockGetChatUseCase();
    getChatFailure = MockGetChatFailure();
    updateUsersToMentionByUserUseCase = MockUpdateUsersToMentionByUserUseCase();
    updateContentByMentionUseCase = MockUpdateContentByMentionUseCase();
    updateUsersToMentionByMentionsUseCase = MockUpdateUsersToMentionByMentionsUseCase();

    getChatMetaDataFailure = MockGetUnreadChatsFailure();
    getUnreadChatsUseCase = MockGetUnreadChatsUseCase();

    markMessageAsReadFailure = MockMarkMessageAsReadFailure();
    markMessageAsReadUseCase = MockMarkMessageAsReadUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    chatRepository = MockChatRepository();
    chatSettingsRepository = MockChatSettingsRepository();
    chatLiveMessagesRepository = MockLiveEventsRepository();
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS

    // OTHERS
    chatMessagesClient = MockCentrifugeClient();

    liveChatsPresenter = MockLiveChatsPresenter();
    getChatMessagesProvider = MockGetChatMessagesProvider();
    onChatMessagesUpdatedCallback = MockOnChatMessagesUpdatedCallback();
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockChatTabsPresenter());
    registerFallbackValue(MockChatTabsPresentationModel());
    registerFallbackValue(MockChatTabsInitialParams());
    registerFallbackValue(MockChatTabsNavigator());
    registerFallbackValue(MockNewMessagePresenter());
    registerFallbackValue(MockNewMessagePresentationModel());
    registerFallbackValue(MockNewMessageInitialParams());
    registerFallbackValue(MockNewMessageNavigator());
    registerFallbackValue(MockGroupChatPresenter());
    registerFallbackValue(MockGroupChatPresentationModel());
    registerFallbackValue(MockGroupChatInitialParams());
    registerFallbackValue(MockGroupChatNavigator());
    registerFallbackValue(MockGroupChatMorePresenter());
    registerFallbackValue(MockGroupChatMorePresentationModel());
    registerFallbackValue(MockGroupChatMoreInitialParams());
    registerFallbackValue(MockGroupChatMoreNavigator());
    registerFallbackValue(MockAddMembersListPresenter());
    registerFallbackValue(MockAddMembersListPresentationModel());
    registerFallbackValue(MockAddMembersListInitialParams());
    registerFallbackValue(MockAddMembersListNavigator());
    registerFallbackValue(MockCircleChatPresenter());
    registerFallbackValue(MockCircleChatPresentationModel());
    registerFallbackValue(MockCircleChatInitialParams());
    registerFallbackValue(MockCircleChatNavigator());
    registerFallbackValue(MockCircleChatSettingsInitialParams());

    registerFallbackValue(MockSingleChatSettingsPresenter());
    registerFallbackValue(MockSingleChatSettingsPresentationModel());
    registerFallbackValue(MockSingleChatSettingsInitialParams());
    registerFallbackValue(MockSingleChatSettingsNavigator());

    registerFallbackValue(MockChatDeeplinkRoutingPresenter());
    registerFallbackValue(MockChatDeeplinkRoutingPresentationModel());
    registerFallbackValue(MockChatDeeplinkRoutingInitialParams());
    registerFallbackValue(MockChatDeeplinkRoutingNavigator());

    registerFallbackValue(MockFullscreenImageAttachmentInitialParams());

    registerFallbackValue(MockMessageActionsInitialParams());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetFriendsFailure());
    registerFallbackValue(MockGetFriendsUseCase());
    registerFallbackValue(MockSendChatMessageFailure());
    registerFallbackValue(MockSendChatMessageUseCase());
    registerFallbackValue(MockGetMessagesInChatUseCase());

    registerFallbackValue(Stubs.messageReaction);

    registerFallbackValue(MockGetChatParticipantsFailure());
    registerFallbackValue(MockGetChatParticipantsUseCase());

    registerFallbackValue(MockGetChatSettingsFailure());
    registerFallbackValue(MockGetChatSettingsUseCase());

    registerFallbackValue(MockUpdateChatSettingsFailure());
    registerFallbackValue(MockUpdateChatSettingsUseCase());

    registerFallbackValue(MockGetChatMembersFailure());
    registerFallbackValue(MockGetChatMembersUseCase());

    registerFallbackValue(Stubs.chatSettings);

    registerFallbackValue(MockGetChatFailure());
    registerFallbackValue(MockGetChatUseCase());

    registerFallbackValue(Stubs.chat);

    registerFallbackValue(MockGetUnreadChatsFailure());
    registerFallbackValue(MockGetUnreadChatsUseCase());

    registerFallbackValue(MockMarkMessageAsReadFailure());
    registerFallbackValue(MockMarkMessageAsReadUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE
    registerFallbackValue(MockGetChatsFailure());
    registerFallbackValue(MockGetChatsUseCase());
    registerFallbackValue(MockLeaveChatFailure());
    registerFallbackValue(MockLeaveChatUseCase());

    registerFallbackValue(ChatMessagesActionInit(chatIds: []));

    registerFallbackValue(ReactOnChatMessageAction.react);
    registerFallbackValue(ChatMessageReactionType.heart);

    // REPOSITORIES
    registerFallbackValue(MockChatRepository());
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // INITIAL PARAMS
    registerFallbackValue(MockSingleChatInitialParams());

    // GRAPHQL
    registerFallbackValue(const ChatMessageInput.empty());
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE

    // OTHERS

    registerFallbackValue(_getChatMessagesProvider);
    registerFallbackValue(_onChatMessagesUpdatedCallback);
  }
}
