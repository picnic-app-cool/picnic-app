import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_navigator.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_page.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/feed_mocks.dart';

Future<void> main() async {
  late FeedMorePage page;
  late FeedMoreInitialParams initParams;
  late FeedMorePresentationModel model;
  late FeedMorePresenter presenter;
  late FeedMoreNavigator navigator;

  void initMvp() {
    initParams = const FeedMoreInitialParams(
      initialFeedsPageId: Id.none(),
    );
    model = FeedMorePresentationModel.initial(
      initParams,
    );
    navigator = FeedMoreNavigator(Mocks.appNavigator);
    presenter = FeedMorePresenter(
      model,
      navigator,
      FeedMocks.getFeedsListUseCase,
      FeedMocks.localFeedsStore,
    );
    page = FeedMorePage(presenter: presenter);
  }

  await screenshotTest(
    "feed_more_page",
    setUp: () async {
      initMvp();
      when(() => FeedMocks.getFeedsListUseCase.execute(nextPageCursor: any(named: 'nextPageCursor')))
          .thenAnswer((_) => successCacheableResult(Stubs.feedList));
      when(() => FeedMocks.localFeedsStore.feeds).thenReturn(Stubs.unmodifiableFeedList);
      when(() => FeedMocks.localFeedsStore.stream).thenAnswer((_) => Stubs.feedStream);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<FeedMorePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
