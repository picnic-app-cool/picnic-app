import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/create_circle/create_circle/create_circle_initial_params.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_failure.dart';
import 'package:picnic_app/features/create_circle/domain/model/create_circle_form.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CreateCirclePresentationModel implements CreateCircleViewModel {
  /// Creates the initial state
  CreateCirclePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CreateCircleInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : createPostInput = initialParams.createPostInput,
        createCircleForm = const CreateCircleForm.empty(),
        createCircleFutureResult = const FutureResult.empty(),
        featureFlags = featureFlagsStore.featureFlags,
        createCircleWithoutPost = initialParams.createCircleWithoutPost;

  /// Used for the copyWith method
  CreateCirclePresentationModel._({
    required this.createCircleFutureResult,
    required this.createCircleForm,
    required this.createPostInput,
    required this.featureFlags,
    required this.createCircleWithoutPost,
  });

  @override
  final CreateCircleForm createCircleForm;

  final FeatureFlags featureFlags;

  /// optional create post input in case we got to this screen from post creation
  final CreatePostInput createPostInput;

  final FutureResult<Either<CreateCircleFailure, Circle>> createCircleFutureResult;

  @override
  final bool createCircleWithoutPost;

  @override
  bool get isCreatingCircle => createCircleFutureResult.isPending();

  @override
  bool get isPrivateDiscoverableSettingEnabled => featureFlags[FeatureFlagType.isCirclePrivacyDiscoverableEnabled];

  CircleInput get createCircleInput => createCircleForm.toCircleInput();

  @override
  CircleVisibility get visibility => createCircleInput.visibility;

  @override
  bool get showSeeds => featureFlags[FeatureFlagType.areSeedsEnabled];

  @override
  bool get createCircleEnabled => createCircleForm.isValid;

  @override
  bool get coverExists => createCircleForm.coverImage.isNotEmpty;

  CreateCircleViewModel byUpdatingForm(CreateCircleForm Function(CreateCircleForm input) updater) {
    return copyWith(createCircleForm: updater(createCircleForm));
  }

  CreateCirclePresentationModel copyWith({
    CreateCircleForm? createCircleForm,
    CreatePostInput? createPostInput,
    FutureResult<Either<CreateCircleFailure, Circle>>? createCircleFutureResult,
    FeatureFlags? featureFlags,
    bool? createCircleWithoutPost,
  }) {
    return CreateCirclePresentationModel._(
      createCircleForm: createCircleForm ?? this.createCircleForm,
      createPostInput: createPostInput ?? this.createPostInput,
      featureFlags: featureFlags ?? this.featureFlags,
      createCircleFutureResult: createCircleFutureResult ?? this.createCircleFutureResult,
      createCircleWithoutPost: createCircleWithoutPost ?? this.createCircleWithoutPost,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CreateCircleViewModel {
  CreateCircleForm get createCircleForm;

  bool get isCreatingCircle;

  bool get showSeeds;

  CircleVisibility get visibility;

  bool get createCircleEnabled;

  bool get isPrivateDiscoverableSettingEnabled;

  bool get createCircleWithoutPost;

  bool get coverExists;
}
