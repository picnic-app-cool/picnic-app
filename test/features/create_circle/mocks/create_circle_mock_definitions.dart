import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presentation_model.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presenter.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presentation_model.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presenter.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_presentation_model.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_presenter.dart";
import "package:picnic_app/features/create_circle/domain/model/create_circle_failure.dart";
import 'package:picnic_app/features/create_circle/domain/repositories/circle_creation_repository.dart';
import "package:picnic_app/features/create_circle/domain/use_cases/create_circle_use_case.dart";
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_navigator.dart";
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart";
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_presenter.dart";
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockCreateCircleNavigator extends Mock implements CreateCircleNavigator {}

class MockCreateCirclePresentationModel extends Mock implements CreateCirclePresentationModel {}

class MockCreateCirclePresenter extends MockCubit<CreateCircleViewModel> implements CreateCirclePresenter {}

class MockCreateCircleInitialParams extends Mock implements CreateCircleInitialParams {}

class MockCircleCreationRulesNavigator extends Mock implements CircleCreationRulesNavigator {}

class MockCircleCreationRulesPresentationModel extends Mock implements CircleCreationRulesPresentationModel {}

class MockCircleCreationRulesPresenter extends MockCubit<CircleCreationRulesViewModel>
    implements CircleCreationRulesPresenter {}

class MockCircleCreationRulesInitialParams extends Mock implements CircleCreationRulesInitialParams {}

class MockCircleCreationSuccessNavigator extends Mock implements CircleCreationSuccessNavigator {}

class MockCircleCreationSuccessPresentationModel extends Mock implements CircleCreationSuccessPresentationModel {}

class MockCircleCreationSuccessPresenter extends MockCubit<CircleCreationSuccessViewModel>
    implements CircleCreationSuccessPresenter {}

class MockCircleCreationSuccessInitialParams extends Mock implements CircleCreationSuccessInitialParams {}

class MockRuleSelectionNavigator extends Mock implements RuleSelectionNavigator {}

class MockRuleSelectionPresentationModel extends Mock implements RuleSelectionPresentationModel {}

class MockRuleSelectionPresenter extends MockCubit<RuleSelectionViewModel> implements RuleSelectionPresenter {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockCreateCircleFailure extends Mock implements CreateCircleFailure {}

class MockCreateCircleUseCase extends Mock implements CreateCircleUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockCircleCreationRepository extends Mock implements CircleCreationRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
