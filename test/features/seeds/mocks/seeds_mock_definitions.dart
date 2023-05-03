import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_navigator.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presentation_model.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_presenter.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_navigator.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presentation_model.dart';
import 'package:picnic_app/features/seeds/circle_election/circle_election_presenter.dart';
import "package:picnic_app/features/seeds/domain/model/get_election_candidates_failure.dart";
import "package:picnic_app/features/seeds/domain/model/get_election_failure.dart";
import "package:picnic_app/features/seeds/domain/model/get_seedholders_failure.dart";
import "package:picnic_app/features/seeds/domain/model/get_seeds_failure.dart";
import 'package:picnic_app/features/seeds/domain/model/get_user_seeds_total_failure.dart';
import "package:picnic_app/features/seeds/domain/model/sell_seeds_failure.dart";
import 'package:picnic_app/features/seeds/domain/model/transfer_seeds_failure.dart';
import "package:picnic_app/features/seeds/domain/model/vote_director_failure.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_election_candidates_use_case.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_election_use_case.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_seed_holders_use_case.dart";
import "package:picnic_app/features/seeds/domain/use_cases/get_seeds_use_case.dart";
import 'package:picnic_app/features/seeds/domain/use_cases/get_user_seeds_total_use_case.dart';
import "package:picnic_app/features/seeds/domain/use_cases/sell_seeds_use_case.dart";
import 'package:picnic_app/features/seeds/domain/use_cases/transfer_seeds_use_case.dart';
import "package:picnic_app/features/seeds/domain/use_cases/vote_director_use_case.dart";
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_navigator.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_holders/seed_holders_presenter.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_navigator.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presenter.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_navigator.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/seeds/seeds_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_navigator.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_first_step/sell_seeds_first_step_presenter.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presentation_model.dart';
import 'package:picnic_app/features/seeds/sell_seeds_second_step/sell_seeds_second_step_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockSellSeedsFirstStepPresenter extends MockCubit<SellSeedsFirstStepViewModel>
    implements SellSeedsFirstStepPresenter {}

class MockSellSeedsFirstStepPresentationModel extends Mock implements SellSeedsFirstStepPresentationModel {}

class MockSellSeedsFirstStepInitialParams extends Mock implements SellSeedsFirstStepInitialParams {}

class MockSellSeedsSecondStepPresenter extends MockCubit<SellSeedsSecondStepViewModel>
    implements SellSeedsSecondStepPresenter {}

class MockSellSeedsSecondStepPresentationModel extends Mock implements SellSeedsSecondStepPresentationModel {}

class MockSellSeedsSecondStepInitialParams extends Mock implements SellSeedsSecondStepInitialParams {}

class MockSellSeedsPresenter extends MockCubit<SellSeedsViewModel> implements SellSeedsPresenter {}

class MockSellSeedsPresentationModel extends Mock implements SellSeedsPresentationModel {}

class MockSellSeedsInitialParams extends Mock implements SellSeedsInitialParams {}

class MockSellSeedsNavigator extends Mock implements SellSeedsNavigator {}

class MockSeedsPresenter extends MockCubit<SeedsViewModel> implements SeedsPresenter {}

class MockSeedsPresentationModel extends Mock implements SeedsPresentationModel {}

class MockSeedsInitialParams extends Mock implements SeedsInitialParams {}

class MockSeedsNavigator extends Mock implements SeedsNavigator {}

class MockSeedHoldersPresenter extends MockCubit<SeedHoldersViewModel> implements SeedHoldersPresenter {}

class MockSeedHoldersPresentationModel extends Mock implements SeedHoldersPresentationModel {}

class MockSeedHoldersInitialParams extends Mock implements SeedHoldersInitialParams {}

class MockSeedHoldersNavigator extends Mock implements SeedHoldersNavigator {}

class MockCircleElectionPresenter extends MockCubit<CircleElectionViewModel> implements CircleElectionPresenter {}

class MockCircleElectionPresentationModel extends Mock implements CircleElectionPresentationModel {}

class MockCircleElectionInitialParams extends Mock implements CircleElectionInitialParams {}

class MockCircleElectionNavigator extends Mock implements CircleElectionNavigator {}

class MockSeedRecipientsPresenter extends MockCubit<SeedRecipientsViewModel> implements SeedRecipientsPresenter {}

class MockSeedRecipientsPresentationModel extends Mock implements SeedRecipientsPresentationModel {}

class MockSeedRecipientsInitialParams extends Mock implements SeedRecipientsInitialParams {}

class MockSeedRecipientsNavigator extends Mock implements SeedRecipientsNavigator {}

class MockAboutElectionsPresenter extends MockCubit<AboutElectionsViewModel> implements AboutElectionsPresenter {}

class MockAboutElectionsPresentationModel extends Mock implements AboutElectionsPresentationModel {}

class MockAboutElectionsInitialParams extends Mock implements AboutElectionsInitialParams {}

class MockAboutElectionsNavigator extends Mock implements AboutElectionsNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetSeedsFailure extends Mock implements GetSeedsFailure {}

class MockGetSeedsUseCase extends Mock implements GetSeedsUseCase {}

class MockSellSeedsFailure extends Mock implements SellSeedsFailure {}

class MockSellSeedsUseCase extends Mock implements SellSeedsUseCase {}

class MockVoteDirectorFailure extends Mock implements VoteDirectorFailure {}

class MockVoteDirectorUseCase extends Mock implements VoteDirectorUseCase {}

class MockGetElectionCandidatesFailure extends Mock implements GetElectionCandidatesFailure {}

class MockGetElectionCandidatesUseCase extends Mock implements GetElectionCandidatesUseCase {}

class MockGetElectionFailure extends Mock implements GetElectionFailure {}

class MockGetElectionUseCase extends Mock implements GetElectionUseCase {}

class MockGetSeedholdersFailure extends Mock implements GetSeedHoldersFailure {}

class MockGetSeedholdersUseCase extends Mock implements GetSeedHoldersUseCase {}

class MockTransferSeedsFailure extends Mock implements TransferSeedsFailure {}

class MockTransferSeedsUseCase extends Mock implements TransferSeedsUseCase {}

class MockGetUserSeedsTotaFailure extends Mock implements GetUserSeedsTotalFailure {}

class MockGetUserSeedsTotaUseCase extends Mock implements GetUserSeedsTotalUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
