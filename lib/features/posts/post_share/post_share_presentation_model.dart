import 'package:picnic_app/features/posts/domain/model/post_share_app.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostSharePresentationModel implements PostShareViewModel {
  /// Creates the initial state
  PostSharePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostShareInitialParams initialParams,
  ) : post = initialParams.post;

  /// Used for the copyWith method
  PostSharePresentationModel._({
    required this.post,
  });

  final Post post;

  @override
  List<PostShareApp> get postShareApps => PostShareApp.values;

  PostSharePresentationModel copyWith({
    Post? post,
  }) {
    return PostSharePresentationModel._(
      post: post ?? this.post,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostShareViewModel {
  List<PostShareApp> get postShareApps;
}
