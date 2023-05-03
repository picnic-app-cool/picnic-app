import 'package:picnic_app/core/data/centrifuge/centrifuge_repository.dart';
import 'package:picnic_app/core/domain/repositories/live_events_repository.dart';
import 'package:picnic_app/core/domain/use_cases/upload_attachment_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/video_thumbnail_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_initial_params.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_navigator.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_page.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presentation_model.dart';
import 'package:picnic_app/features/chat/add_members_list/add_members_list_presenter.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_initial_params.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_navigator.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_page.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_presenter.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_initial_params.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_navigator.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_page.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presenter.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_initial_params.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_navigator.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_page.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presenter.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_navigator.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presenter.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_initial_params.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_navigator.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_page.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presenter.dart';
import "package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_page.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_presentation_model.dart";
import "package:picnic_app/features/chat/circle_chat/circle_chat_presenter.dart";
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_bottom_sheet.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_navigator.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat_settings/circle_chat_settings_presenter.dart';
import 'package:picnic_app/features/chat/data/graphql_chat_repository.dart';
import 'package:picnic_app/features/chat/data/graphql_chat_settings_repository.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_bottom_sheet.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_initial_params.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_navigator.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_presentation_model.dart';
import 'package:picnic_app/features/chat/delete_multipe_messages/delete_multiple_messages_presenter.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
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
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_page.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presentation_model.dart';
import 'package:picnic_app/features/chat/fullscreen_attachment/fullscreen_attachment_presenter.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_page.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presenter.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_navigator.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_page.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presenter.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_initial_params.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_navigator.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_page.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presentation_model.dart';
import 'package:picnic_app/features/chat/message_actions/message_actions_presenter.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_page.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presentation_model.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presenter.dart';
import 'package:picnic_app/features/chat/settings/single_chat_settings.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_page.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presenter.dart';
import 'package:picnic_app/features/chat/utils/live_chats_presenter.dart';
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

