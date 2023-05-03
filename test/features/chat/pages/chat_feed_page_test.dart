import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_initial_params.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_navigator.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_page.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_feed/chat_feed_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late ChatFeedPage page;
  late ChatFeedInitialParams initParams;
  late ChatFeedPresentationModel model;
  late ChatFeedPresenter presenter;
  late ChatFeedNavigator navigator;

  late final chatExcerpts = [
    Stubs.chatExcerpt,
    Stubs.chatExcerpt.copyWith(name: "123"),
  ];

  final disabledChatExcerpt = Stubs.chatExcerpt.copyWith(circle: Stubs.circleWithDisabledChat);

  void _initMvp({bool chatEnabled = true}) {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initParams = const ChatFeedInitialParams();
    model = ChatFeedPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = ChatFeedNavigator(Mocks.appNavigator);

    when(
      () => ChatMocks.getChatFeedsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: chatEnabled ? chatExcerpts : [disabledChatExcerpt, ...chatExcerpts],
          pageInfo: const PageInfo.singlePage(),
        ),
      ),
    );

    when(
      () => ChatMocks.liveChatsPresenter.onInit(
        getChatMessagesProvider: any(named: 'getChatMessagesProvider'),
        onChatMessagesUpdatedCallback: any(named: 'onChatMessagesUpdatedCallback'),
      ),
    ).thenAnswer((_) => Future.value());

    when(
      () => ChatMocks.liveChatsPresenter.subscribeToChannels(
        chatIds: any(named: 'chatIds'),
      ),
    ).thenAnswer((_) => Future.value());

    when(() => ChatMocks.liveChatsPresenter.dispose()).thenAnswer((_) => Future.value());

    presenter = ChatFeedPresenter(
      model,
      navigator,
      ChatMocks.getChatFeedsUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      ChatMocks.liveChatsPresenter,
    );
    page = ChatFeedPage(presenter: presenter);
  }

  await screenshotTest(
    "chat_feed_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "chat_feed_page_chat_disabled",
    setUp: () async {
      _initMvp(chatEnabled: false);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ChatFeedPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
