import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/pods_categories_initial_params.dart';
import 'package:picnic_app/features/pods/pods_categories_navigator.dart';
import 'package:picnic_app/features/pods/pods_categories_page.dart';
import 'package:picnic_app/features/pods/pods_categories_presentation_model.dart';
import 'package:picnic_app/features/pods/pods_categories_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/pods_mocks.dart';

Future<void> main() async {
  late PodsCategoriesPage page;
  late PodsCategoriesInitialParams initParams;
  late PodsCategoriesPresentationModel model;
  late PodsCategoriesNavigator navigator;
  late PodsCategoriesPresenter presenter;

  void initMvp() {
    initParams = const PodsCategoriesInitialParams();

    when(
      () => PodsMocks.getPodsTagsUseCase.execute(podsIdsList: []),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

    when(
      () => Mocks.searchPodsUseCase.execute(input: any(named: "input")),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));

    model = PodsCategoriesPresentationModel.initial(initParams);
    navigator = PodsCategoriesNavigator(Mocks.appNavigator);
    presenter = PodsCategoriesPresenter(
      model,
      navigator,
      PodsMocks.getPodsTagsUseCase,
      Mocks.searchPodsUseCase,
    );
    getIt.registerFactoryParam<PodsCategoriesPresenter, PodsCategoriesInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = PodsCategoriesPage(initialParams: initParams);
  }

  await screenshotTest(
    "pods_categories_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
