import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/settings/domain/model/get_privacy_settings_failure.dart';
import 'package:picnic_app/features/settings/domain/model/privacy_settings.dart';
import 'package:picnic_app/features/settings/privacy_settings/privacy_settings_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PrivacySettingsPresentationModel implements PrivacySettingsViewModel {
  /// Creates the initial state
  PrivacySettingsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PrivacySettingsInitialParams initialParams,
  )   : permissionStatus = RuntimePermissionStatus.unknown,
        privacySettingsResult = const FutureResult.empty(),
        privacySettings = const PrivacySettings.empty();

  /// Used for the copyWith method
  PrivacySettingsPresentationModel._({
    required this.privacySettings,
    required this.privacySettingsResult,
    required this.permissionStatus,
  });

  final RuntimePermissionStatus permissionStatus;

  @override
  final PrivacySettings privacySettings;

  final FutureResult<Either<GetPrivacySettingsFailure, PrivacySettings>> privacySettingsResult;

  @override
  bool get isLoading => privacySettingsResult.isPending();

  bool get isAllowAccessContactGranted => RuntimePermissionStatus.isGranted(permissionStatus);

  PrivacySettingsPresentationModel copyWith({
    PrivacySettings? privacySettings,
    FutureResult<Either<GetPrivacySettingsFailure, PrivacySettings>>? privacySettingsResult,
    RuntimePermissionStatus? permissionStatus,
  }) {
    return PrivacySettingsPresentationModel._(
      privacySettings: privacySettings ?? this.privacySettings,
      privacySettingsResult: privacySettingsResult ?? this.privacySettingsResult,
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PrivacySettingsViewModel {
  PrivacySettings get privacySettings;

  bool get isLoading;
}
