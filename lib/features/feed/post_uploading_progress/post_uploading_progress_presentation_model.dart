import 'package:picnic_app/core/data/graphql/model/create_post_graphql_background_call.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PostUploadingProgressPresentationModel implements PostUploadingProgressViewModel {
  /// Creates the initial state
  PostUploadingProgressPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PostUploadingProgressInitialParams initialParams,
    this.currentTimeProvider,
  )   : statuses = [],
        statusesToBeRemoved = {},
        onPostToBeShown = initialParams.onPostToBeShown;

  /// Used for the copyWith method
  PostUploadingProgressPresentationModel._({
    required this.statuses,
    required this.currentTimeProvider,
    required this.statusesToBeRemoved,
    required this.onPostToBeShown,
  });

  static const successfulPostUploadVisibleSeconds = 7;

  @override
  final List<CreatePostBackgroundCallStatus> statuses;

  final CurrentTimeProvider currentTimeProvider;

  //We need to hide finished uploads after some time
  final Map<Id, DateTime> statusesToBeRemoved;

  final Function(Post) onPostToBeShown;

  DateTime get now => currentTimeProvider.currentTime;

  PostUploadingProgressPresentationModel copyWith({
    List<CreatePostBackgroundCallStatus>? statuses,
    CurrentTimeProvider? currentTimeProvider,
    Map<Id, DateTime>? statusesToBeRemoved,
    Function(Post)? onPostToBeShown,
  }) {
    return PostUploadingProgressPresentationModel._(
      statuses: statuses ?? this.statuses,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      statusesToBeRemoved: statusesToBeRemoved ?? this.statusesToBeRemoved,
      onPostToBeShown: onPostToBeShown ?? this.onPostToBeShown,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PostUploadingProgressViewModel {
  List<CreatePostBackgroundCallStatus> get statuses;
}
