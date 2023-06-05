import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../../feed/mocks/feed_mock_definitions.dart';
import '../../feed/mocks/feed_mocks.dart';
import '../../pods/mocks/pods_mocks.dart';
import '../mocks/discover_mock_definitions.dart';

void main() {
  late DiscoverExplorePresentationModel model;
  late DiscoverExplorePresenter presenter;
  late MockDiscoverExploreNavigator navigator;
  late MockDiscoverUseCase useCase;
  late MockGetPopularFeedUseCase popularFeedUseCase;
  test(
    'test is state changed',
    () async {
      when(() => useCase.execute()).thenAnswer((invocation) {
        return successFuture(<CircleGroup>[const CircleGroup.empty()]);
      });
      when(() => popularFeedUseCase.execute()).thenAnswer((invocation) {
        return successFuture(const PaginatedList<Post>.empty());
      });
      await presenter.init();
      final model = presenter.state;
      await popularFeedUseCase.execute();
      expect(model.feedGroups.isEmpty, false);
      expect(model.popularFeedPosts, isEmpty);
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = DiscoverExplorePresentationModel.initial(
      const DiscoverExploreInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockDiscoverExploreNavigator();
    useCase = MockDiscoverUseCase();
    popularFeedUseCase = FeedMocks.getPopularFeedUseCase;
    presenter = DiscoverExplorePresenter(
      model,
      navigator,
      useCase,
      popularFeedUseCase,
      CirclesMocks.getPodsUseCase,
      ChatMocks.getChatUseCase,
      PodsMocks.savePodUseCase,
      CirclesMocks.votePodsUseCase,
    );
  });
}
