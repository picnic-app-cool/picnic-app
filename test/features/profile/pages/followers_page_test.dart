import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_page.dart';
import 'package:picnic_app/features/profile/followers/followers_presentation_model.dart';
import 'package:picnic_app/features/profile/followers/followers_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late FollowersPage page;
  late FollowersInitialParams initParams;
  late FollowersPresentationModel model;
  late FollowersPresenter presenter;
  late FollowersNavigator navigator;
  const id = Id.empty();

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    initParams = const FollowersInitialParams();
    model = FollowersPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = FollowersNavigator(Mocks.appNavigator, Mocks.userStore);

    presenter = FollowersPresenter(
      model,
      navigator,
      ProfileMocks.getFollowersUseCase,
      Mocks.followUserUseCase,
      Mocks.debouncer,
    );

    page = FollowersPage(presenter: presenter);
    when(
      () => ProfileMocks.getFollowersUseCase.execute(
        userId: id,
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.empty(),
          items: [
            Stubs.publicProfile,
            Stubs.publicProfile.copyWith(user: Stubs.user2),
            Stubs.publicProfile.copyWith(user: Stubs.user2, iFollow: true),
          ],
        ),
      ),
    );
  }

  await screenshotTest(
    "followers_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<FollowersPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
