import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/link_url.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/get_link_metadata_failure.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/link_post_content_input.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class LinkPostCreationPresentationModel implements LinkPostCreationViewModel {
  /// Creates the initial state
  LinkPostCreationPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    LinkPostCreationInitialParams initialParams,
  )   : getLinkMetadataFutureResult = const FutureResult.empty(),
        linkUrl = const LinkUrl.empty(),
        onPostUpdatedCallback = initialParams.onTapPost,
        circle = initialParams.circle;

  /// Used for the copyWith method
  LinkPostCreationPresentationModel._({
    required this.getLinkMetadataFutureResult,
    required this.linkUrl,
    required this.onPostUpdatedCallback,
    required this.circle,
  });

  final Function(CreatePostInput) onPostUpdatedCallback;

  final FutureResult<Either<GetLinkMetadataFailure, LinkMetadata>> getLinkMetadataFutureResult;

  final Circle? circle;

  @override
  final LinkUrl linkUrl;

  @override
  String get circleName => circle?.name ?? '';

  @override
  bool get postingEnabled => circle?.linkPostingEnabled ?? true;

  CreatePostInput get createPostInput => CreatePostInput(
        circleId: const Id.empty(), // circle id is added in the last step
        content: LinkPostContentInput(
          linkUrl: linkUrl,
        ),
        sound: const Sound.empty(), // we don't need sound for LinkPost type
      );

  @override
  bool get isLinkPasted => linkMetadata != const LinkMetadata.empty();

  @override
  bool get isLoadingLink => getLinkMetadataFutureResult.isPending();

  @override
  LinkMetadata get linkMetadata => getLinkMetadataFutureResult.result?.getSuccess() ?? const LinkMetadata.empty();

  LinkPostCreationPresentationModel copyWith({
    FutureResult<Either<GetLinkMetadataFailure, LinkMetadata>>? getLinkMetadataFutureResult,
    CreatePostInput? createPostInput,
    LinkUrl? linkUrl,
    Function(CreatePostInput)? onPostUpdatedCallback,
    Circle? circle,
  }) {
    return LinkPostCreationPresentationModel._(
      getLinkMetadataFutureResult: getLinkMetadataFutureResult ?? this.getLinkMetadataFutureResult,
      linkUrl: linkUrl ?? this.linkUrl,
      onPostUpdatedCallback: onPostUpdatedCallback ?? this.onPostUpdatedCallback,
      circle: circle ?? this.circle,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class LinkPostCreationViewModel {
  bool get isLinkPasted;

  bool get isLoadingLink;

  LinkMetadata get linkMetadata;

  LinkUrl get linkUrl;

  bool get postingEnabled;

  String get circleName;
}
