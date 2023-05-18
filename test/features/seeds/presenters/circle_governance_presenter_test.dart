import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presenter.dart';

import '../../../mocks/stubs.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/seeds_mock_definitions.dart';
import '../mocks/seeds_mocks.dart';

void main() {
  late CircleGovernancePresentationModel model;
  late CircleGovernancePresenter presenter;
  late MockCircleGovernanceNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = CircleGovernancePresentationModel.initial(CircleGovernanceInitialParams(circle: Stubs.circle));
    navigator = MockCircleGovernanceNavigator();
    presenter = CircleGovernancePresenter(
      model,
      SeedsMocks.getGovernanceUseCase,
      CirclesMocks.getCircleDetailsUseCase,
      navigator,
    );
  });
}
