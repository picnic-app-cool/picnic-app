import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/runtime_permission.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/use_cases/get_runtime_permission_status_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_navigator.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_presentation_model.dart';

class PermissionsFormPresenter extends Cubit<PermissionsFormViewModel> {
  PermissionsFormPresenter(
    PermissionsFormPresentationModel model,
    this.navigator,
    this._getRuntimePermissionStatusUseCase,
    this._requestRuntimePermissionUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final PermissionsFormNavigator navigator;
  final GetRuntimePermissionStatusUseCase _getRuntimePermissionStatusUseCase;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  PermissionsFormPresentationModel get _model => state as PermissionsFormPresentationModel;

  void onInit() => _checkRuntimePermissions();

  void onTapEnableNotifications() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingNotificationsPermissionButton),
    );
    _requestRuntimePermissionUseCase
        .execute(permission: RuntimePermission.notifications) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (status) => _handleNotificationsPermissionResponse(
            status,
            whileRequesting: true,
          ),
        );
  }

  void onTapEnableContacts() {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingContactsPermissionButton),
    );
    _requestRuntimePermissionUseCase
        .execute(permission: RuntimePermission.contacts) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (status) => _handleContactsPermissionResponse(
            status,
            whileRequesting: true,
          ),
        );
  }

  void _checkRuntimePermissions() {
    _getRuntimePermissionStatusUseCase
        .execute(permission: RuntimePermission.notifications) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (status) => _handleNotificationsPermissionResponse(status),
        );
    _getRuntimePermissionStatusUseCase
        .execute(permission: RuntimePermission.contacts) //
        .doOn(
          fail: (fail) => navigator.showError(fail.displayableFailure()),
          success: (status) => _handleContactsPermissionResponse(status),
        );
  }

  void _handleNotificationsPermissionResponse(RuntimePermissionStatus status, {bool whileRequesting = false}) {
    if (whileRequesting) {
      tryEmit(
        _model.copyWith(
          notificationsPermissionStatus: status,
          notificationsPermissionAlreadyRequested: true,
        ),
      );
    } else {
      tryEmit(
        _model.copyWith(
          notificationsPermissionStatus: status,
          notificationsPermissionAlreadyRequested:
              status == RuntimePermissionStatus.permanentlyDenied || status == RuntimePermissionStatus.granted,
        ),
      );
    }
    _continueIfNothingToRequest();
  }

  void _handleContactsPermissionResponse(RuntimePermissionStatus status, {bool whileRequesting = false}) {
    if (whileRequesting) {
      tryEmit(
        _model.copyWith(
          contactsPermissionStatus: status,
          contactsPermissionAlreadyRequested: true,
        ),
      );
    } else {
      tryEmit(
        _model.copyWith(
          contactsPermissionStatus: status,
          contactsPermissionAlreadyRequested:
              status == RuntimePermissionStatus.permanentlyDenied || status == RuntimePermissionStatus.granted,
        ),
      );
    }
    _continueIfNothingToRequest();
  }

  void _continueIfNothingToRequest() {
    if (!_model.contactsPermissionAlreadyRequested) {
      return;
    }
    if (!_model.notificationsPermissionAlreadyRequested && _model.notificationsPermissionShouldBeRequested) {
      return;
    }

    _model.onContinueCallback(_model.notificationsPermissionStatus);
  }
}
