import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/centrifuge/centrifuge_client.dart';
import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_navigator.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presentation_model.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presenter.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_initial_params.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_navigator.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presenter.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_initial_params.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_navigator.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presenter.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_navigator.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presenter.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_initial_params.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_navigator.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presenter.dart';
import "package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_presentation_model.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_presenter.dart";
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_navigator.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/domain/model/chat_messages_failure.dart';
import 'package:picnic_app/features/chat/domain/model/delete_chat_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_failure.dart';
import "package:picnic_app/features/chat/domain/model/get_chat_members_failure.dart";
import 'package:picnic_app/features/chat/domain/model/get_chat_participants_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_chats_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_friends_failure.dart';
import 'package:picnic_app/features/chat/domain/model/get_unread_chats_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import "package:picnic_app/features/chat/domain/model/leave_chat_failure.dart";
import 'package:picnic_app/features/chat/domain/model/mark_message_as_read_failure.dart';
import 'package:picnic_app/features/chat/domain/model/send_chat_message_failure.dart';
import 'package:picnic_app/features/chat/domain/model/update_chat_settings_failure.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_repository.dart';
import 'package:picnic_app/features/chat/domain/repositories/chat_settings_repository.dart';
import 'package:picnic_app/features/chat/domain/use_cases/add_user_to_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/chat_messages_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_group_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/create_single_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/delete_message_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_feeds_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_members_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_participants_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chats_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_circle_chats_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_friends_use_case.dart';
import "package:picnic_app/features/chat/domain/use_cases/get_messages_in_chat_use_case.dart";
import 'package:picnic_app/features/chat/domain/use_cases/get_single_chat_message_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_single_chat_recipient_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_unread_chats_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_upload_chat_attachment_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/invite_users_to_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/join_chat_use_case.dart';
import "package:picnic_app/features/chat/domain/use_cases/leave_chat_use_case.dart";
import 'package:picnic_app/features/chat/domain/use_cases/mark_message_as_read_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/mentions/update_content_by_mention_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/mentions/update_users_to_mention_by_mentions_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/mentions/update_users_to_mention_by_user_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/prepare_chat_live_data_client_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/react_on_chat_message_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/remove_user_from_chat_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/save_attachment_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/send_chat_message_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_name_use_case.dart';
import 'package:picnic_app/features/chat/domain/use_cases/update_chat_settings_use_case.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_initial_params.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presenter.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_navigator.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presenter.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presentation_model.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presenter.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presenter.dart';
import 'package:picnic_app/features/chat/utils/live_chats_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockChatTabsPresenter extends MockCubit<ChatTabsViewModel> implements ChatTabsPresenter {}

class MockChatTabsPresentationModel extends Mock implements ChatTabsPresentationModel {}

class MockChatTabsInitialParams extends Mock implements ChatTabsInitialParams {}

class MockChatTabsNavigator extends Mock implements ChatTabsNavigator {}

class MockChatFeedPresenter extends MockCubit<ChatFeedViewModel> implements ChatFeedPresenter {}

class MockChatFeedPresentationModel extends Mock implements ChatFeedPresentationModel {}

class MockChatFeedInitialParams extends Mock implements ChatFeedInitialParams {}

class MockChatFeedNavigator extends Mock implements ChatFeedNavigator {}

class MockChatMyCirclesPresenter extends MockCubit<ChatMyCirclesViewModel> implements ChatMyCirclesPresenter {}

class MockChatMyCirclesPresentationModel extends Mock implements ChatMyCirclesPresentationModel {}

class MockChatMyCirclesInitialParams extends Mock implements ChatMyCirclesInitialParams {}

class MockChatMyCirclesNavigator extends Mock implements ChatMyCirclesNavigator {}

class MockChatDmsPresenter extends MockCubit<ChatDmsViewModel> implements ChatDmsPresenter {}

class MockChatDmsPresentationModel extends Mock implements ChatDmsPresentationModel {}

class MockChatDmsInitialParams extends Mock implements ChatDmsInitialParams {}

class MockChatDmsNavigator extends Mock implements ChatDmsNavigator {}

class MockNewMessagePresenter extends MockCubit<NewMessageViewModel> implements NewMessagePresenter {}

class MockNewMessagePresentationModel extends Mock implements NewMessagePresentationModel {}

