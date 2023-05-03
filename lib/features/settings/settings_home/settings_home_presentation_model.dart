import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/features/settings/settings_home/settings_home_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class SettingsHomePresentationModel implements SettingsHomeViewModel {
  /// Creates the initial state
  SettingsHomePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    SettingsHomeInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : user = initialParams.user,
        appInfo = const AppInfo.empty(),
        featureFlags = featureFlagsStore.featureFlags;

  /// Used for the copyWith method
  SettingsHomePresentationModel._({
    required this.user,
    required this.appInfo,
    required this.featureFlags,
  });

  final User user;

  @override
  final AppInfo appInfo;

  final FeatureFlags featureFlags;

  String get username => user.username;

  @override
  String get inviteLink => shareLink;

  @override
  String get shareLink => user.shareLink;

  @override
  bool get enableInviteContactListPage => featureFlags[FeatureFlagType.phoneContactsSharingEnable];

  @override
  bool get isLanguageSettingsEnabled => featureFlags[FeatureFlagType.isLanguageSettingsEnabled];

  SettingsHomePresentationModel copyWith({
    User? user,
    FeatureFlags? featureFlags,
    AppInfo? appInfo,
  }) {
    return SettingsHomePresentationModel._(
      user: user ?? this.user,
      featureFlags: featureFlags ?? this.featureFlags,
      appInfo: appInfo ?? this.appInfo,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class SettingsHomeViewModel {
  String get shareLink;

  String get inviteLink;

  AppInfo get appInfo;

  bool get isLanguageSettingsEnabled;

  bool get enableInviteContactListPage;
}
