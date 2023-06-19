import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_navigator.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presenter.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_navigator.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presentation_model.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presenter.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presenter.dart';
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_navigator.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_presentation_model.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_presenter.dart";
import 'package:picnic_app/features/posts/data/get_comments_query_generator.dart';
import "package:picnic_app/features/posts/domain/model/create_comment_failure.dart";
import "package:picnic_app/features/posts/domain/model/create_post_failure.dart";
import 'package:picnic_app/features/posts/domain/model/delete_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_failure.dart';
import "package:picnic_app/features/posts/domain/model/get_comments_preview_failure.dart";
import "package:picnic_app/features/posts/domain/model/get_feed_posts_list_failure.dart";
import "package:picnic_app/features/posts/domain/model/get_link_metadata_failure.dart";
import 'package:picnic_app/features/posts/domain/model/get_post_by_id_failure.dart';
import "package:picnic_app/features/posts/domain/model/get_post_collections_failure.dart";
import 'package:picnic_app/features/posts/domain/model/get_sounds_list_failure.dart';
import 'package:picnic_app/features/posts/domain/model/like_unlike_comment_failure.dart';
import "package:picnic_app/features/posts/domain/model/like_unlike_post_failure.dart";
import 'package:picnic_app/features/posts/domain/model/unreact_to_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/unreact_to_post_failure.dart';
import "package:picnic_app/features/posts/domain/model/vote_in_poll_failure.dart";
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';
import "package:picnic_app/features/posts/domain/use_cases/create_comment_use_case.dart";
import "package:picnic_app/features/posts/domain/use_cases/create_post_use_case.dart";
import 'package:picnic_app/features/posts/domain/use_cases/delete_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_comment_by_id_use_case.dart';
import "package:picnic_app/features/posts/domain/use_cases/get_comments_preview_use_case.dart";
import 'package:picnic_app/features/posts/domain/use_cases/get_comments_use_case.dart';
import "package:picnic_app/features/posts/domain/use_cases/get_feed_posts_list_use_case.dart";
import "package:picnic_app/features/posts/domain/use_cases/get_link_metadata_use_case.dart";
import 'package:picnic_app/features/posts/domain/use_cases/get_pinned_comments_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_sounds_list_use_case.dart';
import "package:picnic_app/features/posts/domain/use_cases/like_dislike_post_use_case.dart";
import 'package:picnic_app/features/posts/domain/use_cases/like_unlike_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/pin_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unpin_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_comment_use_case.dart';
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_post_use_case.dart';
import "package:picnic_app/features/posts/domain/use_cases/vote_in_poll_use_case.dart";
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_navigator.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';
import 'package:picnic_app/features/posts/link_post/link_post_initial_params.dart';
import 'package:picnic_app/features/posts/link_post/link_post_navigator.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presenter.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_navigator.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presenter.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presentation_model.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presenter.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import "package:picnic_app/features/posts/post_details/post_details_navigator.dart";
import "package:picnic_app/features/posts/post_details/post_details_presentation_model.dart";
import "package:picnic_app/features/posts/post_details/post_details_presenter.dart";
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_navigator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_share/post_share_navigator.dart';
import 'package:picnic_app/features/posts/posts_list/posts_list_info_provider.dart';
import "package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart";
import "package:picnic_app/features/posts/posts_list/posts_list_navigator.dart";
import "package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart";
import "package:picnic_app/features/posts/posts_list/posts_list_presenter.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presentation_model.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presenter.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_navigator.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_presentation_model.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_presenter.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_navigator.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_presenter.dart";
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_navigator.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presentation_model.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presenter.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';
import 'package:picnic_app/features/posts/text_post/text_post_navigator.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presenter.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_navigator.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presentation_model.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presenter.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_navigator.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presenter.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presenter.dart';
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart";
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_navigator.dart";
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_presentation_model.dart";
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_presenter.dart";

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockTextPostCreationPresenter extends MockCubit<TextPostCreationViewModel> implements TextPostCreationPresenter {}

class MockTextPostCreationPresentationModel extends Mock implements TextPostCreationPresentationModel {}

class MockTextPostCreationInitialParams extends Mock implements TextPostCreationInitialParams {}

class MockTextPostCreationNavigator extends Mock implements TextPostCreationNavigator {}

