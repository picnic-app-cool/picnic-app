import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/circle_config/circle_config_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/circle_config.dart';
import 'package:picnic_app/features/circles/domain/model/get_default_circle_config_failure.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_failure.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_form.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/utils/extensions/list_extension.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleConfigPresentationModel implements CircleConfigViewModel {
  /// Creates the initial state
  CircleConfigPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleConfigInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : configListResult = const FutureResult.empty(),
        configs = initialParams.circle.configs,
        isNewCircle = initialParams.isNewCircle,
        createCircleFutureResult = const FutureResult.empty(),
        createCircleWithoutPost = initialParams.createCircleWithoutPost,
        createPostInput = initialParams.createPostInput,
        featureFlags = featureFlagsStore.featureFlags,
        createCircleInput = initialParams.createCircleInput,
        circle = initialParams.circle,
        configsAvailableBasedOnRole =
            initialParams.isNewCircle ? initialParams.circle.configs : initialParams.circle.configsAvailableBasedOnRole;

  /// Used for the copyWith method
  CircleConfigPresentationModel._({
    required this.configListResult,
    required this.configs,
    required this.isNewCircle,
    required this.createCircleFutureResult,
    required this.createCircleWithoutPost,
    required this.createPostInput,
    required this.featureFlags,
    required this.createCircleInput,
    required this.circle,
    required this.configsAvailableBasedOnRole,
  });

  final FutureResult<Either<GetDefaultCircleConfigFailure, List<CircleConfig>>> configListResult;
  final FutureResult<Either<CreateCircleFailure, Circle>> createCircleFutureResult;

  /// optional create post input in case we got to this screen from post creation
  final CreatePostInput createPostInput;

  final CircleInput createCircleInput;

  final FeatureFlags featureFlags;

  final Circle circle;

  @override
  final List<CircleConfig> configs;

  @override
  final List<CircleConfig> configsAvailableBasedOnRole;

  @override
  final bool isNewCircle;

  @override
  final bool createCircleWithoutPost;

  @override
  bool get isLoading => configListResult.isPending();

  @override
  bool get showSeeds => featureFlags[FeatureFlagType.areSeedsEnabled];

  @override
  bool get isCreatingCircle => createCircleFutureResult.isPending();

  CircleConfigPresentationModel copyWith({
    FutureResult<Either<GetDefaultCircleConfigFailure, List<CircleConfig>>>? configListResult,
    List<CircleConfig>? configs,
    bool? isNewCircle,
    FutureResult<Either<CreateCircleFailure, Circle>>? createCircleFutureResult,
    bool? createCircleWithoutPost,
    CreateCircleForm? createCircleForm,
    CircleInput? createCircleInput,
    FeatureFlags? featureFlags,
    CreatePostInput? createPostInput,
    Circle? circle,
    List<CircleConfig>? configsAvailableBasedOnRole,
  }) {
    return CircleConfigPresentationModel._(
      configListResult: configListResult ?? this.configListResult,
      configs: configs ?? this.configs,
      isNewCircle: isNewCircle ?? this.isNewCircle,
      createCircleFutureResult: createCircleFutureResult ?? this.createCircleFutureResult,
      createCircleWithoutPost: createCircleWithoutPost ?? this.createCircleWithoutPost,
      createCircleInput: createCircleInput ?? this.createCircleInput,
      featureFlags: featureFlags ?? this.featureFlags,
      createPostInput: createPostInput ?? this.createPostInput,
      circle: circle ?? this.circle,
      configsAvailableBasedOnRole: configsAvailableBasedOnRole ?? this.configsAvailableBasedOnRole,
    );
  }

  CircleConfigViewModel byUpdatingConfig(CircleConfig config, {required bool value}) {
    var updatedList = configs.byUpdatingItem(
      update: (update) => update.copyWith(enabled: value),
      itemFinder: (it) => it.type == config.type,
    );
    return copyWith(configs: updatedList);
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleConfigViewModel {
  bool get isLoading;

  bool get isNewCircle;

  List<CircleConfig> get configs;

  List<CircleConfig> get configsAvailableBasedOnRole;

  bool get createCircleWithoutPost;

  bool get showSeeds;

  bool get isCreatingCircle;
}
