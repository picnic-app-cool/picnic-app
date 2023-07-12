import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_page.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/posts_mock_definitions.dart';

Future<void> main() async {
  late PostSharePage page;
  late PostShareInitialParams initParams;
  late PostSharePresentationModel model;
  late MockPostShareNavigator navigator;
  late PostSharePresenter presenter;

  void initMvp() {
    initParams = PostShareInitialParams(
      post: Stubs.textPost,
    );
    model = PostSharePresentationModel.initial(
      initParams,
    );
    navigator = MockPostShareNavigator();
    presenter = PostSharePresenter(
      model,
      navigator,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.getRecommendedChatsUseCase,
      ChatMocks.sendChatMessageUseCase,
      Mocks.userStore,
    );
    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);
    when(() => Mocks.getRecommendedChatsUseCase.execute(input: any(named: 'input'))).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage([Stubs.chat]),
      ),
    );
    reRegister<PostSharePresenter>(presenter);
    page = PostSharePage(
      initialParams: initParams,
    );
  }

  await screenshotTest(
    "post_share_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
