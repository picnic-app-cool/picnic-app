import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late ChatDeeplinkRoutingPage page;
  late ChatDeeplinkRoutingInitialParams initParams;
  late ChatDeeplinkRoutingPresentationModel model;
  late ChatDeeplinkRoutingPresenter presenter;
  late ChatDeeplinkRoutingNavigator navigator;

  void initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    when(() => ChatMocks.getChatUseCase.execute(chatId: const Id.empty())).thenAnswer(
      (_) => successFuture(
        const Chat.empty().copyWith(
          participants: PaginatedList.singlePage(
            [
              Mocks.userStore.privateProfile.user,
              const User.empty(),
            ],
          ),
        ),
      ),
    );
    when(
      () => Mocks.appNavigator.pushReplacement<void>(
        any(),
        context: any(named: "context"),
        useRoot: any(named: "useRoot"),
      ),
    ).thenAnswer((invocation) => Future.value());

    initParams = const ChatDeeplinkRoutingInitialParams(Id.empty());
    model = ChatDeeplinkRoutingPresentationModel.initial(
      initParams,
    );
    navigator = ChatDeeplinkRoutingNavigator(Mocks.appNavigator);
    presenter = ChatDeeplinkRoutingPresenter(
      model,
      navigator,
      ChatMocks.getChatUseCase,
    );
    page = ChatDeeplinkRoutingPage(presenter: presenter);
  }

  await screenshotTest(
    "chat_deeplink_routing_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<ChatDeeplinkRoutingPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
