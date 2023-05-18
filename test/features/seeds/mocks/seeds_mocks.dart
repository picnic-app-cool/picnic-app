import 'package:mocktail/mocktail.dart';

import 'seeds_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class SeedsMocks {
  // MVP

  static late MockSellSeedsFirstStepPresenter sellSeedsFirstStepPresenter;
  static late MockSellSeedsFirstStepPresentationModel sellSeedsFirstStepPresentationModel;
  static late MockSellSeedsFirstStepInitialParams sellSeedsFirstStepInitialParams;
  static late MockSellSeedsSecondStepPresenter sellSeedsSecondStepPresenter;
  static late MockSellSeedsSecondStepPresentationModel sellSeedsSecondStepPresentationModel;
  static late MockSellSeedsSecondStepInitialParams sellSeedsSecondStepInitialParams;
  static late MockSellSeedsPresenter sellSeedsPresenter;
  static late MockSellSeedsPresentationModel sellSeedsPresentationModel;
  static late MockSellSeedsInitialParams sellSeedsInitialParams;
  static late MockSellSeedsNavigator sellSeedsNavigator;
  static late MockSeedsPresenter seedsPresenter;
  static late MockSeedsPresentationModel seedsPresentationModel;
  static late MockSeedsInitialParams seedsInitialParams;
  static late MockSeedsNavigator seedsNavigator;
  static late MockSeedHoldersPresenter seedHoldersPresenter;
  static late MockSeedHoldersPresentationModel seedHoldersPresentationModel;
  static late MockSeedHoldersInitialParams seedHoldersInitialParams;
  static late MockSeedHoldersNavigator seedHoldersNavigator;
  static late MockCircleElectionPresenter circleElectionPresenter;
  static late MockCircleElectionPresentationModel circleElectionPresentationModel;
  static late MockCircleElectionInitialParams circleElectionInitialParams;
  static late MockCircleElectionNavigator circleElectionNavigator;
  static late MockSeedRecipientsPresenter seedRecipientsPresenter;
  static late MockSeedRecipientsPresentationModel seedRecipientsPresentationModel;
  static late MockSeedRecipientsInitialParams seedRecipientsInitialParams;
  static late MockSeedRecipientsNavigator seedRecipientsNavigator;

  static late MockAboutElectionsPresenter aboutElectionsPresenter;
  static late MockAboutElectionsPresentationModel aboutElectionsPresentationModel;
  static late MockAboutElectionsInitialParams aboutElectionsInitialParams;
  static late MockAboutElectionsNavigator aboutElectionsNavigator;

  static late MockCircleGovernancePresenter circleGovernancePresenter;
  static late MockCircleGovernancePresentationModel circleGovernancePresentationModel;
  static late MockCircleGovernanceInitialParams circleGovernanceInitialParams;
  static late MockCircleGovernanceNavigator circleGovernanceNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetSeedsFailure getSeedsFailure;
  static late MockGetSeedsUseCase getSeedsUseCase;

  static late MockSellSeedsFailure sellSeedsFailure;
  static late MockSellSeedsUseCase sellSeedsUseCase;

  static late MockVoteDirectorFailure voteDirectorFailure;
  static late MockVoteDirectorUseCase voteDirectorUseCase;

  static late MockGetElectionCandidatesFailure getElectionCandidatesFailure;
  static late MockGetElectionCandidatesUseCase getElectionCandidatesUseCase;

  static late MockGetElectionFailure getElectionFailure;
  static late MockGetGovernanceUseCase getGovernanceUseCase;

  static late MockGetSeedholdersFailure getSeedholdersFailure;
  static late MockGetSeedholdersUseCase getSeedholdersUseCase;

  static late MockTransferSeedsFailure transferSeedsFailure;
  static late MockTransferSeedsUseCase transferSeedsUseCase;

  static late MockGetUserSeedsTotaFailure getUserSeedsTotalFailure;
  static late MockGetUserSeedsTotaUseCase getUserSeedsTotalUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  //DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    sellSeedsFirstStepPresenter = MockSellSeedsFirstStepPresenter();
    sellSeedsFirstStepPresentationModel = MockSellSeedsFirstStepPresentationModel();
    sellSeedsFirstStepInitialParams = MockSellSeedsFirstStepInitialParams();
    sellSeedsSecondStepPresenter = MockSellSeedsSecondStepPresenter();
    sellSeedsSecondStepPresentationModel = MockSellSeedsSecondStepPresentationModel();
    sellSeedsSecondStepInitialParams = MockSellSeedsSecondStepInitialParams();
    sellSeedsPresenter = MockSellSeedsPresenter();
    sellSeedsPresentationModel = MockSellSeedsPresentationModel();
    sellSeedsInitialParams = MockSellSeedsInitialParams();
    sellSeedsNavigator = MockSellSeedsNavigator();
    seedsPresenter = MockSeedsPresenter();
    seedsPresentationModel = MockSeedsPresentationModel();
    seedsInitialParams = MockSeedsInitialParams();
    seedsNavigator = MockSeedsNavigator();
    seedHoldersPresenter = MockSeedHoldersPresenter();
    seedHoldersPresentationModel = MockSeedHoldersPresentationModel();
    seedHoldersInitialParams = MockSeedHoldersInitialParams();
    seedHoldersNavigator = MockSeedHoldersNavigator();
    circleElectionPresenter = MockCircleElectionPresenter();
    circleElectionPresentationModel = MockCircleElectionPresentationModel();
    circleElectionInitialParams = MockCircleElectionInitialParams();
    circleElectionNavigator = MockCircleElectionNavigator();
    seedRecipientsPresenter = MockSeedRecipientsPresenter();
    seedRecipientsPresentationModel = MockSeedRecipientsPresentationModel();
    seedRecipientsInitialParams = MockSeedRecipientsInitialParams();
    seedRecipientsNavigator = MockSeedRecipientsNavigator();

    aboutElectionsPresenter = MockAboutElectionsPresenter();
    aboutElectionsPresentationModel = MockAboutElectionsPresentationModel();
    aboutElectionsInitialParams = MockAboutElectionsInitialParams();
    aboutElectionsNavigator = MockAboutElectionsNavigator();

    circleGovernancePresenter = MockCircleGovernancePresenter();
    circleGovernancePresentationModel = MockCircleGovernancePresentationModel();
    circleGovernanceInitialParams = MockCircleGovernanceInitialParams();
    circleGovernanceNavigator = MockCircleGovernanceNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getSeedsFailure = MockGetSeedsFailure();
    getSeedsUseCase = MockGetSeedsUseCase();

    sellSeedsFailure = MockSellSeedsFailure();
    sellSeedsUseCase = MockSellSeedsUseCase();

    voteDirectorFailure = MockVoteDirectorFailure();
    voteDirectorUseCase = MockVoteDirectorUseCase();

    getElectionCandidatesFailure = MockGetElectionCandidatesFailure();
    getElectionCandidatesUseCase = MockGetElectionCandidatesUseCase();

    getElectionFailure = MockGetElectionFailure();
    getGovernanceUseCase = MockGetGovernanceUseCase();

    getSeedholdersFailure = MockGetSeedholdersFailure();
    getSeedholdersUseCase = MockGetSeedholdersUseCase();

    transferSeedsFailure = MockTransferSeedsFailure();
    transferSeedsUseCase = MockTransferSeedsUseCase();

    getUserSeedsTotalFailure = MockGetUserSeedsTotaFailure();
    getUserSeedsTotalUseCase = MockGetUserSeedsTotaUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    //DO-NOT-REMOVE STORES_INIT_MOCKS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockSellSeedsFirstStepPresenter());
    registerFallbackValue(MockSellSeedsFirstStepPresentationModel());
    registerFallbackValue(MockSellSeedsFirstStepInitialParams());
    registerFallbackValue(MockSellSeedsSecondStepPresenter());
    registerFallbackValue(MockSellSeedsSecondStepPresentationModel());
    registerFallbackValue(MockSellSeedsSecondStepInitialParams());
    registerFallbackValue(MockSellSeedsPresenter());
    registerFallbackValue(MockSellSeedsPresentationModel());
    registerFallbackValue(MockSellSeedsInitialParams());
    registerFallbackValue(MockSellSeedsNavigator());
    registerFallbackValue(MockSeedsPresenter());
    registerFallbackValue(MockSeedsPresentationModel());
    registerFallbackValue(MockSeedsInitialParams());
    registerFallbackValue(MockSeedsNavigator());
    registerFallbackValue(MockSeedHoldersPresenter());
    registerFallbackValue(MockSeedHoldersPresentationModel());
    registerFallbackValue(MockSeedHoldersInitialParams());
    registerFallbackValue(MockSeedHoldersNavigator());
    registerFallbackValue(MockCircleElectionPresenter());
    registerFallbackValue(MockCircleElectionPresentationModel());
    registerFallbackValue(MockCircleElectionInitialParams());
    registerFallbackValue(MockCircleElectionNavigator());
    registerFallbackValue(MockSeedRecipientsPresenter());
    registerFallbackValue(MockSeedRecipientsPresentationModel());
    registerFallbackValue(MockSeedRecipientsInitialParams());
    registerFallbackValue(MockSeedRecipientsNavigator());

    registerFallbackValue(MockAboutElectionsPresenter());
    registerFallbackValue(MockAboutElectionsPresentationModel());
    registerFallbackValue(MockAboutElectionsInitialParams());
    registerFallbackValue(MockAboutElectionsNavigator());

    registerFallbackValue(MockCircleGovernancePresenter());
    registerFallbackValue(MockCircleGovernancePresentationModel());
    registerFallbackValue(MockCircleGovernanceInitialParams());
    registerFallbackValue(MockCircleGovernanceNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetSeedsFailure());
    registerFallbackValue(MockGetSeedsUseCase());

    registerFallbackValue(MockSellSeedsFailure());
    registerFallbackValue(MockSellSeedsUseCase());

    registerFallbackValue(MockVoteDirectorFailure());
    registerFallbackValue(MockVoteDirectorUseCase());

    registerFallbackValue(MockGetElectionCandidatesFailure());
    registerFallbackValue(MockGetElectionCandidatesUseCase());

    registerFallbackValue(MockGetElectionFailure());
    registerFallbackValue(MockGetGovernanceUseCase());

    registerFallbackValue(MockGetSeedholdersFailure());
    registerFallbackValue(MockGetSeedholdersUseCase());

    registerFallbackValue(MockTransferSeedsFailure());
    registerFallbackValue(MockTransferSeedsUseCase());

    registerFallbackValue(MockGetUserSeedsTotaFailure());
    registerFallbackValue(MockGetUserSeedsTotaUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    //DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE
  }
}
