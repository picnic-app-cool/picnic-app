import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_navigator.dart';
import 'package:picnic_app/features/chat/new_message/new_message_page.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presentation_model.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presenter.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../media_picker/mocks/media_picker_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late NewMessagePage page;
  late NewMessageInitialParams initParams;
  late NewMessagePresentationModel model;
  late NewMessagePresenter presenter;
  late NewMessageNavigator navigator;

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(
      () => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")),
    ).thenAnswer(
      (_) => successFuture(Stubs.basicChat),
    );

    when(
      () => ChatMocks.createGroupChatUseCase.execute(name: any(named: "name"), userIds: any(named: "userIds")),
    ).thenAnswer(
      (_) => successFuture(Stubs.basicChat),
    );
    initParams = const NewMessageInitialParams();
    model = NewMessagePresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = NewMessageNavigator(Mocks.appNavigator);

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

    presenter = NewMessagePresenter(
      model,
      navigator,
      mediaPickerPresenter,
      Mocks.searchUsersUseCase,
      Mocks.debouncer,
      ChatMocks.createGroupChatUseCase,
      ChatMocks.createSingleChatUseCase,
      ChatMocks.sendChatMessageUseCase,
      Mocks.uploadAttachmentUseCase,
      ChatMocks.getUploadChatAttachmentUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.userStore,
    );
    page = NewMessagePage(presenter: presenter);
    when(
      () => Mocks.searchUsersUseCase.execute(
        query: any(named: 'query'),
        nextPageCursor: any(named: 'nextPageCursor'),
        ignoreMyself: any(named: 'ignoreMyself'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.singlePage(),
          items: [
            Stubs.publicProfile,
            Stubs.publicProfile2,
          ],
        ),
      ),
    );
  }

  await screenshotTest(
    "new_message_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "new_message_page_ready_to_send",
    setUp: () async {
      _initMvp();
      presenter.onTapAddRecipient(Stubs.user);
      presenter.onMessageTextUpdated('test');
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<NewMessagePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
