import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flag_type.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags.dart';
import 'package:picnic_app/core/domain/model/update_circle_failure.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/circle_visibility.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class EditCirclePresentationModel implements EditCircleViewModel {
  /// Creates the initial state
  EditCirclePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    EditCircleInitialParams initialParams,
    FeatureFlagsStore featureFlagsStore,
  )   : circle = initialParams.circle,
        saveResult = const FutureResult.empty(),
        featureFlags = featureFlagsStore.featureFlags,
        updateCircleInput = UpdateCircleInput.updateCircle(initialParams.circle);

  /// Used for the copyWith method
  EditCirclePresentationModel._({
    required this.updateCircleInput,
    required this.circle,
    required this.featureFlags,
    required this.saveResult,
  });

  final UpdateCircleInput updateCircleInput;

  @override
  final Circle circle;

  final FeatureFlags featureFlags;

  final FutureResult<Either<UpdateCircleFailure, Circle>> saveResult;

  @override
  bool get userSelectedNewImage => updateCircleInput.circleUpdate.userSelectedNewImage;

  @override
  bool get saveEnabled =>
      (emoji.isNotEmpty || image.isNotEmpty) && name.isNotEmpty && description.isNotEmpty && circleInfoChanged;

  @override
  String get description => updateCircleInput.circleUpdate.description;

  @override
  String get name => updateCircleInput.circleUpdate.name;

  @override
  bool get imageChanged => emoji != circle.emoji || image != circle.imageFile;

  @override
  bool get nameChanged => name != circle.name;

  @override
  bool get coverChanged => coverImage != circle.coverImage || userSelectedNewCoverImage;

  @override
  CircleVisibility get visibility => updateCircleInput.circleUpdate.visibility;

  @override
  bool get isPrivateDiscoverableSettingEnabled => featureFlags[FeatureFlagType.isCirclePrivacyDiscoverableEnabled];

  @override
  bool get isSaveLoading => saveResult.isPending();

  @override
  bool get circleInfoChanged => descriptionChanged || nameChanged || imageChanged || coverChanged;

  @override
  bool get descriptionChanged => description != circle.description;

  @override
  String get emoji => updateCircleInput.circleUpdate.emoji;

  @override
  String get image => updateCircleInput.circleUpdate.image;

  @override
  String get coverImage => updateCircleInput.circleUpdate.coverImage;

  @override
  bool get coverExists => coverImage.isNotEmpty;

  @override
  bool get userSelectedNewCoverImage => updateCircleInput.circleUpdate.userSelectedNewCoverImage;

  EditCircleViewModel byUpdatingEmoji(String emoji) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingEmoji(emoji),
      );

  EditCircleViewModel byUpdatingImage(String image) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingImage(image),
      );

  EditCircleViewModel byUpdatingCover(String coverImage) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingCoverImage(coverImage),
      );

  EditCircleViewModel byUpdatingName(String name) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingName(name),
      );

  EditCircleViewModel byUpdatingDescription(String description) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingDescription(description),
      );

  EditCircleViewModel byUpdatingVisibility(CircleVisibility visibility) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingVisibility(visibility),
      );

  EditCirclePresentationModel copyWith({
    UpdateCircleInput? updateCircleInput,
    Circle? circle,
    FeatureFlags? featureFlags,
    FutureResult<Either<UpdateCircleFailure, Circle>>? saveResult,
  }) {
    return EditCirclePresentationModel._(
      circle: circle ?? this.circle,
      saveResult: saveResult ?? this.saveResult,
      featureFlags: featureFlags ?? this.featureFlags,
      updateCircleInput: updateCircleInput ?? this.updateCircleInput,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class EditCircleViewModel {
  bool get saveEnabled;

  String get emoji;

  String get image;

  bool get userSelectedNewImage;

  String get description;

  String get name;

  bool get nameChanged;

  bool get coverChanged;

  bool get descriptionChanged;

  bool get imageChanged;

  bool get circleInfoChanged;

  Circle get circle;

  bool get isSaveLoading;

  CircleVisibility get visibility;

  bool get isPrivateDiscoverableSettingEnabled;

  String get coverImage;

  bool get coverExists;

  bool get userSelectedNewCoverImage;
}
