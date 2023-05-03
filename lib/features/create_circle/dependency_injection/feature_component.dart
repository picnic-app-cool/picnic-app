import 'package:picnic_app/dependency_injection/app_component.dart';
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_navigator.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_page.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presentation_model.dart";
import "package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_presenter.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_initial_params.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_navigator.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_page.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presentation_model.dart";
import "package:picnic_app/features/create_circle/circle_creation_success/circle_creation_success_presenter.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_navigator.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_page.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_presentation_model.dart";
import "package:picnic_app/features/create_circle/create_circle/create_circle_presenter.dart";
import 'package:picnic_app/features/create_circle/data/graphql_circle_creation_repository.dart';
import 'package:picnic_app/features/create_circle/domain/repositories/circle_creation_repository.dart';
import "package:picnic_app/features/create_circle/domain/use_cases/create_circle_use_case.dart";
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_navigator.dart";
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_page.dart";
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_presentation_model.dart";
import "package:picnic_app/features/create_circle/rule_selection/rule_selection_presenter.dart";
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

//ignore: long-method
void _configureGeneralDependencies() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<CircleCreationRepository>(
          () => GraphqlCircleCreationRepository(
            getIt(),
          ),
        )

//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<CreateCircleUseCase>(
          () => CreateCircleUseCase(
            getIt(),
          ),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<CreateCircleNavigator>(
          () => CreateCircleNavigator(getIt()),
        )
        ..registerFactoryParam<CreateCirclePresentationModel, CreateCircleInitialParams, dynamic>(
          (params, _) => CreateCirclePresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<CreateCirclePresenter, CreateCircleInitialParams, dynamic>(
          (initialParams, _) => CreateCirclePresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<CreateCirclePage, CreateCircleInitialParams, dynamic>(
          (initialParams, _) => CreateCirclePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CircleCreationRulesNavigator>(
          () => CircleCreationRulesNavigator(getIt()),
        )
        ..registerFactoryParam<CircleCreationRulesPresentationModel, CircleCreationRulesInitialParams, dynamic>(
          (params, _) => CircleCreationRulesPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<CircleCreationRulesPresenter, CircleCreationRulesInitialParams, dynamic>(
          (initialParams, _) => CircleCreationRulesPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleCreationRulesPage, CircleCreationRulesInitialParams, dynamic>(
          (initialParams, _) => CircleCreationRulesPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CircleCreationSuccessNavigator>(
          () => CircleCreationSuccessNavigator(getIt()),
        )
        ..registerFactoryParam<CircleCreationSuccessPresentationModel, CircleCreationSuccessInitialParams, dynamic>(
          (params, _) => CircleCreationSuccessPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleCreationSuccessPresenter, CircleCreationSuccessInitialParams, dynamic>(
          (initialParams, _) => CircleCreationSuccessPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleCreationSuccessPage, CircleCreationSuccessInitialParams, dynamic>(
          (initialParams, _) => CircleCreationSuccessPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<RuleSelectionNavigator>(
          () => RuleSelectionNavigator(getIt()),
        )
        ..registerFactoryParam<RuleSelectionPresentationModel, RuleSelectionInitialParams, dynamic>(
          (params, _) => RuleSelectionPresentationModel.initial(params),
        )
        ..registerFactoryParam<RuleSelectionPresenter, RuleSelectionInitialParams, dynamic>(
          (initialParams, _) => RuleSelectionPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<RuleSelectionPage, RuleSelectionInitialParams, dynamic>(
          (initialParams, _) => RuleSelectionPage(
            presenter: getIt(param1: initialParams),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG
      ;
}
