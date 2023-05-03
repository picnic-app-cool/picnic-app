import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
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
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_initial_params.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_navigator.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_page.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_tabs/chat_tabs_presenter.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late ChatTabsPage page;
  late ChatTabsInitialParams initParams;
  late ChatTabsPresentationModel model;
  late ChatTabsPresenter presenter;
  late ChatTabsNavigator navigator;

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8, 20));
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => Mocks.unreadCountersStore.unreadChats).thenReturn(List.empty());
    whenListen(Mocks.unreadCountersStore, Stream<List<UnreadChat>>.value(List.empty()));

    initParams = const ChatTabsInitialParams();
    model = ChatTabsPresentationModel.initial(
      initParams,
    );
    navigator = ChatTabsNavigator(Mocks.appNavigator);
    presenter = ChatTabsPresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
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

    page = ChatTabsPage(
      presenter: presenter,
      chatFeedPage: ChatFeedPage(
        presenter: ChatFeedPresenter(
          ChatFeedPresentationModel.initial(
            const ChatFeedInitialParams(),
            Mocks.userStore,
          ),
          ChatFeedNavigator(getIt()),
          ChatMocks.getChatFeedsUseCase,
          AnalyticsMocks.logAnalyticsEventUseCase,
          ChatMocks.liveChatsPresenter,
        ),
      ),
      chatDmsPage: ChatDmsPage(
        presenter: ChatDmsPresenter(
          ChatDmsPresentationModel.initial(
            const ChatDmsInitialParams(),
            Mocks.currentTimeProvider,
          ),
          ChatDmsNavigator(getIt()),
          ChatMocks.getChatsUseCase,
          ChatMocks.leaveChatUseCase,
          ChatMocks.getSingleChatRecipientUseCase,
          AnalyticsMocks.logAnalyticsEventUseCase,
          Mocks.userStore,
          Mocks.unreadCountersStore,
        ),
      ),
    );

    when(
      () => ChatMocks.getChatFeedsUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

    when(
      () => ChatMocks.getChatsUseCase.execute(
        searchQuery: any(named: 'searchQuery'),
        chatTypes: [ChatType.group, ChatType.single],
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((_) => successFuture(PaginatedList.singlePage([Stubs.basicChat])));

    when(
      () => Mocks.getUserCirclesUseCase.execute(
        userId: any(named: 'userId'),
        searchQuery: any(named: 'searchQuery'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (_) => successFuture(const PaginatedList.singlePage()),
    );
  }

  await screenshotTest(
    "chat_tabs_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ChatTabsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
