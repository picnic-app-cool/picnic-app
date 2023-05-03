import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/slices/domain/model/approve_join_request_failure.dart';
import 'package:picnic_app/features/slices/domain/model/get_slice_join_requests_failure.dart';
import 'package:picnic_app/features/slices/domain/use_cases/approve_join_request_use_case.dart';
import 'package:picnic_app/features/slices/domain/use_cases/get_slice_join_requests_use_case.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_navigator.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presentation_model.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presenter.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_navigator.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_navigator.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presentation_model.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockJoinRequestsPresenter extends MockCubit<JoinRequestsViewModel> implements JoinRequestsPresenter {}

class MockJoinRequestsPresentationModel extends Mock implements JoinRequestsPresentationModel {}

class MockJoinRequestsInitialParams extends Mock implements JoinRequestsInitialParams {}

class MockJoinRequestsNavigator extends Mock implements JoinRequestsNavigator {}

class MockEditSliceRulesPresenter extends MockCubit<EditSliceRulesViewModel> implements EditSliceRulesPresenter {}

class MockEditSliceRulesPresentationModel extends Mock implements EditSliceRulesPresentationModel {}

class MockEditSliceRulesInitialParams extends Mock implements EditSliceRulesInitialParams {}

class MockEditSliceRulesNavigator extends Mock implements EditSliceRulesNavigator {}

class MockInviteUserToSliceNavigator extends Mock implements InviteUserToSliceNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetSliceJoinRequestsFailure extends Mock implements GetSliceJoinRequestsFailure {}

class MockGetSliceJoinRequestsUseCase extends Mock implements GetSliceJoinRequestsUseCase {}

class MockApproveJoinRequestFailure extends Mock implements ApproveJoinRequestFailure {}

class MockApproveJoinRequestUseCase extends Mock implements ApproveJoinRequestUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
