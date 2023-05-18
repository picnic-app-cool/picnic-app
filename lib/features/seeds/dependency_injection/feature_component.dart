import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_page.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presentation_model.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presenter.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_page.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presenter.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_navigator.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_presenter.dart';
import "package:picnic_app/features/seeds/domain/use_cases/get_election_candidates_use_case.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_governance_use_case.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_seed_holders_use_case.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_seeds_use_case.dart";
import 'package:picnic_app/features/seeds/domain/use_cases/get_user_seeds_total_use_case.dart';
import "package:picnic_app/features/seeds/domain/use_cases/sell_seeds_use_case.dart";
import 'package:picnic_app/features/seeds/domain/use_cases/transfer_seeds_use_case.dart';
import "package:picnic_app/features/seeds/domain/use_cases/vote_director_use_case.dart";
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_navigator.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_page.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presenter.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_navigator.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_page.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presenter.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_page.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_page.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presenter.dart';

//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

const _sellSeedsNavigationKey = "sell_seeds_navigation_key";

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
        ..registerFactory<GetSeedsUseCase>(
          () => GetSeedsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SellSeedsUseCase>(
          () => SellSeedsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<VoteDirectorUseCase>(
          () => VoteDirectorUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetElectionCandidatesUseCase>(
          () => GetElectionCandidatesUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetGovernanceUseCase>(
          () => GetGovernanceUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetSeedHoldersUseCase>(
          () => GetSeedHoldersUseCase(
            getIt(),
          ),
        )
        ..registerFactory<TransferSeedsUseCase>(
          () => TransferSeedsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserSeedsTotalUseCase>(
          () => GetUserSeedsTotalUseCase(
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
        ..registerFactoryParam<SellSeedsFirstStepPresentationModel, SellSeedsFirstStepInitialParams, dynamic>(
          (params, _) => SellSeedsFirstStepPresentationModel.initial(params),
        )
        ..registerFactoryParam<SellSeedsFirstStepPresenter, SellSeedsFirstStepInitialParams, dynamic>(
          (initialParams, _) => SellSeedsFirstStepPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SellSeedsFirstStepPage, SellSeedsFirstStepInitialParams, dynamic>(
          (initialParams, _) => SellSeedsFirstStepPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactoryParam<SellSeedsSecondStepPresentationModel, SellSeedsSecondStepInitialParams, dynamic>(
          (params, _) => SellSeedsSecondStepPresentationModel.initial(params),
        )
        ..registerFactoryParam<SellSeedsSecondStepPresenter, SellSeedsSecondStepInitialParams, dynamic>(
          (initialParams, _) => SellSeedsSecondStepPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SellSeedsSecondStepPage, SellSeedsSecondStepInitialParams, dynamic>(
          (initialParams, _) => SellSeedsSecondStepPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<SellSeedsNavigator>(
          () => SellSeedsNavigator(
            getIt(),
            getIt(instanceName: _sellSeedsNavigationKey),
          ),
        )
        ..registerFactoryParam<SellSeedsPresentationModel, SellSeedsInitialParams, dynamic>(
          (params, _) => SellSeedsPresentationModel.initial(params),
        )
        ..registerFactoryParam<SellSeedsPresenter, SellSeedsInitialParams, dynamic>(
          (initialParams, _) => SellSeedsPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<SellSeedsPage, SellSeedsInitialParams, dynamic>(
          (initialParams, _) => SellSeedsPage(
            presenter: getIt(param1: initialParams),
            navigatorKey: getIt(instanceName: _sellSeedsNavigationKey),
          ),
        )
        ..registerLazySingleton<SellSeedsNavigatorKey>(
          () => SellSeedsNavigatorKey(),
          instanceName: _sellSeedsNavigationKey,
        )
        ..registerFactory<SeedsNavigator>(
          () => SeedsNavigator(getIt()),
        )
        ..registerFactoryParam<SeedsPresentationModel, SeedsInitialParams, dynamic>(
          (params, _) => SeedsPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<SeedsPresenter, SeedsInitialParams, dynamic>(
          (initialParams, _) => SeedsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SeedsPage, SeedsInitialParams, dynamic>(
          (initialParams, _) => SeedsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<SeedHoldersNavigator>(
          () => SeedHoldersNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<SeedHoldersPresentationModel, SeedHoldersInitialParams, dynamic>(
          (params, _) => SeedHoldersPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<SeedHoldersPresenter, SeedHoldersInitialParams, dynamic>(
          (initialParams, _) => SeedHoldersPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SeedHoldersPage, SeedHoldersInitialParams, dynamic>(
          (initialParams, _) => SeedHoldersPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CircleElectionNavigator>(
          () => CircleElectionNavigator(getIt()),
        )
        ..registerFactoryParam<CircleElectionPresentationModel, CircleElectionInitialParams, dynamic>(
          (params, _) => CircleElectionPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleElectionPresenter, CircleElectionInitialParams, dynamic>(
          (initialParams, _) => CircleElectionPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleElectionPage, CircleElectionInitialParams, dynamic>(
          (initialParams, _) => CircleElectionPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<SeedRecipientsNavigator>(
          () => SeedRecipientsNavigator(getIt()),
        )
        ..registerFactoryParam<SeedRecipientsViewModel, SeedRecipientsInitialParams, dynamic>(
          (params, _) => SeedRecipientsPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<SeedRecipientsPresenter, SeedRecipientsInitialParams, dynamic>(
          (params, _) => SeedRecipientsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SeedRecipientsPage, SeedRecipientsInitialParams, dynamic>(
          (params, _) => SeedRecipientsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<AboutElectionsNavigator>(
          () => AboutElectionsNavigator(getIt()),
        )
        ..registerFactoryParam<AboutElectionsViewModel, AboutElectionsInitialParams, dynamic>(
          (params, _) => AboutElectionsPresentationModel.initial(params),
        )
        ..registerFactoryParam<AboutElectionsPresenter, AboutElectionsInitialParams, dynamic>(
          (params, _) => AboutElectionsPresenter(getIt(param1: params), getIt()),
        )
        ..registerFactoryParam<AboutElectionsPage, AboutElectionsInitialParams, dynamic>(
          (params, _) => AboutElectionsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<CircleGovernanceNavigator>(
          () => CircleGovernanceNavigator(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CircleGovernanceViewModel, CircleGovernanceInitialParams, dynamic>(
          (params, _) => CircleGovernancePresentationModel.initial(params),
        )
        ..registerFactoryParam<CircleGovernancePresenter, CircleGovernanceInitialParams, dynamic>(
          (params, _) => CircleGovernancePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
