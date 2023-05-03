import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class AboutElectionsPresentationModel implements AboutElectionsViewModel {
  /// Creates the initial state
  AboutElectionsPresentationModel.initial(
    AboutElectionsInitialParams initialParams,
  )   : createPostInput = initialParams.createPostInput,
        circle = initialParams.circle,
        createCircleWithoutPost = initialParams.createCircleWithoutPost;

  /// Used for the copyWith method
  AboutElectionsPresentationModel._({
    required this.circle,
    required this.createPostInput,
    required this.createCircleWithoutPost,
  });

  final Circle? circle;
  final CreatePostInput? createPostInput;
  final bool? createCircleWithoutPost;

  @override
  bool get showConfirm => circle != null;

  AboutElectionsPresentationModel copyWith({
    Circle? circle,
    CreatePostInput? createPostInput,
    bool? createCircleWithoutPost,
  }) {
    return AboutElectionsPresentationModel._(
      circle: circle ?? this.circle,
      createPostInput: createPostInput ?? this.createPostInput,
      createCircleWithoutPost: createCircleWithoutPost ?? this.createCircleWithoutPost,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class AboutElectionsViewModel {
  bool get showConfirm;
}
