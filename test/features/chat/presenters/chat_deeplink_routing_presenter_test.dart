import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_initial_params.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_deep_link_routing/chat_deeplink_routing_presenter.dart';
import 'package:picnic_app/features/chat/domain/model/chat.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mock_definitions.dart';
import '../mocks/chat_mocks.dart';

void main() {
  late ChatDeeplinkRoutingPresentationModel model;
  late ChatDeeplinkRoutingPresenter presenter;
  late MockChatDeeplinkRoutingNavigator navigator;
  late MockGetChatUseCase mockGetChatUseCase;
  const testChatId = Id('123');
  test(
    'presenter fetch chat and change state properly',
    () async {
      when(() => navigator.openSingleChat(any(), pushAsReplacement: true)).thenAnswer((_) => Future.value());
      when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
      when(
        () => mockGetChatUseCase.execute(
          chatId: testChatId,
        ),
      ).thenAnswer(
        (_) => successFuture(
          const Chat.empty().copyWith(
            id: testChatId,
            participants: PaginatedList.singlePage(
              [
                Stubs.user,
                Stubs.user2,
              ],
            ),
          ),
        ),
      );
      when(
        () => ChatMocks.getChatMembersUseCase.execute(
          chatId: any(named: 'chatId'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));
      when(
        () => navigator.showError(
          any(),
          onTapButton: any(named: 'onTapButton'),
        ),
      ).thenAnswer((_) => Future.value());
      await presenter.init();
    },
  );

  setUp(() {
    model = ChatDeeplinkRoutingPresentationModel.initial(const ChatDeeplinkRoutingInitialParams(testChatId));
    navigator = MockChatDeeplinkRoutingNavigator();
    mockGetChatUseCase = ChatMocks.getChatUseCase;
    presenter = ChatDeeplinkRoutingPresenter(
      model,
      navigator,
      mockGetChatUseCase,
    );
  });
}