class MockNewMessageInitialParams extends Mock implements NewMessageInitialParams {}

class MockNewMessageNavigator extends Mock implements NewMessageNavigator {}

class MockSingleChatPresenter extends MockCubit<SingleChatViewModel> implements SingleChatPresenter {}

class MockSingleChatPresentationModel extends Mock implements SingleChatPresentationModel {}

class MockSingleChatInitialParams extends Mock implements SingleChatInitialParams {}

class MockSingleChatNavigator extends Mock implements SingleChatNavigator {}

class MockGroupChatPresenter extends MockCubit<GroupChatViewModel> implements GroupChatPresenter {}

class MockGroupChatPresentationModel extends Mock implements GroupChatPresentationModel {}

class MockGroupChatInitialParams extends Mock implements GroupChatInitialParams {}

class MockGroupChatNavigator extends Mock implements GroupChatNavigator {}

class MockGroupChatMorePresenter extends MockCubit<GroupChatMoreViewModel> implements GroupChatMorePresenter {}

class MockGroupChatMorePresentationModel extends Mock implements GroupChatMorePresentationModel {}

class MockGroupChatMoreInitialParams extends Mock implements GroupChatMoreInitialParams {}

class MockGroupChatMoreNavigator extends Mock implements GroupChatMoreNavigator {}

class MockAddMembersListPresenter extends MockCubit<AddMembersListViewModel> implements AddMembersListPresenter {}

class MockAddMembersListPresentationModel extends Mock implements AddMembersListPresentationModel {}

class MockAddMembersListInitialParams extends Mock implements AddMembersListInitialParams {}

class MockAddMembersListNavigator extends Mock implements AddMembersListNavigator {}

class MockCircleChatPresenter extends MockCubit<CircleChatViewModel> implements CircleChatPresenter {}

class MockCircleChatPresentationModel extends Mock implements CircleChatPresentationModel {}

class MockCircleChatInitialParams extends Mock implements CircleChatInitialParams {}

class MockCircleChatNavigator extends Mock implements CircleChatNavigator {}

class MockMessageActionsNavigator extends Mock implements MessageActionsNavigator {}

class MockCircleChatSettingsNavigator extends Mock implements CircleChatSettingsNavigator {}

class MockCircleChatSettingsInitialParams extends Mock implements CircleChatSettingsInitialParams {}

class MockSingleChatSettingsPresenter extends MockCubit<SingleChatSettingsViewModel>
    implements SingleChatSettingsPresenter {}

class MockSingleChatSettingsPresentationModel extends Mock implements SingleChatSettingsPresentationModel {}

class MockSingleChatSettingsInitialParams extends Mock implements SingleChatSettingsInitialParams {}

class MockSingleChatSettingsNavigator extends Mock implements SingleChatSettingsNavigator {}

class MockFullscreenImageAttachmentInitialParams extends Mock implements FullscreenAttachmentInitialParams {}

class MockFullscreenImageAttachmentNavigator extends Mock implements FullscreenAttachmentNavigator {}

