import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/reports/domain/repositories/reports_repository.dart';
import 'package:picnic_app/features/reports/domain/use_cases/create_circle_report_use_case.dart';
import 'package:picnic_app/features/reports/domain/use_cases/create_global_report_use_case.dart';
import 'package:picnic_app/features/reports/domain/use_cases/get_circle_report_reasons_use_case.dart';
import 'package:picnic_app/features/reports/domain/use_cases/get_global_report_reasons_use_case.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_initial_params.dart';
import 'package:picnic_app/features/reports/report_details/resolved_report_details_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/reports/report_form/report_form_navigator.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presentation_model.dart';
import 'package:picnic_app/features/reports/report_form/report_form_presenter.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_initial_params.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_navigator.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presentation_model.dart';
import 'package:picnic_app/features/reports/report_reasons/report_reasons_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockReportFormPresenter extends MockCubit<ReportFormViewModel> implements ReportFormPresenter {}

class MockReportFormPresentationModel extends Mock implements ReportFormPresentationModel {}

class MockReportFormInitialParams extends Mock implements ReportFormInitialParams {}

class MockReportFormNavigator extends Mock implements ReportFormNavigator {}

class MockReportDetailsNavigator extends Mock implements ResolvedReportDetailsNavigator {}

class MockReportReasonsPresenter extends MockCubit<ReportReasonsViewModel> implements ReportReasonsPresenter {}

class MockReportReasonsPresentationModel extends Mock implements ReportReasonsPresentationModel {}

class MockReportReasonsInitialParams extends Mock implements ReportReasonsInitialParams {}

class MockReportDetailsInitialParams extends Mock implements ResolvedReportDetailsInitialParams {}

class MockReportReasonsNavigator extends Mock implements ReportReasonsNavigator {}

// USE CASES
class MockGetGlobalReportReasonsUseCase extends Mock implements GetGlobalReportReasonsUseCase {}

class MockCreateGlobalReportUseCase extends Mock implements CreateGlobalReportUseCase {}

class MockGetCircleReportReasonsUseCase extends Mock implements GetCircleReportReasonsUseCase {}

class MockCreateCircleReportUseCase extends Mock implements CreateCircleReportUseCase {}

// REPOSITORIES
class MockReportsRepository extends Mock implements ReportsRepository {}

// STORES

// OTHERS
