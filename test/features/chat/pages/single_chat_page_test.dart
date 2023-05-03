import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_initial_params.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_navigator.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_page.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/single_chat/single_chat_presenter.dart';
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
  late SingleChatPage page;
  late SingleChatInitialParams initParams;
  late SingleChatPresentationModel model;
  late SingleChatPresenter presenter;
  late SingleChatNavigator navigator;

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 10, 26));
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    whenListen(
      Mocks.userStore,
      Stream.fromIterable([const PrivateProfile.empty()]),
    );
    initParams = const SingleChatInitialParams(
      chat: BasicChat.empty(),
    );
    model = SingleChatPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
      Mocks.currentTimeProvider,
    );
    navigator = SingleChatNavigator(Mocks.appNavigator);

    when(
      () => ChatMocks.chatMessagesUseCase.execute(
        action: any(named: "action"),
      ),
    ).thenAnswer(
      (_) => successFuture(Stubs.displayableMessagesStream),
    );
    when(
      () => ChatMocks.getChatParticipantsUseCase
          .execute(chatId: any(named: "chatId"), nextPageCursor: any(named: "nextPageCursor")),
    ).thenAnswer(
      (_) => successFuture(
        const PaginatedList<User>.empty().copyWith(items: [Stubs.user, Stubs.user2]),
      ),
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

    presenter = SingleChatPresenter(
      model,
      navigator,
      mediaPickerPresenter,
      ChatMocks.saveAttachmentUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
      ChatMocks.chatMessagesUseCase,
      ChatMocks.getChatParticipantsUseCase,
      InAppNotificationsMocks.addInAppNotificationsFilterUseCase,
      InAppNotificationsMocks.removeInAppNotificationsFilterUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.unreadCountersStore,
    );
    page = SingleChatPage(presenter: presenter);
  }

  await screenshotTest(
    "single_chat_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "single_chat_page_with_pending_message",
    setUp: () async {
      _initMvp();
      presenter.onMessageTextUpdated('test');
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SingleChatPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
