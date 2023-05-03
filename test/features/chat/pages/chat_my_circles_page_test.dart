import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_initial_params.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_navigator.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_page.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presentation_model.dart';
import 'package:picnic_app/features/chat/chat_my_circles/chat_my_circles_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/chat_mocks.dart';

Future<void> main() async {
  late ChatMyCirclesPage page;
  late ChatMyCirclesInitialParams initialParams;
  late ChatMyCirclesPresentationModel model;
  late ChatMyCirclesPresenter presenter;
  late ChatMyCirclesNavigator navigator;

  void _initMvp() {
    when(() => Mocks.currentTimeProvider.currentTime).thenReturn(DateTime(2022, 8, 16));
    initialParams = const ChatMyCirclesInitialParams();
    model = ChatMyCirclesPresentationModel.initial(initialParams, Mocks.currentTimeProvider);
    navigator = ChatMyCirclesNavigator(Mocks.appNavigator);
    presenter = ChatMyCirclesPresenter(
      model,
      navigator,
      ChatMocks.getCircleChatsUseCase,
      Mocks.debouncer,
    );
    getIt.registerFactoryParam<ChatMyCirclesPresenter, ChatMyCirclesInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = ChatMyCirclesPage(
      initialParams: initialParams,
    );

    when(
      () => ChatMocks.getCircleChatsUseCase.execute(
        searchQuery: any(named: 'searchQuery'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: [Stubs.chatWithCircle],
          pageInfo: const PageInfo.singlePage(),
        ),
      ),
    );
  }

  await screenshotTest(
    "chat_my_circles_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );
}
