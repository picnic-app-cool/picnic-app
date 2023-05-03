import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/basic_chat.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_initial_params.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_navigator.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_page.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presentation_model.dart';
import 'package:picnic_app/features/chat/group_chat_more/group_chat_more_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late GroupChatMorePage page;
  late GroupChatMoreInitialParams initParams;
  late GroupChatMorePresentationModel model;
  late GroupChatMorePresenter presenter;
  late GroupChatMoreNavigator navigator;

  void _initMvp() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    initParams = const GroupChatMoreInitialParams(chat: BasicChat.empty());
    model = GroupChatMorePresentationModel.initial(
      initParams,
      Mocks.featureFlagsStore,
      Mocks.userStore,
    );
    navigator = GroupChatMoreNavigator(Mocks.appNavigator);

    when(
      () => ChatMocks.getChatSettingsUseCase.execute(
        chatId: any(named: "chatId"),
      ),
    ).thenAnswer((_) => successFuture(Stubs.chatSettings));
    when(
      () => ChatMocks.getChatMembersUseCase.execute(
        chatId: any(named: "chatId"),
        nextPageCursor: any(named: "nextPageCursor"),
      ),
    ).thenAnswer((_) => successFuture(Stubs.chatMembers));

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
    page = GroupChatMorePage(presenter: presenter);
  }

  await screenshotTest(
    "group_chat_more_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    _initMvp();
    final page = getIt<GroupChatMorePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
