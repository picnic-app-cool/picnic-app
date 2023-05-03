import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import "package:picnic_app/features/debug/domain/model/change_environment_failure.dart";
import 'package:picnic_app/features/debug/domain/model/change_feature_flags_failure.dart';
import "package:picnic_app/features/debug/domain/model/invalidate_token_failure.dart";
import "package:picnic_app/features/debug/domain/model/restart_app_failure.dart";
import "package:picnic_app/features/debug/domain/use_cases/change_environment_use_case.dart";
import 'package:picnic_app/features/debug/domain/use_cases/change_feature_flags_use_case.dart';
import "package:picnic_app/features/debug/domain/use_cases/invalidate_token_use_case.dart";
import "package:picnic_app/features/debug/domain/use_cases/restart_app_use_case.dart";
import 'package:picnic_app/features/debug/feature_flags/feature_flags_initial_params.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_navigator.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presentation_model.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockFeatureFlagsPresenter extends MockCubit<FeatureFlagsViewModel> implements FeatureFlagsPresenter {}

class MockFeatureFlagsPresentationModel extends Mock implements FeatureFlagsPresentationModel {}

class MockFeatureFlagsInitialParams extends Mock implements FeatureFlagsInitialParams {}

class MockFeatureFlagsNavigator extends Mock implements FeatureFlagsNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockInvalidateTokenFailure extends Mock implements InvalidateTokenFailure {}

class MockInvalidateTokenUseCase extends Mock implements InvalidateTokenUseCase {}

class MockRestartAppFailure extends Mock implements RestartAppFailure {}

class MockRestartAppUseCase extends Mock implements RestartAppUseCase {}

class MockChangeEnvironmentFailure extends Mock implements ChangeEnvironmentFailure {}

class MockChangeEnvironmentUseCase extends Mock implements ChangeEnvironmentUseCase {}

class MockChangeFeatureFlagsFailure extends Mock implements ChangeFeatureFlagsFailure {}

class MockChangeFeatureFlagsUseCase extends Mock implements ChangeFeatureFlagsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
