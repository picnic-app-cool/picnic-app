import 'dart:io';

import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/features/onboarding/permissions_form/permissions_form_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PermissionsFormPresentationModel implements PermissionsFormViewModel {
  /// Creates the initial state
  PermissionsFormPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PermissionsFormInitialParams initialParams,
    AppInfoStore appInfoStore,
  )   : androidSdk = appInfoStore.appInfo.deviceInfo.androidSdk,
        notificationsPermissionStatus = RuntimePermissionStatus.unknown,
        contactsPermissionStatus = RuntimePermissionStatus.unknown,
        onContinueCallback = initialParams.onContinue,
        contactsPermissionAlreadyRequested = false,
        notificationsPermissionAlreadyRequested = false;

  /// Used for the copyWith method
  PermissionsFormPresentationModel._({
    required this.androidSdk,
    required this.notificationsPermissionStatus,
    required this.contactsPermissionStatus,
    required this.onContinueCallback,
    required this.contactsPermissionAlreadyRequested,
    required this.notificationsPermissionAlreadyRequested,
  });

  final void Function(RuntimePermissionStatus) onContinueCallback;

  final RuntimePermissionStatus notificationsPermissionStatus;

  final RuntimePermissionStatus contactsPermissionStatus;

  @override
  final int androidSdk;

  @override
  final bool contactsPermissionAlreadyRequested;

  @override
  final bool notificationsPermissionAlreadyRequested;

  @override
  //ignore: no-magic-number
  bool get notificationsPermissionShouldBeRequested => !(Platform.isAndroid && androidSdk < 33);

  @override
  bool get contactsPermissionGranted => contactsPermissionStatus == RuntimePermissionStatus.granted;

  @override
  bool get notificationsPermissionGranted => notificationsPermissionStatus == RuntimePermissionStatus.granted;

  PermissionsFormPresentationModel copyWith({
    int? androidSdk,
    void Function(RuntimePermissionStatus)? onContinueCallback,
    RuntimePermissionStatus? notificationsPermissionStatus,
    RuntimePermissionStatus? contactsPermissionStatus,
    bool? contactsPermissionAlreadyRequested,
    bool? notificationsPermissionAlreadyRequested,
  }) {
    return PermissionsFormPresentationModel._(
      androidSdk: androidSdk ?? this.androidSdk,
      onContinueCallback: onContinueCallback ?? this.onContinueCallback,
      notificationsPermissionStatus: notificationsPermissionStatus ?? this.notificationsPermissionStatus,
      contactsPermissionStatus: contactsPermissionStatus ?? this.contactsPermissionStatus,
      contactsPermissionAlreadyRequested: contactsPermissionAlreadyRequested ?? this.contactsPermissionAlreadyRequested,
      notificationsPermissionAlreadyRequested:
          notificationsPermissionAlreadyRequested ?? this.notificationsPermissionAlreadyRequested,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PermissionsFormViewModel {
  int get androidSdk;

  bool get notificationsPermissionShouldBeRequested;

  bool get notificationsPermissionAlreadyRequested;

  bool get notificationsPermissionGranted;

  bool get contactsPermissionAlreadyRequested;

  bool get contactsPermissionGranted;
}
