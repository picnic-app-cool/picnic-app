import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_initial_params.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_navigator.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_page.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presentation_model.dart';
import 'package:picnic_app/features/circles/add_circle_pod/add_circle_pod_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late AddCirclePodPage page;
  late AddCirclePodInitialParams initParams;
  late AddCirclePodPresentationModel model;
  late AddCirclePodPresenter presenter;
  late AddCirclePodNavigator navigator;

  void initMvp() {
    initParams = AddCirclePodInitialParams(podId: Stubs.id);
    model = AddCirclePodPresentationModel.initial(
      initParams,
    );
    navigator = AddCirclePodNavigator(Mocks.appNavigator);
    presenter = AddCirclePodPresenter(
      model,
      navigator,
      Mocks.getPostCreationCirclesUseCase,
      Mocks.debouncer,
    );

    getIt.registerFactoryParam<AddCirclePodPresenter, AddCirclePodInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = AddCirclePodPage(initialParams: initParams);
    final enabledCirclesList = List.generate(
      20,
      (index) => Stubs.circle.copyWith(name: "Gatcha $index"),
    );

    when(
      () => Mocks.getPostCreationCirclesUseCase.execute(
        searchQuery: any(named: "searchQuery"),
      ),
    ).thenAnswer(
      (_) => successFuture(
        PaginatedList.singlePage(
          enabledCirclesList,
        ),
      ),
    );
  }

  await screenshotTest(
    "add_circle_pod_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
