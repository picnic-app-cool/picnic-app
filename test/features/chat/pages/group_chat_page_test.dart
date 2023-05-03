import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/chat_message.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_navigator.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_page.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat/group_chat_presenter.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../in_app_notifications/mocks/in_app_notifications_mocks.dart';
import '../../media_picker/mocks/media_picker_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late GroupChatPage page;
  late GroupChatInitialParams initParams;
  late GroupChatPresentationModel model;
  late GroupChatPresenter presenter;
  late GroupChatNavigator navigator;

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 12, 12));
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => ChatMocks.getChatMembersUseCase.execute(
        chatId: any(named: 'chatId'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((_) => successFuture(Stubs.chatMembers));
    initParams = GroupChatInitialParams.fromNewMessage(
      chat: Stubs.basicChat,
      chatMessage: const ChatMessage.empty(),
    );
    model = GroupChatPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
    navigator = GroupChatNavigator(Mocks.appNavigator);

    when(
      () => ChatMocks.chatMessagesUseCase.execute(
        action: any(named: "action"),
      ),
    ).thenAnswer(
      (_) => successFuture(Stubs.displayableMessagesStream),
    );

    final mediaPickerPresenter = MediaPickerPresenter(
      MediaPickerPresentationModel.initial(const MediaPickerInitialParams()),
      MediaPickerMocks.imageVideoPickerNavigator,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.videoThumbnailUseCase,
      Mocks.getAttachmentsUseCase,
      ChatMocks.getUploadChatAttachmentUseCase,
      Mocks.openNativeAppSettingsUseCase,
      Mocks.appInfoStore,
    );
    when(
      () => Mocks.mentionUserUseCase.execute(
        query: any(named: 'query'),
        notifyMeta: const NotifyMeta.chat(),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

    presenter = GroupChatPresenter(
      model,
      navigator,
      mediaPickerPresenter,
      ChatMocks.saveAttachmentUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
      ChatMocks.chatMessagesUseCase,
      ChatMocks.getChatMembersUseCase,
      InAppNotificationsMocks.addInAppNotificationsFilterUseCase,
      InAppNotificationsMocks.removeInAppNotificationsFilterUseCase,
      Mocks.mentionUserUseCase,
      ChatMocks.updateUsersToMentionByUserUseCase,
      ChatMocks.updateContentByMentionUseCase,
      ChatMocks.updateUsersToMentionByMentionsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.unreadCountersStore,
    );

    page = GroupChatPage(presenter: presenter);
  }

  await screenshotTest(
    "group_chat_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "group_chat_page_with_pending_message",
    setUp: () async {
      _initMvp();
      presenter.onMessageTextUpdated('test');
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<GroupChatPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