class MockPostCreationIndexPresenter extends MockCubit<PostCreationIndexViewModel>
    implements PostCreationIndexPresenter {}

class MockPostCreationIndexPresentationModel extends Mock implements PostCreationIndexPresentationModel {}

class MockPostCreationIndexInitialParams extends Mock implements PostCreationIndexInitialParams {}

class MockPostCreationIndexNavigator extends Mock implements PostCreationIndexNavigator {}

class MockLinkPostCreationPresenter extends MockCubit<LinkPostCreationViewModel> implements LinkPostCreationPresenter {}

class MockLinkPostCreationPresentationModel extends Mock implements LinkPostCreationPresentationModel {}

class MockLinkPostCreationInitialParams extends Mock implements LinkPostCreationInitialParams {}

class MockLinkPostCreationNavigator extends Mock implements LinkPostCreationNavigator {}

class MockPollPostCreationPresenter extends MockCubit<PollPostCreationViewModel> implements PollPostCreationPresenter {}

class MockPollPostCreationPresentationModel extends Mock implements PollPostCreationPresentationModel {}

class MockPollPostCreationInitialParams extends Mock implements PollPostCreationInitialParams {}

class MockPollPostCreationNavigator extends Mock implements PollPostCreationNavigator {}

class MockPhotoPostCreationPresenter extends MockCubit<PhotoPostCreationViewModel>
    implements PhotoPostCreationPresenter {}

class MockPhotoPostCreationPresentationModel extends Mock implements PhotoPostCreationPresentationModel {}

class MockPhotoPostCreationInitialParams extends Mock implements PhotoPostCreationInitialParams {}

class MockPhotoPostCreationNavigator extends Mock implements PhotoPostCreationNavigator {}

class MockVideoPostCreationPresenter extends MockCubit<VideoPostCreationViewModel>
    implements VideoPostCreationPresenter {}

class MockVideoPostCreationPresentationModel extends Mock implements VideoPostCreationPresentationModel {}

class MockVideoPostCreationInitialParams extends Mock implements VideoPostCreationInitialParams {}

class MockVideoPostCreationNavigator extends Mock implements VideoPostCreationNavigator {}

class MockImagePostPresenter extends MockCubit<ImagePostViewModel> implements ImagePostPresenter {}

class MockImagePostPresentationModel extends Mock implements ImagePostPresentationModel {}

class MockImagePostInitialParams extends Mock implements ImagePostInitialParams {}

class MockImagePostNavigator extends Mock implements ImagePostNavigator {}

class MockLinkPostPresenter extends MockCubit<LinkPostViewModel> implements LinkPostPresenter {}

class MockLinkPostPresentationModel extends Mock implements LinkPostPresentationModel {}

class MockLinkPostInitialParams extends Mock implements LinkPostInitialParams {}

class MockLinkPostNavigator extends Mock implements LinkPostNavigator {}

class MockPostPollPresenter extends MockCubit<PollPostViewModel> implements PollPostPresenter {}

class MockPostPollPresentationModel extends Mock implements PollPostPresentationModel {}

class MockPostPollInitialParams extends Mock implements PollPostInitialParams {}

class MockPostPollNavigator extends Mock implements PollPostNavigator {}

class MockCommentChatPresenter extends MockCubit<CommentChatViewModel> implements CommentChatPresenter {}

class MockCommentChatPresentationModel extends Mock implements CommentChatPresentationModel {}

class MockCommentChatInitialParams extends Mock implements CommentChatInitialParams {}

class MockCommentChatNavigator extends Mock implements CommentChatNavigator {}

class MockTextPostPresenter extends MockCubit<TextPostViewModel> implements TextPostPresenter {}

class MockTextPostPresentationModel extends Mock implements TextPostPresentationModel {}

class MockTextPostInitialParams extends Mock implements TextPostInitialParams {}

class MockTextPostNavigator extends Mock implements TextPostNavigator {}

class MockPostsListPresenter extends MockCubit<PostsListViewModel> implements PostsListPresenter {}

class MockPostsListPresentationModel extends Mock implements PostsListPresentationModel {}

class MockPostsListInitialParams extends Mock implements PostsListInitialParams {}

class MockPostsListNavigator extends Mock implements PostsListNavigator {}

class MockPostShareNavigator extends Mock implements PostShareNavigator {}

