import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/model/report_input.dart';

import 'reports_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class ReportsMocks {
  //DO-NOT-REMOVE STATIC_FIELD
  // MVP

  static late MockReportFormPresenter reportFormPresenter;
  static late MockReportFormPresentationModel reportFormPresentationModel;
  static late MockReportFormInitialParams reportFormInitialParams;
  static late MockReportFormNavigator reportFormNavigator;
  static late MockReportDetailsNavigator reportDetailsNavigator;
  static late MockReportReasonsPresenter reportReasonsPresenter;
  static late MockReportDetailsInitialParams reportDetailsInitialParams;
  static late MockReportReasonsPresentationModel reportReasonsPresentationModel;
  static late MockReportReasonsInitialParams reportReasonsInitialParams;
  static late MockReportReasonsNavigator reportReasonsNavigator;

  // USE CASES
  static late MockGetGlobalReportReasonsUseCase getGlobalReportReasonsUseCase;
  static late MockGetCircleReportReasonsUseCase getCircleReportReasonsUseCase;
  static late MockCreateGlobalReportUseCase createGlobalReportUseCase;
  static late MockCreateCircleReportUseCase createCircleReportUseCase;

  // FAILURES

  // REPOSITORIES
  static late MockReportsRepository reportsRepository;

  // OTHERS

  // STORES

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP

    reportFormPresenter = MockReportFormPresenter();
    reportFormPresentationModel = MockReportFormPresentationModel();
    reportFormInitialParams = MockReportFormInitialParams();
    reportFormNavigator = MockReportFormNavigator();
    reportReasonsPresenter = MockReportReasonsPresenter();
    reportReasonsPresentationModel = MockReportReasonsPresentationModel();
    reportReasonsInitialParams = MockReportReasonsInitialParams();
    reportReasonsNavigator = MockReportReasonsNavigator();
    reportDetailsNavigator = MockReportDetailsNavigator();
    reportDetailsInitialParams = MockReportDetailsInitialParams();

    // USE CASES
    getGlobalReportReasonsUseCase = MockGetGlobalReportReasonsUseCase();
    getCircleReportReasonsUseCase = MockGetCircleReportReasonsUseCase();
    createGlobalReportUseCase = MockCreateGlobalReportUseCase();
    createCircleReportUseCase = MockCreateCircleReportUseCase();

    // REPOSITORIES
    reportsRepository = MockReportsRepository();

    // STORES

    // OTHERS
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP

    registerFallbackValue(MockReportFormPresenter());
    registerFallbackValue(MockReportFormPresentationModel());
    registerFallbackValue(MockReportFormInitialParams());
    registerFallbackValue(MockReportFormNavigator());
    registerFallbackValue(MockReportReasonsPresenter());
    registerFallbackValue(MockReportReasonsPresentationModel());
    registerFallbackValue(MockReportReasonsInitialParams());
    registerFallbackValue(MockReportReasonsNavigator());
    registerFallbackValue(MockReportDetailsNavigator());
    registerFallbackValue(MockReportDetailsInitialParams());

    // USE CASES
    registerFallbackValue(ReportEntityType.unknown);
    registerFallbackValue(const ReportInput.empty());
    registerFallbackValue(const CreateReportInput.empty());

    // REPOSITORIES
    registerFallbackValue(MockReportsRepository());

    // INITIAL PARAMS

    // GRAPHQL

    // STORES
  }
}
