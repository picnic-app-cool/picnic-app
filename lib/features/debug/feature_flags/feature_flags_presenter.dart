import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_feature_flags_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/debug/domain/use_cases/change_feature_flags_use_case.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_navigator.dart';
import 'package:picnic_app/features/debug/feature_flags/feature_flags_presentation_model.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

class FeatureFlagsPresenter extends Cubit<FeatureFlagsViewModel> with SubscriptionsMixin {
  FeatureFlagsPresenter(
    super.model,
    this.navigator,
    this._changeFeatureFlagsUseCase,
    this._getFeatureFlagsUseCase,
    this._featureFlagsStore,
  ) {
    listenTo<FeatureFlags>(
      stream: _featureFlagsStore.stream,
      subscriptionId: _featureFlagsStoreSubscription,
      onChange: (featureFlags) => tryEmit(_model.copyWith(featureFlags: featureFlags)),
    );
  }

  final FeatureFlagsNavigator navigator;
  final ChangeFeatureFlagsUseCase _changeFeatureFlagsUseCase;
  final GetFeatureFlagsUseCase _getFeatureFlagsUseCase;
  final FeatureFlagsStore _featureFlagsStore;

  static const _featureFlagsStoreSubscription = "featureFlagsStoreSubscription";

  // ignore: unused_element
  FeatureFlagsPresentationModel get _model => state as FeatureFlagsPresentationModel;

  Future<void> onChangeStateTap(FeatureFlagType featureFlag) async {
    final newFlags = _model.featureFlags
        .byUpdatingItem(
          itemFinder: (MapEntry<FeatureFlagType, bool> item) => item.key == featureFlag,
          update: (MapEntry<FeatureFlagType, bool> item) => MapEntry(item.key, !item.value),
        )
        .asMap()
        .map((key, value) => MapEntry(value.key, value.value));

    await _changeFeatureFlagsUseCase.execute(_model.internalFeatureFlags.copyWith(flags: newFlags)).doOn(
          success: (_) => _getFeatureFlagsUseCase.execute(),
          fail: (failure) => navigator.showError(failure.displayableFailure()),
        );
  }
}