class MockVideoPostPresenter extends MockCubit<VideoPostViewModel> implements VideoPostPresenter {}

class MockVideoPostPresentationModel extends Mock implements VideoPostPresentationModel {}

class MockVideoPostInitialParams extends Mock implements VideoPostInitialParams {}

class MockVideoPostNavigator extends Mock implements VideoPostNavigator {}

class MockSoundAttachmentPresenter extends Mock implements SoundAttachmentPresenter {}

class MockSoundAttachmentPresentationModel extends Mock implements SoundAttachmentPresentationModel {}

class MockSoundAttachmentInitialParams extends Mock implements SoundAttachmentInitialParams {}

class MockSoundAttachmentNavigator extends Mock implements SoundAttachmentNavigator {}

class MockPostOverlayPresenter extends MockCubit<PostOverlayViewModel> implements PostOverlayPresenter {}

class MockPostOverlayPresentationModel extends Mock implements PostOverlayPresentationModel {}

class MockPostOverlayInitialParams extends Mock implements PostOverlayInitialParams {}

class MockPostOverlayNavigator extends Mock implements PostOverlayNavigator {}

class MockPostDetailsPresenter extends MockCubit<PostDetailsViewModel> implements PostDetailsPresenter {}

class MockPostDetailsPresentationModel extends Mock implements PostDetailsPresentationModel {}

class MockPostDetailsInitialParams extends Mock implements PostDetailsInitialParams {}

class MockPostDetailsNavigator extends Mock implements PostDetailsNavigator {}

class MockSelectCirclePresenter extends MockCubit<SelectCircleViewModel> implements SelectCirclePresenter {}

class MockSelectCirclePresentationModel extends Mock implements SelectCirclePresentationModel {}

class MockSelectCircleInitialParams extends Mock implements SelectCircleInitialParams {}

class MockSelectCircleNavigator extends Mock implements SelectCircleNavigator {}

class MockVideoPostRecordingPresenter extends MockCubit<VideoPostRecordingViewModel>
    implements VideoPostRecordingPresenter {}

class MockVideoPostRecordingPresentationModel extends Mock implements VideoPostRecordingPresentationModel {}

class MockVideoPostRecordingInitialParams extends Mock implements VideoPostRecordingInitialParams {}

class MockVideoPostRecordingNavigator extends Mock implements VideoPostRecordingNavigator {}

class MockSingleFeedPresenter extends MockCubit<SingleFeedViewModel> implements SingleFeedPresenter {}

class MockSingleFeedPresentationModel extends Mock implements SingleFeedPresentationModel {}

class MockSingleFeedInitialParams extends Mock implements SingleFeedInitialParams {}

class MockSingleFeedNavigator extends Mock implements SingleFeedNavigator {}

class MockPostUploadingProgressPresenter extends MockCubit<PostUploadingProgressViewModel>
    implements PostUploadingProgressPresenter {}

class MockPostUploadingProgressPresentationModel extends Mock implements PostUploadingProgressPresentationModel {}

class MockPostUploadingProgressInitialParams extends Mock implements PostUploadingProgressInitialParams {}

class MockPostUploadingProgressNavigator extends Mock implements PostUploadingProgressNavigator {}

class MockAfterPostDialogPresenter extends MockCubit<AfterPostDialogViewModel> implements AfterPostDialogPresenter {}

class MockAfterPostDialogPresentationModel extends Mock implements AfterPostDialogPresentationModel {}

class MockAfterPostDialogInitialParams extends Mock implements AfterPostDialogInitialParams {}

class MockAfterPostDialogNavigator extends Mock implements AfterPostDialogNavigator {}

class MockSavePostToCollectionPresenter extends MockCubit<SavePostToCollectionViewModel>
    implements SavePostToCollectionPresenter {}

class MockSavePostToCollectionPresentationModel extends Mock implements SavePostToCollectionPresentationModel {}

class MockSavePostToCollectionInitialParams extends Mock implements SavePostToCollectionInitialParams {}

class MockSavePostToCollectionNavigator extends Mock implements SavePostToCollectionNavigator {}

class MockCreateNewCollectionPresenter extends MockCubit<CreateNewCollectionViewModel>
    implements CreateNewCollectionPresenter {}

