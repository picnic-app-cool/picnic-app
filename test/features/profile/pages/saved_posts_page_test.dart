import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_navigator.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_page.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presentation_model.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late SavedPostsPage page;
  late SavedPostsInitialParams initParams;
  late SavedPostsPresentationModel model;
  late SavedPostsPresenter presenter;
  late SavedPostsNavigator navigator;

  void _initMvp() {
    initParams = const SavedPostsInitialParams();
    model = SavedPostsPresentationModel.initial(
      initParams,
    );
    navigator = SavedPostsNavigator(Mocks.appNavigator);
    presenter = SavedPostsPresenter(
      model,
      navigator,
      ProfileMocks.getSavedPostsUseCase,
    );
    page = SavedPostsPage(presenter: presenter);

    when(
      () => ProfileMocks.getSavedPostsUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
  }

  await screenshotTest(
    "saved_posts_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SavedPostsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
