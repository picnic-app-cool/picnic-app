import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/domain/model/group_chat_more_tab.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late GroupChatMorePresentationModel model;
  late GroupChatMorePresenter presenter;
  late MockGroupChatMoreNavigator navigator;

  test(
    'GroupChatMorePresenter test:',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  test('onInit test', () {
    presenter.onInit();
    expect(presenter.state.chatSettings, Stubs.chatSettings);
  });

  test('onTabChanged test', () {
    presenter.onTabChanged(GroupChatMoreTab.settings);
    expect(presenter.state.selectedTab, GroupChatMoreTab.settings);
    presenter.onTabChanged(GroupChatMoreTab.members);
    expect(presenter.state.selectedTab, GroupChatMoreTab.members);
  });

  test('onTapReport test', () async {
    when(() => navigator.openReportForm(any())).thenAnswer((_) => Future.value(true));
    await presenter.onTapReport();
    verify(() => navigator.close());
  });

  test('onTapAddMembers test', () {
    presenter.onTapAddMembers();
    verify(() => navigator.openAddMembersList(any()));
  });

  test('onTapLeave test', () {
    when(
      () => navigator.showConfirmationBottomSheet(
        title: any(named: "title"),
        message: any(named: "message"),
        primaryAction: any(named: "primaryAction"),
        secondaryAction: any(named: "secondaryAction"),
      ),
    ).thenAnswer(successFuture);
    presenter.onTapLeave();
    verify(
      () => navigator.showConfirmationBottomSheet(
        title: any(named: "title"),
        message: any(named: "message"),
        primaryAction: any(named: "primaryAction"),
        secondaryAction: any(named: "secondaryAction"),
      ),
    );
  });

  test('onTapUser test', () {
    presenter.onTapUser(Stubs.chatMember);
    verify(() => navigator.openPublicProfile(any()));
  });

  test(
    'onTapRemoveMember test',
    () {
      when(
        () => navigator.showRemoveMemberConfirmation(
          onTapRemove: any(named: "onTapRemove"),
          user: Stubs.user,
        ),
      ).thenAnswer(successFuture);
      presenter.onTapRemoveMember(Stubs.chatMember);
      verify(
        () => navigator.showRemoveMemberConfirmation(
          onTapRemove: any(named: "onTapRemove"),
          user: Stubs.user,
        ),
      );
    },
  );

  test('onGroupNameChanged test', () async {
    presenter.onGroupNameChanged("new name");
    scheduleMicrotask(() => expect(presenter.state.groupName, "new name"));
  });

  test('onSwitchNotificationChanged test', () {
    presenter.onSwitchNotificationChanged();
    expect(presenter.state.chatSettings.isMuted, false);
  });

  test('loadMoreMembers test', () async {
    when(
      () => ChatMocks.getChatMembersUseCase.execute(
        chatId: Stubs.id,
        nextPageCursor: any(named: "nextPageCursor"),
      ),
    ).thenAnswer(
      (_) => successFuture(Stubs.chatMembers),
    );

    await presenter.loadMoreMembers();

    expect(presenter.state.members, isNotEmpty);
  });

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    when(
      () => ChatMocks.getChatMembersUseCase.execute(
        chatId: Stubs.id,
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((_) => successFuture(Stubs.chatMembers));

    when(
      () => ChatMocks.getChatSettingsUseCase.execute(chatId: Stubs.id),
    ).thenAnswer((_) => successFuture(Stubs.chatSettings));

    when(
      () => ChatMocks.updateChatSettingsUseCase.execute(
        chatId: Stubs.id,
        chatSettings: Stubs.chatSettings,
      ),
    ).thenAnswer((_) => successFuture(unit));

    when(
      () => ChatMocks.updateChatNameUseCase.execute(
        chatId: Stubs.id,
        name: "new name",
      ),
    ).thenAnswer((_) => successFuture(unit));

    model = GroupChatMorePresentationModel.initial(
      const GroupChatMoreInitialParams(chat: BasicChat.empty()),
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );

    navigator = MockGroupChatMoreNavigator();

    when(
      () => navigator.openReportForm(any()),
    ).thenAnswer((_) async => true);

    when(
      () => navigator.openAddMembersList(any()),
    ).thenAnswer(successFuture);

    when(
      () => navigator.openPublicProfile(any()),
    ).thenAnswer(successFuture);

    when(() => Mocks.debouncer.debounce(const LongDuration(), any())).thenAnswer((invocation) {
      // ignore: avoid_dynamic_calls
      invocation.positionalArguments[1]();
    });

    presenter = GroupChatMorePresenter(
      model,
      navigator,
      ChatMocks.getChatMembersUseCase,
      ChatMocks.getChatSettingsUseCase,
      ChatMocks.updateChatSettingsUseCase,
      ChatMocks.updateChatNameUseCase,
      ChatMocks.addUserToChatUseCase,
      ChatMocks.removeUserFromChatUseCase,
      ChatMocks.leaveChatUseCase,
      Mocks.debouncer,
    );
  });
}
