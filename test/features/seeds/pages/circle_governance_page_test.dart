import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_navigator.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_page.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/seeds_mocks.dart';

Future<void> main() async {
  late CircleGovernancePage page;
  late CircleGovernanceInitialParams initParams;
  late CircleGovernancePresentationModel model;
  late CircleGovernancePresenter presenter;
  late CircleGovernanceNavigator navigator;

  void initMvp() {
    when(() => SeedsMocks.getGovernanceUseCase.execute(circleId: Stubs.circle.id))
        .thenAnswer((_) => successFuture(Stubs.election));
    initParams = CircleGovernanceInitialParams(circle: Stubs.circle);
    model = CircleGovernancePresentationModel.initial(
      initParams,
    );
    navigator = CircleGovernanceNavigator(
      Mocks.appNavigator,
      Mocks.userStore,
    );
    presenter = CircleGovernancePresenter(
      model,
      SeedsMocks.getGovernanceUseCase,
      CirclesMocks.getCircleDetailsUseCase,
      navigator,
    );

    getIt.registerFactoryParam<CircleGovernancePresenter, CircleGovernanceInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = CircleGovernancePage(initialParams: initParams);
  }

  await screenshotTest(
    "circle_governance_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