class MockMessageActionsInitialParams extends Mock implements MessageActionsInitialParams {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetFriendsFailure extends Mock implements GetFriendsFailure {}

class MockGetFriendsUseCase extends Mock implements GetFriendsUseCase {}

class MockSendChatMessageFailure extends Mock implements SendChatMessageFailure {}

class MockSendChatMessageUseCase extends Mock implements SendChatMessageUseCase {}

class MockChatMessagesFailure extends Mock implements ChatMessagesFailure {}

class MockChatMessagesUseCase extends Mock implements ChatMessagesUseCase {}

class MockGetMessagesInChatUseCase extends Mock implements GetMessagesInChatUseCase {}

class MockGetSingleChatMessageUseCase extends Mock implements GetSingleChatMessageUseCase {}

class MockGetChatSettingsFailure extends Mock implements GetChatSettingsFailure {}

class MockUpdateChatSettingsFailure extends Mock implements UpdateChatSettingsFailure {}

class MockGetChatSettingsUseCase extends Mock implements GetChatSettingsUseCase {}

class MockReactOnChatMessageUseCase extends Mock implements ReactOnChatMessageUseCase {}

class MockInviteUsersToChatUseCase extends Mock implements InviteUsersToChatUseCase {}

class MockAddUserToChatUseCase extends Mock implements AddUserToChatUseCase {}

class MockRemoveUserFromChatUseCase extends Mock implements RemoveUserFromChatUseCase {}

class MockUpdateChatSettingsUseCase extends Mock implements UpdateChatSettingsUseCase {}

class MockUpdateChatNameUseCase extends Mock implements UpdateChatNameUseCase {}

class MockCreateGroupChatUseCase extends Mock implements CreateGroupChatUseCase {}

class MockDeleteChatFailure extends Mock implements DeleteChatFailure {}

class MockCreateSingleChatUseCase extends Mock implements CreateSingleChatUseCase {}

class MockGetChatsFailure extends Mock implements GetChatsFailure {}

class MockGetChatsUseCase extends Mock implements GetChatsUseCase {}

class MockGetCircleChatsUseCase extends Mock implements GetCircleChatsUseCase {}

class MockGetChatFeedsUseCase extends Mock implements GetChatFeedsUseCase {}

class MockGetChatUseCase extends Mock implements GetChatUseCase {}

class MockGetChatFailure extends Mock implements GetChatFailure {}

class MockLeaveChatFailure extends Mock implements LeaveChatFailure {}

class MockLeaveChatUseCase extends Mock implements LeaveChatUseCase {}

class MockJoinChatUseCase extends Mock implements JoinChatUseCase {}

class MockPrepareChatLiveDataClientUseCase extends Mock implements PrepareChatLiveDataClientUseCase {}

class MockGetChatMembersFailure extends Mock implements GetChatMembersFailure {}

class MockGetChatParticipantsFailure extends Mock implements GetChatParticipantsFailure {}

class MockGetChatParticipantsUseCase extends Mock implements GetChatParticipantsUseCase {}

class MockGetChatMembersUseCase extends Mock implements GetChatMembersUseCase {}

class MockGetUploadChatAttachmentUseCase extends Mock implements GetUploadChatAttachmentUseCase {}

class MockSaveAttachmentUseCase extends Mock implements SaveAttachmentUseCase {}

class MockGetSingleChatRecipientUseCase extends Mock implements GetSingleChatRecipientUseCase {}

class MockDeleteMessageUseCase extends Mock implements DeleteMessageUseCase {}

class MockGetUnreadChatsFailure extends Mock implements GetUnreadChatsFailure {}

class MockGetUnreadChatsUseCase extends Mock implements GetUnreadChatsUseCase {}

class MockUpdateUsersToMentionByUserUseCase extends Mock implements UpdateUsersToMentionByUserUseCase {}

class MockUpdateContentByMentionUseCase extends Mock implements UpdateContentByMentionUseCase {}

class MockUpdateUsersToMentionByMentionsUseCase extends Mock implements UpdateUsersToMentionByMentionsUseCase {}

class MockMarkMessageAsReadFailure extends Mock implements MarkMessageAsReadFailure {}

class MockMarkMessageAsReadUseCase extends Mock implements MarkMessageAsReadUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockChatRepository extends Mock implements ChatRepository {}

class MockChatSettingsRepository extends Mock implements ChatSettingsRepository {}

class MockLiveEventsRepository extends Mock implements LiveEventsRepository {}

class MockChatDeeplinkRoutingPresenter extends MockCubit<ChatDeeplinkRoutingViewModel>
    implements ChatDeeplinkRoutingPresenter {}

class MockChatDeeplinkRoutingPresentationModel extends Mock implements ChatDeeplinkRoutingPresentationModel {}

class MockChatDeeplinkRoutingInitialParams extends Mock implements ChatDeeplinkRoutingInitialParams {}

class MockChatDeeplinkRoutingNavigator extends Mock implements ChatDeeplinkRoutingNavigator {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

// OTHERS
// ignore: strict_raw_type
class MockCentrifugeClient extends Mock implements CentrifugeClient {}

class MockLiveChatsPresenter extends Mock implements LiveChatsPresenter {}

class MockGetChatMessagesProvider extends Mock {
  List<ChatMessage>? call({required Id chatId});
}

class MockOnChatMessagesUpdatedCallback extends Mock {
  void call({required Id chatId, required List<ChatMessage> chatMessages});
}
