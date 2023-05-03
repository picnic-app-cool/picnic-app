import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/discover_mock_definitions.dart';

void main() {
  late DiscoverSearchResultsPresentationModel model;
  late DiscoverSearchResultsPresenter presenter;
  late MockDiscoverSearchResultsNavigator navigator;

  test(
    'tapping on follow toggle should follow a user',
    () async {
      fakeAsync((async) {
        // GIVEN
        final user = Stubs.publicProfile.copyWith(iFollow: false);
        when(() => presenter.onTapFollowButton(user)).thenAnswer(
          (_) => successFuture(unit),
        );
        when(() => Mocks.followUserUseCase.execute(userId: user.id, follow: true)).thenAnswer(
          (_) => successFuture(unit),
        );

        // WHEN
        presenter.onTapFollowButton(user);
        async.flushMicrotasks();

        // THEN
        verify(() => Mocks.followUserUseCase.execute(userId: user.id, follow: true)).called(1);
        expect(presenter.state.users.firstWhere((element) => element.id == user.id).iFollow, true);
      });
    },
  );

  test(
    'tapping on follow toggle should unfollow a user',
    () async {
      fakeAsync((async) {
        // GIVEN
        final user = Stubs.publicProfile2.copyWith(iFollow: true);
        when(() => presenter.onTapFollowButton(user)).thenAnswer(
          (_) => successFuture(unit),
        );
        when(() => Mocks.followUserUseCase.execute(userId: user.id, follow: false)).thenAnswer(
          (_) => successFuture(unit),
        );

        // WHEN
        presenter.onTapFollowButton(user);
        async.flushMicrotasks();

        // THEN
        verify(() => Mocks.followUserUseCase.execute(userId: user.id, follow: false)).called(1);
        expect(presenter.state.users.firstWhere((element) => element.id == user.id).iFollow, false);
      });
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = DiscoverSearchResultsPresentationModel.initial(
      const DiscoverSearchResultsInitialParams(),
      Mocks.featureFlagsStore,
    );
    navigator = MockDiscoverSearchResultsNavigator();
    model = DiscoverSearchResultsPresentationModel.initial(
      const DiscoverSearchResultsInitialParams(),
      Mocks.featureFlagsStore,
    ).copyWith(
      users: PaginatedList(
        pageInfo: const PageInfo.empty(),
        items: [
          Stubs.publicProfile,
          Stubs.publicProfile.copyWith(user: Stubs.user2, iFollow: true),
        ],
      ),
    );
    presenter = DiscoverSearchResultsPresenter(
      model,
      navigator,
      Mocks.searchUsersUseCase,
      Mocks.getCirclesUseCase,
      Mocks.joinCircleUseCase,
      Mocks.followUserUseCase,
      Mocks.debouncer,
    );
  });
}
