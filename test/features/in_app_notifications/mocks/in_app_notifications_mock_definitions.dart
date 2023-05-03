import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/add_in_app_notifications_filter_use_case.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/get_in_app_notifications_use_case.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/remove_in_app_notifications_filter_use_case.dart';
import 'package:picnic_app/features/in_app_events/domain/use_cases/toggle_in_app_notifications_use_case.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_navigator.dart';
import 'package:picnic_app/features/in_app_events/notifications/notifications_presenter.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockNotificationsPresenter extends MockCubit<NotificationsViewModel> implements NotificationsPresenter {}

class MockNotificationsNavigator extends Mock implements NotificationsNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetInAppNotificationsUseCase extends Mock implements GetInAppNotificationsUseCase {}

class MockAddInAppNotificationsFilterUseCase extends Mock implements AddInAppNotificationsFilterUseCase {}

class MockRemoveInAppNotificationsFilterUseCase extends Mock implements RemoveInAppNotificationsFilterUseCase {}

class MockToggleInAppNotificationsUseCase extends Mock implements ToggleInAppNotificationsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
