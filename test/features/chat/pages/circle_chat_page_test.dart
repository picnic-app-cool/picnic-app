import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_navigator.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_page.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presentation_model.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_presenter.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../../in_app_notifications/mocks/in_app_notifications_mocks.dart';
import '../../media_picker/mocks/media_picker_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late CircleChatPage page;
  late CircleChatInitialParams initParams;
  late CircleChatPresentationModel model;
  late CircleChatPresenter presenter;
  late CircleChatNavigator navigator;

  void _initMvp({bool chatDisabled = false}) {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 10, 26));
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    initParams = CircleChatInitialParams(chat: chatDisabled ? Stubs.disabledChat : Stubs.chatWithCircle);
    model = CircleChatPresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.currentTimeProvider,
    );
    navigator = CircleChatNavigator(Mocks.appNavigator);

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

    presenter = CircleChatPresenter(
      model,
      navigator,
      mediaPickerPresenter,
      ChatMocks.saveAttachmentUseCase,
      Mocks.requestRuntimePermissionUseCase,
      Mocks.appInfoStore,
      ChatMocks.chatMessagesUseCase,
      CirclesMocks.banUserUseCase,
      InAppNotificationsMocks.addInAppNotificationsFilterUseCase,
      InAppNotificationsMocks.removeInAppNotificationsFilterUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
    page = CircleChatPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_chat_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_chat_page_with_pending_message",
    setUp: () async {
      _initMvp();
      presenter.onMessageTextUpdated('test');
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "circle_chat_page_with_chat_disabled",
    setUp: () async {
      _initMvp(chatDisabled: true);
      presenter.onMessageTextUpdated('test');
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CircleChatPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
