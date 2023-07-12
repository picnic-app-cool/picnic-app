import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/paginated_list_presenter/paginated_list_presentation_model.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_initial_params.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_navigator.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_page.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_dms/chat_dms_presenter.dart';
import 'package:picnic_app/features/chat/chat_dms/widgets/dms_list.dart';
import 'package:picnic_app/features/chat/chat_dms/widgets/empty_chats_container.dart';
import 'package:picnic_app/features/chat/domain/model/chat_list_item_displayable.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_extensions/widget_tester_extensions.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late ChatDmsPage page;
  late ChatDmsInitialParams initParams;
  late ChatDmsPresentationModel model;
  late ChatDmsPresenter presenter;
  late ChatDmsNavigator navigator;

  final listWithItems = PaginatedList(
    items: [Stubs.basicChat, Stubs.basicChat.copyWith(name: "daniel1234")],
    pageInfo: const PageInfo.singlePage(),
  );

  const emptyList = PaginatedList<ChatListItemDisplayable>(
    items: [],
    pageInfo: PageInfo.singlePage(),
  );

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 6, 11));
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    initParams = const ChatDmsInitialParams();
    model = ChatDmsPresentationModel.initial(
      initParams,
      Mocks.currentTimeProvider,
    );
    navigator = ChatDmsNavigator(Mocks.appNavigator);

    presenter = ChatDmsPresenter(
      model,
      navigator,
      ChatMocks.getChatsUseCase,
      ChatMocks.leaveChatUseCase,
      ChatMocks.getSingleChatRecipientUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.userStore,
      Mocks.unreadCountersStore,
    );
    page = ChatDmsPage(
      presenter: presenter,
    );

    when(
      () => ChatMocks.getChatsUseCase.execute(
        searchQuery: any(named: 'searchQuery'),
        chatTypes: [ChatType.group, ChatType.single],
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (_) => successFuture(listWithItems),
    );

    when(() => ChatMocks.leaveChatUseCase.execute(chatId: Stubs.chat.id)).thenAnswer(
      (_) => successFuture(unit),
    );
  }

  await screenshotTest(
    "chat_dms_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<ChatDmsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });

  testWidgets('shows chats when there are some chats', (tester) async {
    _initMvp();
    final page = getIt<ChatDmsPage>(param1: initParams);
    await tester.setupWidget(page);

    final presentationModel = model.copyWith(
      chats: PaginatedListPresentationModel<ChatListItemDisplayable>().copyWith(
        paginatedList: listWithItems.mapItems(
          (chat) => chat.toChatListItemDisplayable(Stubs.user.id),
        ),
      ),
    );
    page.presenter.emit(presentationModel);
    await tester.pumpAndSettle();

    final chats = find.byType(DmsList);

    expect(chats, findsOneWidget);
  });

  testWidgets('shows NO chats when there are NO chats', (tester) async {
    _initMvp();
    final page = getIt<ChatDmsPage>(param1: initParams);
    await tester.setupWidget(page);

    final presentationModel = model.copyWith(
      chats: PaginatedListPresentationModel<ChatListItemDisplayable>().copyWith(paginatedList: emptyList),
    );
    page.presenter.emit(presentationModel);
    await tester.pumpAndSettle();

    final noChats = find.byType(EmptyChatsContainer);

    expect(noChats, findsOneWidget);
  });
}
