import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleSettingsPresentationModel implements CircleSettingsViewModel {
  /// Creates the initial state
  CircleSettingsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleSettingsInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
    this.currentTimeProvider,
  )   : circleRole = initialParams.circleRole,
        circle = initialParams.circle,
        notificationTimeStamp = currentTimeProvider.currentTime,
        onCircleUpdatedCallback = initialParams.onCircleUpdated,
        featureFlags = featureFlagsStore.featureFlags,
        onCirclePostDeletedCallback = initialParams.onCirclePostDeleted;

  /// Used for the copyWith method
  CircleSettingsPresentationModel._({
    required this.currentTimeProvider,
    required this.notificationTimeStamp,
    required this.circleRole,
    required this.circle,
    required this.featureFlags,
    required this.onCirclePostDeletedCallback,
    required this.onCircleUpdatedCallback,
  });

  final FeatureFlags featureFlags;

  final VoidCallback? onCirclePostDeletedCallback;

  final VoidCallback? onCircleUpdatedCallback;

  @override
  final CircleRole circleRole;

  @override
  final DateTime notificationTimeStamp;

  @override
  final CurrentTimeProvider currentTimeProvider;

  @override
  final Circle circle;

  @override
  bool get isSendingPushEnabled => featureFlags[FeatureFlagType.sendCirclePushEnabled];

  @override
  bool get isCirclePrivacyDiscoverableEnabled => featureFlags[FeatureFlagType.isCirclePrivacyDiscoverableEnabled];

  @override
  bool get isCustomRolesEnabled => featureFlags[FeatureFlagType.customRoles];

  @override
  bool get isCircleConfigEnabled => featureFlags[FeatureFlagType.circleConfig];

  @override
  bool get showManageRoles => featureFlags[FeatureFlagType.manageRolesEnabled];

  @override
  bool get hasPermissionToManageReports => circle.hasPermissionToManageReports;

  @override
  bool get hasPermissionToManageUsers => circle.hasPermissionToManageUsers;

  @override
  bool get isLinkDiscordAvailable => circle.isDirector;

  @override
  bool get hasPermissionToManageCircle => circle.hasPermissionToManageCircle;

  @override
  bool get hasPermissionToManageRoles => circle.hasPermissionToManageRoles;

  @override
  bool get hasPermissionToConfigCircle => circle.hasPermissionForCircleConfig;

  @override
  bool get hasPermissionToChangePrivacy => true;

  CircleSettingsPresentationModel byUpdatingCircle(Circle circle) => copyWith(circle: circle);

  CircleSettingsPresentationModel copyWith({
    FeatureFlags? featureFlags,
    CircleRole? circleRole,
    DateTime? notificationTimeStamp,
    CurrentTimeProvider? currentTimeProvider,
    Circle? circle,
    VoidCallback? onCirclePostDeletedCallback,
    VoidCallback? onCircleUpdatedCallback,
  }) {
    return CircleSettingsPresentationModel._(
      featureFlags: featureFlags ?? this.featureFlags,
      circleRole: circleRole ?? this.circleRole,
      notificationTimeStamp: notificationTimeStamp ?? this.notificationTimeStamp,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      circle: circle ?? this.circle,
      onCirclePostDeletedCallback: onCirclePostDeletedCallback ?? this.onCirclePostDeletedCallback,
      onCircleUpdatedCallback: onCircleUpdatedCallback ?? this.onCircleUpdatedCallback,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleSettingsViewModel {
  Circle get circle;

  CircleRole get circleRole;

  CurrentTimeProvider get currentTimeProvider;

  DateTime get notificationTimeStamp;

  bool get isSendingPushEnabled;

  bool get isCirclePrivacyDiscoverableEnabled;

  bool get isCircleConfigEnabled;

  bool get isCustomRolesEnabled;

  bool get showManageRoles;

  bool get hasPermissionToManageReports;

  bool get hasPermissionToManageUsers;

  bool get hasPermissionToManageCircle;

  bool get hasPermissionToManageRoles;

  bool get hasPermissionToConfigCircle;

  bool get hasPermissionToChangePrivacy;

  bool get isLinkDiscordAvailable;
}
