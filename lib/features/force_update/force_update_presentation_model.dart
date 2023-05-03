import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class ForceUpdatePresentationModel implements ForceUpdateViewModel {
  /// Creates the initial state
  ForceUpdatePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    ForceUpdateInitialParams initialParams,
    AppInfoStore appInfoStore,
  ) : packageName = appInfoStore.appInfo.packageName;

  /// Used for the copyWith method
  ForceUpdatePresentationModel._({required this.packageName});

  @override
  final String packageName;

  ForceUpdatePresentationModel copyWith({String? packageName}) {
    return ForceUpdatePresentationModel._(packageName: packageName ?? this.packageName);
  }
}

/// Interface to expose fields used by the view (page).
abstract class ForceUpdateViewModel {
  String get packageName;
}
