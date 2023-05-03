import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_navigator.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_presenter.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_initial_params.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_navigator.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presentation_model.dart';
import 'package:picnic_app/features/discover/discover_search_results/discover_search_results_presenter.dart';
import "package:picnic_app/features/discover/domain/model/discover_failure.dart";
import 'package:picnic_app/features/discover/domain/repositories/discover_repository.dart';
import "package:picnic_app/features/discover/domain/use_cases/discover_use_case.dart";

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockDiscoverSearchResultsPresenter extends MockCubit<DiscoverSearchResultsViewModel>
    implements DiscoverSearchResultsPresenter {}

class MockDiscoverSearchResultsPresentationModel extends Mock implements DiscoverSearchResultsPresentationModel {}

class MockDiscoverSearchResultsInitialParams extends Mock implements DiscoverSearchResultsInitialParams {}

class MockDiscoverSearchResultsNavigator extends Mock implements DiscoverSearchResultsNavigator {}

class MockDiscoverExplorePresenter extends MockCubit<DiscoverExploreViewModel> implements DiscoverExplorePresenter {}

class MockDiscoverExplorePresentationModel extends Mock implements DiscoverExplorePresentationModel {}

class MockDiscoverExploreInitialParams extends Mock implements DiscoverExploreInitialParams {}

class MockDiscoverExploreNavigator extends Mock implements DiscoverExploreNavigator {}
//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockDiscoverFailure extends Mock implements DiscoverFailure {}

class MockDiscoverUseCase extends Mock implements DiscoverUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockDiscoverRepository extends Mock implements DiscoverRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
