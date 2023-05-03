import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/new_message/new_message_initial_params.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presentation_model.dart';
import 'package:picnic_app/features/chat/new_message/new_message_presenter.dart';
import 'package:picnic_app/features/media_picker/media_picker_initial_params.dart';
import 'package:picnic_app/features/media_picker/media_picker_presentation_model.dart';
import 'package:picnic_app/features/media_picker/media_picker_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../media_picker/mocks/media_picker_mocks.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late NewMessagePresentationModel model;
  late NewMessagePresenter presenter;
  late MockNewMessageNavigator navigator;

  test(
    'open single chat',
    () async {
      fakeAsync(
        (async) {
          // GIVEN
          when(
            () => ChatMocks.createSingleChatUseCase.execute(userIds: any(named: "userIds")),
          ).thenAnswer(
            (_) => successFuture(Stubs.basicChat),
          );

          // WHEN
          presenter.onTapAddRecipient(Stubs.user);
          presenter.onTapSendNewMassage();
          async.flushMicrotasks();

          // THEN
          verifyNever(
            () => ChatMocks.getMessagesInChatUseCase.execute(
              chatId: any(named: "chatId"),
              nextPageCursor: any(named: "nextPageCursor"),
            ),
          );
          verify(() => navigator.openSingleChat(any(), pushAsReplacement: true));
        },
      );
    },
  );

  test(
    'open group chat',
    () async {
      fakeAsync(
        (async) {
          // GIVEN

          when(
            () => ChatMocks.createGroupChatUseCase.execute(name: any(named: "name"), userIds: any(named: "userIds")),
          ).thenAnswer(
            (_) => successFuture(Stubs.basicChat),
          );

          when(
            () => ChatMocks.createGroupChatUseCase.execute(name: any(named: "name"), userIds: any(named: "userIds")),
          ).thenAnswer(
            (_) => successFuture(Stubs.basicChat),
          );
          // WHEN
          presenter.onTapAddRecipient(Stubs.user);
          presenter.onTapAddRecipient(Stubs.user2);
          presenter.onTapSendNewMassage();
          async.flushMicrotasks();

          // THEN
          verify(
            () => ChatMocks.createGroupChatUseCase.execute(
              name: any(named: "name"),
              userIds: any(named: "userIds"),
            ),
          );
          verify(() => navigator.openGroupChat(any(), pushAsReplacement: true));
        },
      );
    },
  );

  test(
    'Tapping on send should be disabled for messages having only text containing only spaces',
    () async {
      // WHEN
      presenter.onTapAddRecipient(Stubs.user);
      presenter.onMessageTextUpdated('     ');

      // THEN
      expect(presenter.state.sendMessageEnabled, false);
    },
  );

  test(
    'Tapping on send should be enabled for messages having any character different from space',
    () async {
      // WHEN
      presenter.onTapAddRecipient(Stubs.user);
      presenter.onMessageTextUpdated('   a   ');

      // THEN
      expect(presenter.state.sendMessageEnabled, true);
    },
  );

  test(
    'tapping on search input (and focusing on it) should change resizeToAvoidBottomInset to false',
    () async {
      // WHEN
      presenter.searchInputFocusChanged(hasFocus: true);

      // THEN
      expect(presenter.state.resizeToAvoidBottomInset, false);
    },
  );

  test(
    'tapping on group input (and focusing on it) should change resizeToAvoidBottomInset to false',
    () async {
      // WHEN
      presenter.groupInputFocusChanged(hasFocus: true);

      // THEN
      expect(presenter.state.resizeToAvoidBottomInset, false);
    },
  );

  test(
    'tapping on chat input (and focusing on it) should change resizeToAvoidBottomInset to true',
    () async {
      // WHEN
      presenter.chatInputFocusChanged(hasFocus: true);

      // THEN
      expect(presenter.state.resizeToAvoidBottomInset, true);
    },
  );

  test(
    'changing search text should use debouncer',
    () {
      // GIVEN
      when(
        () => Mocks.debouncer.debounce(const LongDuration(), any()),
      ).thenAnswer((_) => unit);

      // WHEN
      presenter.onChangedSearchText('some text');

      // THEN
      verify(
        () => Mocks.debouncer.debounce(const LongDuration(), any()),
      ).called(1);
    },
  );

  test(
    'should update group name',
    () async {
      // GIVEN
      const groupName = 'group name';

      // WHEN
      presenter.onGroupNameUpdated(groupName);

      // THEN
      expect(presenter.state.groupName, groupName);
    },
  );

  test(
    'should remove user from recipients list',
    () async {
      // GIVEN
      presenter.onTapAddRecipient(Stubs.user);
      expect(presenter.state.recipients.contains(Stubs.user), true);

      // WHEN
      presenter.onTapRemoveRecipient(Stubs.user);

      // THEN
      expect(presenter.state.recipients.contains(Stubs.user), false);
    },
  );

  test(
    'should udpate message text',
    () async {
      // GIVEN
      const someText = 'some text';

      // WHEN
      presenter.onMessageTextUpdated(someText);

      // THEN
      expect(presenter.state.newMessageText, someText);
    },
  );

  test(
    'loading more should call searchUsersUseCase execution',
    () async {
      // GIVEN
      when(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
          ignoreMyself: any(named: 'ignoreMyself'),
        ),
      ).thenAnswer(
        (_) => successFuture(PaginatedList.singlePage([Stubs.publicProfile])),
      );

      // WHEN
      await presenter.loadMoreUsers();

      // THEN
      verify(
        () => Mocks.searchUsersUseCase.execute(
          query: any(named: 'query'),
          nextPageCursor: any(named: 'nextPageCursor'),
          ignoreMyself: any(named: 'ignoreMyself'),
        ),
      ).called(1);
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    model = NewMessagePresentationModel.initial(
      const NewMessageInitialParams(),
      Mocks.userStore,
    );
    navigator = MockNewMessageNavigator();

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
    when(() => navigator.openSingleChat(any(), pushAsReplacement: true)).thenAnswer((invocation) {
      return Future.value();
    });
    when(() => navigator.openGroupChat(any(), pushAsReplacement: true)).thenAnswer((invocation) {
      return Future.value();
    });
    when(
      () => ChatMocks.sendChatMessageUseCase.execute(
        chatId: any(named: "chatId"),
        message: any(named: "message"),
      ),
    ).thenAnswer(
      (_) => successFuture(Stubs.chatMessage),
    );
  });
}
