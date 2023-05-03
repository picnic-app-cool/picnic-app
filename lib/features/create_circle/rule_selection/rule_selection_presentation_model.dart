import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_moderation_type.dart';
import 'package:picnic_app/core/domain/model/update_circle_failure.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/create_circle/rule_selection/rule_selection_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class RuleSelectionPresentationModel implements RuleSelectionViewModel {
  /// Creates the initial state
  RuleSelectionPresentationModel.initial(
    RuleSelectionInitialParams initialParams,
  )   : createPostInput = initialParams.createPostInput,
        updateCircleInput = UpdateCircleInput.updateModerationTypeForCircle(initialParams.circle),
        updateCircleFutureResult = const FutureResult.empty();

  /// Used for the copyWith method
  RuleSelectionPresentationModel._({
    required this.createPostInput,
    required this.updateCircleInput,
    required this.updateCircleFutureResult,
  });

  final UpdateCircleInput updateCircleInput;
  final FutureResult<Either<UpdateCircleFailure, Circle>> updateCircleFutureResult;
  final CreatePostInput createPostInput;

  @override
  CircleModerationType get selectedRule => updateCircleInput.circleUpdate.moderationType;

  @override
  List<CircleModerationType> get rules => [
        CircleModerationType.director,
        CircleModerationType.democratic,
      ];

  RuleSelectionViewModel byUpdatingModerationType(CircleModerationType value) => copyWith(
        updateCircleInput: updateCircleInput.byUpdatingModerationType(value),
      );

  RuleSelectionPresentationModel copyWith({
    UpdateCircleInput? updateCircleInput,
    FutureResult<Either<UpdateCircleFailure, Circle>>? updateCircleFutureResult,
    CreatePostInput? createPostInput,
  }) {
    return RuleSelectionPresentationModel._(
      updateCircleInput: updateCircleInput ?? this.updateCircleInput,
      updateCircleFutureResult: updateCircleFutureResult ?? this.updateCircleFutureResult,
      createPostInput: createPostInput ?? this.createPostInput,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class RuleSelectionViewModel {
  CircleModerationType get selectedRule;

  List<CircleModerationType> get rules;
}