//ignore: long-method
void _configureGeneralDependencies() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<ChatRepository>(
          () => GraphqlChatRepository(
            getIt(),
          ),
        )
        ..registerFactory<ChatSettingsRepository>(
          () => GraphqlChatSettingsRepository(
            getIt(),
          ),
        )
        ..registerLazySingleton<LiveEventsRepository>(
          () => CentrifugeRepository(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
      //DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG

      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<GetFriendsUseCase>(
          () => const GetFriendsUseCase(),
        )
        ..registerFactory<SendChatMessageUseCase>(
          () => SendChatMessageUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUploadChatAttachmentUseCase>(
          () => GetUploadChatAttachmentUseCase(),
        )
        ..registerFactory<SaveAttachmentUseCase>(
          () => SaveAttachmentUseCase(
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<DeleteMessageUseCase>(
          () => DeleteMessageUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetChatsUseCase>(
          () => GetChatsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCircleChatsUseCase>(
          () => GetCircleChatsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetChatFeedsUseCase>(
          () => GetChatFeedsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetMessagesInChatUseCase>(
          () => GetMessagesInChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<LeaveChatUseCase>(
          () => LeaveChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<PrepareChatLiveDataClientUseCase>(
          () => PrepareChatLiveDataClientUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetSingleChatMessageUseCase>(
          () => GetSingleChatMessageUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetChatSettingsUseCase>(
          () => GetChatSettingsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<InviteUsersToChatUseCase>(
          () => InviteUsersToChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<AddUserToChatUseCase>(
          () => AddUserToChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RemoveUserFromChatUseCase>(
          () => RemoveUserFromChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UpdateChatSettingsUseCase>(
          () => UpdateChatSettingsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UpdateChatNameUseCase>(
          () => UpdateChatNameUseCase(
            getIt(),
          ),
        )
        ..registerFactory<ReactOnChatMessageUseCase>(
          () => ReactOnChatMessageUseCase(
            getIt(),
          ),
        )
        ..registerFactory<JoinChatUseCase>(
          () => JoinChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetChatUseCase>(
          () => GetChatUseCase(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CreateGroupChatUseCase>(
          () => CreateGroupChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<CreateSingleChatUseCase>(
          () => CreateSingleChatUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetChatParticipantsUseCase>(
          () => GetChatParticipantsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetChatMembersUseCase>(
          () => GetChatMembersUseCase(
            getIt(),
          ),
        )
        ..registerFactory<UploadAttachmentUseCase>(
          () => UploadAttachmentUseCase(
            getIt(),
          ),
        )
        ..registerFactory<VideoThumbnailUseCase>(
          () => VideoThumbnailUseCase(
            getIt(),
          ),
        )
        ..registerFactoryParam<ChatMessagesUseCase, BasicChat, dynamic>(
          (chat, _) => ChatMessagesUseCase(
            chat,
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<GetSingleChatRecipientUseCase>(
          () => GetSingleChatRecipientUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<UpdateUsersToMentionByUserUseCase>(
          () => const UpdateUsersToMentionByUserUseCase(),
        )
        ..registerFactory<UpdateContentByMentionUseCase>(
          () => const UpdateContentByMentionUseCase(),
        )
        ..registerFactory<UpdateUsersToMentionByMentionsUseCase>(
          () => const UpdateUsersToMentionByMentionsUseCase(),
        )
        ..registerFactory<GetUnreadChatsUseCase>(
          () => GetUnreadChatsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<MarkMessageAsReadUseCase>(
          () => MarkMessageAsReadUseCase(getIt()),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG

      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<ChatTabsNavigator>(
          () => ChatTabsNavigator(getIt()),
        )
        ..registerFactoryParam<ChatTabsPresentationModel, ChatTabsInitialParams, dynamic>(
          (params, _) => ChatTabsPresentationModel.initial(params),
        )
        ..registerFactoryParam<ChatTabsPresenter, ChatTabsInitialParams, dynamic>(
          (initialParams, _) => ChatTabsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ChatTabsPage, ChatTabsInitialParams, dynamic>(
          (initialParams, _) => ChatTabsPage(
            presenter: getIt(param1: initialParams),
            chatFeedPage: getIt<ChatFeedPage>(param1: const ChatFeedInitialParams()),
            chatDmsPage: getIt<ChatDmsPage>(param1: const ChatDmsInitialParams()),
          ),
        )
        ..registerFactory<LiveChatsPresenter>(
          () => LiveChatsPresenter(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<ChatFeedNavigator>(
          () => ChatFeedNavigator(getIt()),
        )
        ..registerFactoryParam<ChatFeedViewModel, ChatFeedInitialParams, dynamic>(
          (params, _) => ChatFeedPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<ChatFeedPresenter, ChatFeedInitialParams, dynamic>(
          (initialParams, _) => ChatFeedPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ChatFeedPage, ChatFeedInitialParams, dynamic>(
          (initialParams, _) => ChatFeedPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<ChatMyCirclesNavigator>(
          () => ChatMyCirclesNavigator(getIt()),
        )
        ..registerFactoryParam<ChatMyCirclesViewModel, ChatMyCirclesInitialParams, dynamic>(
          (params, _) => ChatMyCirclesPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<ChatMyCirclesPresenter, ChatMyCirclesInitialParams, dynamic>(
          (initialParams, _) => ChatMyCirclesPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<ChatDmsNavigator>(
          () => ChatDmsNavigator(getIt()),
        )
        ..registerFactoryParam<ChatDmsViewModel, ChatDmsInitialParams, dynamic>(
          (params, _) => ChatDmsPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<ChatDmsPresenter, ChatDmsInitialParams, dynamic>(
          (initialParams, _) => ChatDmsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ChatDmsPage, ChatDmsInitialParams, dynamic>(
          (initialParams, _) => ChatDmsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<NewMessageNavigator>(
          () => NewMessageNavigator(getIt()),
        )
        ..registerFactoryParam<NewMessagePresentationModel, NewMessageInitialParams, dynamic>(
          (params, _) => NewMessagePresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<NewMessagePresenter, NewMessageInitialParams, dynamic>(
          (initialParams, _) => NewMessagePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(param1: initialParams.toMediaPickerInitialParams()),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<NewMessagePage, NewMessageInitialParams, dynamic>(
          (initialParams, _) => NewMessagePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<SingleChatNavigator>(
          () => SingleChatNavigator(getIt()),
        )
        ..registerFactoryParam<SingleChatViewModel, SingleChatInitialParams, dynamic>(
          (params, _) => SingleChatPresentationModel.initial(
            params,
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SingleChatPresenter, SingleChatInitialParams, dynamic>(
          (initialParams, _) => SingleChatPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(param1: initialParams.toMediaPickerInitialParams()),
            getIt(),
            getIt(),
            getIt(),
            getIt<ChatMessagesUseCase>(param1: initialParams.chat),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SingleChatPage, SingleChatInitialParams, dynamic>(
          (initialParams, _) => SingleChatPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<GroupChatNavigator>(
          () => GroupChatNavigator(getIt()),
        )
        ..registerFactoryParam<GroupChatViewModel, GroupChatInitialParams, dynamic>(
          (params, _) => GroupChatPresentationModel.initial(
            params,
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<GroupChatPresenter, GroupChatInitialParams, dynamic>(
          (initialParams, _) => GroupChatPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(param1: initialParams.toMediaPickerInitialParams()),
            getIt(),
            getIt(),
            getIt(),
            getIt<ChatMessagesUseCase>(param1: initialParams.chat),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<GroupChatPage, GroupChatInitialParams, dynamic>(
          (initialParams, _) => GroupChatPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<GroupChatMoreNavigator>(
          () => GroupChatMoreNavigator(getIt()),
        )
        ..registerFactoryParam<GroupChatMoreViewModel, GroupChatMoreInitialParams, dynamic>(
          (params, _) => GroupChatMorePresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<GroupChatMorePresenter, GroupChatMoreInitialParams, dynamic>(
          (initialParams, _) => GroupChatMorePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<GroupChatMorePage, GroupChatMoreInitialParams, dynamic>(
          (initialParams, _) => GroupChatMorePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<MessageActionsNavigator>(
          () => MessageActionsNavigator(
            getIt(),
          ),
        )
        ..registerFactoryParam<MessageActionsViewModel, MessageActionsInitialParams, dynamic>(
          (params, _) => MessageActionsPresentationModel.initial(params),
        )
        ..registerFactoryParam<MessageActionsPresenter, MessageActionsInitialParams, dynamic>(
          (initialParams, _) => MessageActionsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<MessageActionsPage, MessageActionsInitialParams, dynamic>(
          (initialParams, _) => MessageActionsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<AddMembersListNavigator>(
          () => AddMembersListNavigator(getIt()),
        )
        ..registerFactoryParam<AddMembersListViewModel, AddMembersListInitialParams, dynamic>(
          (params, _) => AddMembersListPresentationModel.initial(params),
        )
        ..registerFactoryParam<AddMembersListPresenter, AddMembersListInitialParams, dynamic>(
          (initialParams, _) => AddMembersListPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<AddMembersListPage, AddMembersListInitialParams, dynamic>(
          (initialParams, _) => AddMembersListPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CircleChatSettingsNavigator>(
          () => CircleChatSettingsNavigator(getIt()),
        )
        ..registerFactoryParam<CircleChatSettingsViewModel, CircleChatSettingsInitialParams, dynamic>(
          (params, _) => CircleChatSettingsPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<CircleChatSettingsPresenter, CircleChatSettingsInitialParams, dynamic>(
          (params, _) => CircleChatSettingsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleChatSettingsBottomSheet, CircleChatSettingsInitialParams, dynamic>(
          (params, _) => CircleChatSettingsBottomSheet(presenter: getIt(param1: params)),
        )
        ..registerFactory<FullscreenAttachmentNavigator>(
          () => FullscreenAttachmentNavigator(getIt()),
        )
        ..registerFactoryParam<FullscreenAttachmentViewModel, FullscreenAttachmentInitialParams, dynamic>(
          (params, _) => FullscreenAttachmentPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<FullscreenAttachmentPresenter, FullscreenAttachmentInitialParams, dynamic>(
          (params, _) => FullscreenAttachmentPresenter(
            getIt(param1: params),
            getIt(),
          ),
        )
        ..registerFactoryParam<FullscreenAttachmentPage, FullscreenAttachmentInitialParams, dynamic>(
          (params, _) => FullscreenAttachmentPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<CircleChatNavigator>(
          () => CircleChatNavigator(getIt()),
        )
        ..registerFactoryParam<CircleChatPresentationModel, CircleChatInitialParams, dynamic>(
          (params, _) => CircleChatPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleChatPresenter, CircleChatInitialParams, dynamic>(
          (initialParams, _) => CircleChatPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(param1: initialParams.toMediaPickerInitialParams()),
            getIt(),
            getIt(),
            getIt(),
            getIt<ChatMessagesUseCase>(param1: initialParams.chat.toBasicChat()),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleChatPage, CircleChatInitialParams, dynamic>(
          (params, _) => CircleChatPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<SingleChatSettingsNavigator>(
          () => SingleChatSettingsNavigator(getIt()),
        )
        ..registerFactoryParam<SingleChatSettingsViewModel, SingleChatSettingsInitialParams, dynamic>(
          (params, _) => SingleChatSettingsPresentationModel.initial(params),
        )
        ..registerFactoryParam<SingleChatSettingsPresenter, SingleChatSettingsInitialParams, dynamic>(
          (params, _) => SingleChatSettingsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SingleChatSettingsPage, SingleChatSettingsInitialParams, dynamic>(
          (params, _) => SingleChatSettingsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<ChatDeeplinkRoutingNavigator>(
          () => ChatDeeplinkRoutingNavigator(getIt()),
        )
        ..registerFactoryParam<ChatDeeplinkRoutingViewModel, ChatDeeplinkRoutingInitialParams, dynamic>(
          (params, _) => ChatDeeplinkRoutingPresentationModel.initial(params),
        )
        ..registerFactoryParam<ChatDeeplinkRoutingPresenter, ChatDeeplinkRoutingInitialParams, dynamic>(
          (params, _) => ChatDeeplinkRoutingPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ChatDeeplinkRoutingPage, ChatDeeplinkRoutingInitialParams, dynamic>(
          (params, _) => ChatDeeplinkRoutingPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<DeleteMultipleMessagesNavigator>(
          () => DeleteMultipleMessagesNavigator(getIt()),
        )
        ..registerFactoryParam<DeleteMultipleMessagesViewModel, DeleteMultipleMessagesInitialParams, dynamic>(
          (params, _) => DeleteMultipleMessagesPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<DeleteMultipleMessagesPresenter, DeleteMultipleMessagesInitialParams, dynamic>(
          (params, _) => DeleteMultipleMessagesPresenter(
            getIt(param1: params),
            getIt(),
          ),
        )
        ..registerFactoryParam<DeleteMultipleMessagesBottomSheet, DeleteMultipleMessagesInitialParams, dynamic>(
          (params, _) => DeleteMultipleMessagesBottomSheet(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
}
