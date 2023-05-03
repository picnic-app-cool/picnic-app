import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/create_circle/circle_creation_rules/circle_creation_rules_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleCreationRulesPresentationModel implements CircleCreationRulesViewModel {
  /// Creates the initial state
  CircleCreationRulesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleCreationRulesInitialParams initialParams,
  )   : circle = initialParams.circle,
        createPostInput = initialParams.createPostInput;

  /// Used for the copyWith method
  CircleCreationRulesPresentationModel._({
    required this.circle,
    required this.createPostInput,
  });

  final CreatePostInput createPostInput;
  final Circle circle;

  CircleCreationRulesPresentationModel copyWith({
    CreatePostInput? createPostInput,
    Circle? circle,
  }) {
    return CircleCreationRulesPresentationModel._(
      createPostInput: createPostInput ?? this.createPostInput,
      circle: circle ?? this.circle,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleCreationRulesViewModel {}
