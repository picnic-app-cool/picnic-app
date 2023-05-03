import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/domain/use_cases/approve_join_request_use_case.dart';
import 'package:picnic_app/features/slices/domain/use_cases/get_slice_join_requests_use_case.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_initial_params.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_navigator.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_page.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presentation_model.dart';
import 'package:picnic_app/features/slices/edit_slices/edit_slice_rules_presenter.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_initial_params.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_navigator.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_page.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presentation_model.dart';
import 'package:picnic_app/features/slices/invite_user_to_slice/invite_user_to_slice_presenter.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_navigator.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_page.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presentation_model.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presenter.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_page.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presenter.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_bottom_sheet_page.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_navigator.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presenter.dart';
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
        ..registerFactory<GetSliceJoinRequestsUseCase>(
          () => GetSliceJoinRequestsUseCase(),
        )
        ..registerFactory<ApproveJoinRequestUseCase>(
          () => ApproveJoinRequestUseCase(
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
        ..registerFactory<SliceDetailsNavigator>(
          () => SliceDetailsNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<SliceDetailsPresentationModel, SliceDetailsInitialParams, dynamic>(
          (params, _) => SliceDetailsPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<SliceDetailsPresenter, SliceDetailsInitialParams, dynamic>(
          (initialParams, _) => SliceDetailsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SliceDetailsPage, SliceDetailsInitialParams, dynamic>(
          (initialParams, _) => SliceDetailsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<JoinRequestsNavigator>(
          () => JoinRequestsNavigator(getIt()),
        )
        ..registerFactoryParam<JoinRequestsViewModel, JoinRequestsInitialParams, dynamic>(
          (params, _) => JoinRequestsPresentationModel.initial(params),
        )
        ..registerFactoryParam<JoinRequestsPresenter, JoinRequestsInitialParams, dynamic>(
          (params, _) => JoinRequestsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<JoinRequestsPage, JoinRequestsInitialParams, dynamic>(
          (params, _) => JoinRequestsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<EditSliceRulesNavigator>(
          () => EditSliceRulesNavigator(getIt()),
        )
        ..registerFactoryParam<EditSliceRulesViewModel, EditSliceRulesInitialParams, dynamic>(
          (params, _) => EditSliceRulesPresentationModel.initial(params),
        )
        ..registerFactoryParam<EditSliceRulesPresenter, EditSliceRulesInitialParams, dynamic>(
          (params, _) => EditSliceRulesPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<EditSliceRulesPage, EditSliceRulesInitialParams, dynamic>(
          (params, _) => EditSliceRulesPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<InviteUserToSliceNavigator>(
          () => InviteUserToSliceNavigator(getIt()),
        )
        ..registerFactoryParam<InviteUserToSlicePresentationModel, InviteUserToSliceInitialParams, dynamic>(
          (params, _) => InviteUserToSlicePresentationModel.initial(params),
        )
        ..registerFactoryParam<InviteUserToSlicePresenter, InviteUserToSliceInitialParams, dynamic>(
          (params, _) => InviteUserToSlicePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<InviteUserToSlicePage, InviteUserToSliceInitialParams, dynamic>(
          (params, _) => InviteUserToSlicePage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;

  getIt
    ..registerFactory<SliceSettingsNavigator>(
      () => SliceSettingsNavigator(getIt()),
    )
    ..registerFactoryParam<SliceSettingsViewModel, SliceSettingsInitialParams, dynamic>(
      (params, _) => SliceSettingsPresentationModel.initial(
        params,
      ),
    )
    ..registerFactoryParam<SliceSettingsPresenter, SliceSettingsInitialParams, dynamic>(
      (initialParams, _) => SliceSettingsPresenter(
        getIt(param1: initialParams),
        getIt(),
        getIt(),
        getIt(),
      ),
    )
    ..registerFactoryParam<SliceSettingsBottomSheetPage, SliceSettingsInitialParams, dynamic>(
      (initialParams, _) => SliceSettingsBottomSheetPage(
        presenter: getIt(param1: initialParams),
      ),
    );
}
