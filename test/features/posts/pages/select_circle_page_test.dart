import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_navigator.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_page.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presentation_model.dart';
import 'package:picnic_app/features/posts/select_circle/select_circle_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

Future<void> main() async {
  late SelectCirclePage page;
  late SelectCircleInitialParams initParams;
  late SelectCirclePresentationModel model;
  late SelectCirclePresenter presenter;
  late SelectCircleNavigator navigator;

  void _initMvp({bool postingDisabled = false}) {
    initParams = SelectCircleInitialParams(
      createPostInput: Stubs.createTextPostInput,
    );
    model = SelectCirclePresentationModel.initial(
      initParams,
    );
    navigator = SelectCircleNavigator(Mocks.appNavigator);
    presenter = SelectCirclePresenter(
      model,
      navigator,
      Mocks.getPostCreationCirclesUseCase,
      PostsMocks.createPostUseCase,
      Mocks.debouncer,
    );
    page = SelectCirclePage(presenter: presenter);
    final enabledCirclesList = List.generate(
      20,
      (index) => Stubs.circle.copyWith(name: "Gatcha $index"),
    );
    final disabledCirclesList = List.generate(
      4,
      (index) => Stubs.circleWithDisabledTextPosting.copyWith(name: "Gatcha $index"),
    );
    when(
      () => Mocks.getPostCreationCirclesUseCase.execute(
        searchQuery: any(named: "searchQuery"),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          postingDisabled ? disabledCirclesList + enabledCirclesList : enabledCirclesList,
        ),
      ),
    );
  }

  await screenshotTest(
    "select_circle_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  await screenshotTest(
    "select_circle_page_with_disabled_posting",
    setUp: () async {
      _initMvp(postingDisabled: true);
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SelectCirclePage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