class MockCreateNewCollectionPresentationModel extends Mock implements CreateNewCollectionPresentationModel {}

class MockCreateNewCollectionInitialParams extends Mock implements CreateNewCollectionInitialParams {}

class MockCreateNewCollectionNavigator extends Mock implements CreateNewCollectionNavigator {}

class MockUploadMediaPresenter extends MockCubit<UploadMediaViewModel> implements UploadMediaPresenter {}

class MockUploadMediaPresentationModel extends Mock implements UploadMediaPresentationModel {}

class MockUploadMediaInitialParams extends Mock implements UploadMediaInitialParams {}

class MockUploadMediaNavigator extends Mock implements UploadMediaNavigator {}

class MockFullScreenImagePostPresenter extends MockCubit<FullScreenImagePostViewModel>
    implements FullScreenImagePostPresenter {}

class MockFullScreenImagePostPresentationModel extends Mock implements FullScreenImagePostPresentationModel {}

class MockFullScreenImagePostInitialParams extends Mock implements FullScreenImagePostInitialParams {}

class MockFullScreenImagePostNavigator extends Mock implements FullScreenImagePostNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetPostsListFailure extends Mock implements GetFeedPostsListFailure {}

class MockGetPostsListUseCase extends Mock implements GetFeedPostsListUseCase {}

class MockLikeUnlikePostFailure extends Mock implements LikeUnlikePostFailure {}

class MockLikeDislikePostUseCase extends Mock implements LikeDislikePostUseCase {}

class MockGetSoundsListFailure extends Mock implements GetSoundsListFailure {}

class MockGetSoundsListUseCase extends Mock implements GetSoundsListUseCase {}

class MockLikeUnlikeCommentFailure extends Mock implements LikeUnlikeCommentFailure {}

class MockLikeUnlikeCommentUseCase extends Mock implements LikeUnlikeCommentUseCase {}

class MockGetCommentsFailure extends Mock implements GetCommentsFailure {}

class MockGetCommentsUseCase extends Mock implements GetCommentsUseCase {}

class MockGetCommentByIdUseCase extends Mock implements GetCommentByIdUseCase {}

class MockGetLinkMetadataFailure extends Mock implements GetLinkMetadataFailure {}

class MockGetLinkMetadataUseCase extends Mock implements GetLinkMetadataUseCase {}

class MockCreateCommentFailure extends Mock implements CreateCommentFailure {}

class MockCreateCommentUseCase extends Mock implements CreateCommentUseCase {}

class MockCreatePostFailure extends Mock implements CreatePostFailure {}

class MockCreatePostUseCase extends Mock implements CreatePostUseCase {}

class MockGetCommentsPreviewFailure extends Mock implements GetCommentsPreviewFailure {}

class MockGetCommentsPreviewUseCase extends Mock implements GetCommentsPreviewUseCase {}

class MockVoteInPollFailure extends Mock implements VoteInPollFailure {}

class MockVoteInPollUseCase extends Mock implements VoteInPollUseCase {}

class MockGetPostByIdFailure extends Mock implements GetPostByIdFailure {}

class MockGetPostUseCase extends Mock implements GetPostUseCase {}

class MockDeleteCommentFailure extends Mock implements DeleteCommentFailure {}

class MockDeleteCommentUseCase extends Mock implements DeleteCommentUseCase {}

class MockGetPinnedCommentsUseCase extends Mock implements GetPinnedCommentsUseCase {}

class MockPinCommentUseCase extends Mock implements PinCommentUseCase {}

class MockUnpinCommentUseCase extends Mock implements UnpinCommentUseCase {}

class MockGetPostCollectionsFailure extends Mock implements GetPostCollectionsFailure {}

class MockUnreactToPostFailure extends Mock implements UnreactToPostFailure {}

class MockUnreactToPostUseCase extends Mock implements UnreactToPostUseCase {}

class MockUnreactToCommentFailure extends Mock implements UnreactToCommentFailure {}

class MockUnreactToCommentUseCase extends Mock implements UnreactToCommentUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockPostsRepository extends Mock implements PostsRepository {}

class MockCommentsRepository extends Mock implements CommentsRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
class MockGetCommentsQueryGenerator extends Mock implements GetCommentsQueryGenerator {}
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

class MockPostsListInfoProvider extends Mock implements PostsListInfoProvider {}
