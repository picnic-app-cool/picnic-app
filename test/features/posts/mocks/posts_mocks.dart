import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/save_post_input.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';

import '../../../mocks/stubs.dart';
import 'posts_mock_definitions.dart';
//DO-NOT-REMOVE IMPORTS_MOCKS

class PostsMocks {
  // MVP

  static late MockPostsListPresenter postsListPresenter;
  static late MockPostsListPresentationModel postsListPresentationModel;
  static late MockPostsListInitialParams postsListInitialParams;
  static late MockPostsListNavigator postsListNavigator;
  static late MockTextPostCreationPresenter textPostCreationPresenter;
  static late MockTextPostCreationPresentationModel textPostCreationPresentationModel;
  static late MockTextPostCreationInitialParams textPostCreationInitialParams;
  static late MockTextPostCreationNavigator textPostCreationNavigator;
  static late MockPostCreationIndexPresenter postCreationIndexPresenter;
  static late MockPostCreationIndexPresentationModel postCreationIndexPresentationModel;
  static late MockPostCreationIndexInitialParams postCreationIndexInitialParams;
  static late MockPostCreationIndexNavigator postCreationIndexNavigator;
  static late MockLinkPostCreationPresenter linkPostCreationPresenter;
  static late MockLinkPostCreationPresentationModel linkPostCreationPresentationModel;
  static late MockLinkPostCreationInitialParams linkPostCreationInitialParams;
  static late MockLinkPostCreationNavigator linkPostCreationNavigator;
  static late MockPollPostCreationPresenter pollPostCreationPresenter;
  static late MockPollPostCreationPresentationModel pollPostCreationPresentationModel;
  static late MockPollPostCreationInitialParams pollPostCreationInitialParams;
  static late MockPollPostCreationNavigator pollPostCreationNavigator;
  static late MockPhotoPostCreationPresenter photoPostCreationPresenter;
  static late MockPhotoPostCreationPresentationModel photoPostCreationPresentationModel;
  static late MockPhotoPostCreationInitialParams photoPostCreationInitialParams;
  static late MockPhotoPostCreationNavigator photoPostCreationNavigator;
  static late MockVideoPostCreationPresenter videoPostCreationPresenter;
  static late MockVideoPostCreationPresentationModel videoPostCreationPresentationModel;
  static late MockVideoPostCreationInitialParams videoPostCreationInitialParams;
  static late MockVideoPostCreationNavigator videoPostCreationNavigator;
  static late MockImagePostPresenter postFeedPresenter;
  static late MockImagePostPresentationModel postFeedPresentationModel;
  static late MockImagePostInitialParams postFeedInitialParams;
  static late MockImagePostNavigator postFeedNavigator;
  static late MockLinkPostPresenter linkPostPresenter;
  static late MockLinkPostPresentationModel linkPostPresentationModel;
  static late MockLinkPostInitialParams linkPostInitialParams;
  static late MockLinkPostNavigator linkPostNavigator;
  static late MockCommentChatPresenter commentChatPresenter;
  static late MockCommentChatPresentationModel commentChatPresentationModel;
  static late MockCommentChatInitialParams commentChatInitialParams;
  static late MockCommentChatNavigator commentChatNavigator;
  static late MockPostPollPresenter postPollPresenter;
  static late MockPostPollPresentationModel postPollPresentationModel;
  static late MockPostPollInitialParams postPollInitialParams;
  static late MockPostPollNavigator postPollNavigator;
  static late MockTextPostPresenter textPostPresenter;
  static late MockTextPostPresentationModel textPostPresentationModel;
  static late MockTextPostInitialParams textPostInitialParams;
  static late MockTextPostNavigator textPostNavigator;
  static late MockVideoPostPresenter videoPostPresenter;
  static late MockVideoPostPresentationModel videoPostPresentationModel;
  static late MockVideoPostInitialParams videoPostInitialParams;
  static late MockVideoPostNavigator videoPostNavigator;
  static late MockSoundAttachmentPresenter soundAttachmentPresenter;
  static late MockSoundAttachmentPresentationModel soundAttachmentPresentationModel;
  static late MockSoundAttachmentInitialParams soundAttachmentInitialParams;
  static late MockSoundAttachmentNavigator soundAttachmentNavigator;
  static late MockPostOverlayPresenter postOverlayPresenter;
  static late MockPostOverlayPresentationModel postOverlayPresentationModel;
  static late MockPostOverlayInitialParams postOverlayInitialParams;
  static late MockPostOverlayNavigator postOverlayNavigator;

  static late MockPostDetailsPresenter postDetailsPresenter;
  static late MockPostDetailsPresentationModel postDetailsPresentationModel;
  static late MockPostDetailsInitialParams postDetailsInitialParams;
  static late MockPostDetailsNavigator postDetailsNavigator;

  static late MockSelectCirclePresenter selectCirclePresenter;
  static late MockSelectCirclePresentationModel selectCirclePresentationModel;
  static late MockSelectCircleInitialParams selectCircleInitialParams;
  static late MockSelectCircleNavigator selectCircleNavigator;

  static late MockVideoPostRecordingPresenter videoPostRecordingPresenter;
  static late MockVideoPostRecordingPresentationModel videoPostRecordingPresentationModel;
  static late MockVideoPostRecordingInitialParams videoPostRecordingInitialParams;
  static late MockVideoPostRecordingNavigator videoPostRecordingNavigator;

  static late MockPostUploadingProgressPresenter postUploadingProgressPresenter;
  static late MockPostUploadingProgressPresentationModel postUploadingProgressPresentationModel;
  static late MockPostUploadingProgressInitialParams postUploadingProgressInitialParams;
  static late MockPostUploadingProgressNavigator postUploadingProgressNavigator;

  static late MockAfterPostDialogPresenter afterPostDialogPresenter;
  static late MockAfterPostDialogPresentationModel afterPostDialogPresentationModel;
  static late MockAfterPostDialogInitialParams afterPostDialogInitialParams;
  static late MockAfterPostDialogNavigator afterPostDialogNavigator;

  static late MockSingleFeedPresenter singleFeedPresenter;
  static late MockSingleFeedPresentationModel singleFeedPresentationModel;
  static late MockSingleFeedInitialParams singleFeedInitialParams;
  static late MockSingleFeedNavigator singleFeedNavigator;

  static late MockSavePostToCollectionPresenter savePostToCollectionPresenter;
  static late MockSavePostToCollectionPresentationModel savePostToCollectionPresentationModel;
  static late MockSavePostToCollectionInitialParams savePostToCollectionInitialParams;
  static late MockSavePostToCollectionNavigator savePostToCollectionNavigator;

  static late MockCreateNewCollectionPresenter createNewCollectionPresenter;
  static late MockCreateNewCollectionPresentationModel createNewCollectionPresentationModel;
  static late MockCreateNewCollectionInitialParams createNewCollectionInitialParams;
  static late MockCreateNewCollectionNavigator createNewCollectionNavigator;

  static late MockUploadMediaPresenter uploadMediaPresenter;
  static late MockUploadMediaPresentationModel uploadMediaPresentationModel;
  static late MockUploadMediaInitialParams uploadMediaInitialParams;
  static late MockUploadMediaNavigator uploadMediaNavigator;

  static late MockFullScreenImagePostPresenter fullScreenImagePostPresenter;
  static late MockFullScreenImagePostPresentationModel fullScreenImagePostPresentationModel;
  static late MockFullScreenImagePostInitialParams fullScreenImagePostInitialParams;
  static late MockFullScreenImagePostNavigator fullScreenImagePostNavigator;

//DO-NOT-REMOVE MVP_MOCKS_STATIC_FIELD

  // USE CASES

  static late MockGetPostsListFailure getPostsListFailure;
  static late MockGetPostsListUseCase getPostsListUseCase;

  static late MockLikeUnlikePostFailure likeUnlikePostFailure;
  static late MockLikeDislikePostUseCase likeUnlikePostUseCase;

  static late MockGetSoundsListFailure getSoundsListFailure;
  static late MockGetSoundsListUseCase getSoundsListUseCase;

  static late MockLikeUnlikeCommentFailure likeUnlikeCommentFailure;
  static late MockLikeUnlikeCommentUseCase likeUnlikeCommentUseCase;

  static late MockGetCommentsFailure getCommentsFailure;
  static late MockGetCommentsUseCase getCommentsUseCase;
  static late MockGetCommentByIdUseCase getCommentByIdUseCase;

  static late MockGetLinkMetadataFailure getLinkMetadataFailure;
  static late MockGetLinkMetadataUseCase getLinkMetadataUseCase;

  static late MockCreateCommentFailure createCommentFailure;
  static late MockCreateCommentUseCase createCommentUseCase;

  static late MockCreatePostFailure createPostFailure;
  static late MockCreatePostUseCase createPostUseCase;

  static late MockGetCommentsPreviewFailure getCommentsPreviewFailure;
  static late MockGetCommentsPreviewUseCase getCommentsPreviewUseCase;

  static late MockVoteInPollFailure voteInPollFailure;
  static late MockVoteInPollUseCase voteInPollUseCase;

  static late MockGetPostUseCase getPostUseCase;
  static late MockGetPostByIdFailure getPostByIdFailure;
  static late MockGetPostCollectionsFailure getPostCollectionsFailure;

  static late MockDeleteCommentFailure deleteCommentFailure;
  static late MockDeleteCommentUseCase deleteCommentUseCase;

  static late MockGetPinnedCommentsUseCase getPinnedCommentsUseCase;
  static late MockPinCommentUseCase pinCommentUseCase;
  static late MockUnpinCommentUseCase unpinCommentUseCase;

  static late MockUnreactToPostFailure unreactToPostFailure;
  static late MockUnreactToPostUseCase unreactToPostUseCase;

  static late MockUnreactToCommentFailure unreactToCommentFailure;
  static late MockUnreactToCommentUseCase unreactToCommentUseCase;

//DO-NOT-REMOVE USE_CASE_MOCKS_STATIC_FIELD

  // REPOSITORIES
  static late MockPostsRepository postsRepository;
  static late MockCommentsRepository commentsRepository;
  static late MockPostsListInfoProvider postsListInfoProvider;

//DO-NOT-REMOVE REPOSITORIES_MOCKS_STATIC_FIELD

  // STORES
  static late MockGetCommentsQueryGenerator getCommentsQueryGenerator;

  //DO-NOT-REMOVE STORES_MOCKS_STATIC_FIELD

  static void init() {
    _initMocks();
    _initFallbacks();
  }

  static void _initMocks() {
    //DO-NOT-REMOVE FEATURES_MOCKS
    // MVP
    textPostCreationPresenter = MockTextPostCreationPresenter();
    textPostCreationPresentationModel = MockTextPostCreationPresentationModel();
    textPostCreationInitialParams = MockTextPostCreationInitialParams();
    textPostCreationNavigator = MockTextPostCreationNavigator();
    postCreationIndexPresenter = MockPostCreationIndexPresenter();
    postCreationIndexPresentationModel = MockPostCreationIndexPresentationModel();
    postCreationIndexInitialParams = MockPostCreationIndexInitialParams();
    postCreationIndexNavigator = MockPostCreationIndexNavigator();
    linkPostCreationPresenter = MockLinkPostCreationPresenter();
    linkPostCreationPresentationModel = MockLinkPostCreationPresentationModel();
    linkPostCreationInitialParams = MockLinkPostCreationInitialParams();
    linkPostCreationNavigator = MockLinkPostCreationNavigator();
    pollPostCreationPresenter = MockPollPostCreationPresenter();
    pollPostCreationPresentationModel = MockPollPostCreationPresentationModel();
    pollPostCreationInitialParams = MockPollPostCreationInitialParams();
    pollPostCreationNavigator = MockPollPostCreationNavigator();
    photoPostCreationPresenter = MockPhotoPostCreationPresenter();
    photoPostCreationPresentationModel = MockPhotoPostCreationPresentationModel();
    photoPostCreationInitialParams = MockPhotoPostCreationInitialParams();
    photoPostCreationNavigator = MockPhotoPostCreationNavigator();
    videoPostCreationPresenter = MockVideoPostCreationPresenter();
    videoPostCreationPresentationModel = MockVideoPostCreationPresentationModel();
    videoPostCreationInitialParams = MockVideoPostCreationInitialParams();
    videoPostCreationNavigator = MockVideoPostCreationNavigator();
    postFeedPresenter = MockImagePostPresenter();
    postFeedPresentationModel = MockImagePostPresentationModel();
    postFeedInitialParams = MockImagePostInitialParams();
    postFeedNavigator = MockImagePostNavigator();
    linkPostPresenter = MockLinkPostPresenter();
    linkPostPresentationModel = MockLinkPostPresentationModel();
    linkPostInitialParams = MockLinkPostInitialParams();
    linkPostNavigator = MockLinkPostNavigator();
    commentChatPresenter = MockCommentChatPresenter();
    commentChatPresentationModel = MockCommentChatPresentationModel();
    commentChatInitialParams = MockCommentChatInitialParams();
    commentChatNavigator = MockCommentChatNavigator();
    postPollPresenter = MockPostPollPresenter();
    postPollPresentationModel = MockPostPollPresentationModel();
    postPollInitialParams = MockPostPollInitialParams();
    postPollNavigator = MockPostPollNavigator();
    textPostPresenter = MockTextPostPresenter();
    textPostPresentationModel = MockTextPostPresentationModel();
    textPostInitialParams = MockTextPostInitialParams();
    textPostNavigator = MockTextPostNavigator();
    videoPostPresenter = MockVideoPostPresenter();
    videoPostPresentationModel = MockVideoPostPresentationModel();
    videoPostInitialParams = MockVideoPostInitialParams();
    videoPostNavigator = MockVideoPostNavigator();
    postsListPresenter = MockPostsListPresenter();
    postsListPresentationModel = MockPostsListPresentationModel();
    postsListInitialParams = MockPostsListInitialParams();
    postsListNavigator = MockPostsListNavigator();
    soundAttachmentPresenter = MockSoundAttachmentPresenter();
    soundAttachmentPresentationModel = MockSoundAttachmentPresentationModel();
    soundAttachmentInitialParams = MockSoundAttachmentInitialParams();
    soundAttachmentNavigator = MockSoundAttachmentNavigator();
    postOverlayPresenter = MockPostOverlayPresenter();
    postOverlayPresentationModel = MockPostOverlayPresentationModel();
    postOverlayInitialParams = MockPostOverlayInitialParams();
    postOverlayNavigator = MockPostOverlayNavigator();
    postDetailsPresenter = MockPostDetailsPresenter();
    postDetailsPresentationModel = MockPostDetailsPresentationModel();
    postDetailsInitialParams = MockPostDetailsInitialParams();
    postDetailsNavigator = MockPostDetailsNavigator();

    selectCirclePresenter = MockSelectCirclePresenter();
    selectCirclePresentationModel = MockSelectCirclePresentationModel();
    selectCircleInitialParams = MockSelectCircleInitialParams();
    selectCircleNavigator = MockSelectCircleNavigator();

    videoPostRecordingPresenter = MockVideoPostRecordingPresenter();
    videoPostRecordingPresentationModel = MockVideoPostRecordingPresentationModel();
    videoPostRecordingInitialParams = MockVideoPostRecordingInitialParams();
    videoPostRecordingNavigator = MockVideoPostRecordingNavigator();

    singleFeedPresenter = MockSingleFeedPresenter();
    singleFeedPresentationModel = MockSingleFeedPresentationModel();
    singleFeedInitialParams = MockSingleFeedInitialParams();
    singleFeedNavigator = MockSingleFeedNavigator();

    postUploadingProgressPresenter = MockPostUploadingProgressPresenter();
    postUploadingProgressPresentationModel = MockPostUploadingProgressPresentationModel();
    postUploadingProgressInitialParams = MockPostUploadingProgressInitialParams();
    postUploadingProgressNavigator = MockPostUploadingProgressNavigator();

    afterPostDialogPresenter = MockAfterPostDialogPresenter();
    afterPostDialogPresentationModel = MockAfterPostDialogPresentationModel();
    afterPostDialogInitialParams = MockAfterPostDialogInitialParams();
    afterPostDialogNavigator = MockAfterPostDialogNavigator();

    savePostToCollectionPresenter = MockSavePostToCollectionPresenter();
    savePostToCollectionPresentationModel = MockSavePostToCollectionPresentationModel();
    savePostToCollectionInitialParams = MockSavePostToCollectionInitialParams();
    savePostToCollectionNavigator = MockSavePostToCollectionNavigator();

    createNewCollectionPresenter = MockCreateNewCollectionPresenter();
    createNewCollectionPresentationModel = MockCreateNewCollectionPresentationModel();
    createNewCollectionInitialParams = MockCreateNewCollectionInitialParams();
    createNewCollectionNavigator = MockCreateNewCollectionNavigator();

    fullScreenImagePostPresenter = MockFullScreenImagePostPresenter();
    fullScreenImagePostPresentationModel = MockFullScreenImagePostPresentationModel();
    fullScreenImagePostInitialParams = MockFullScreenImagePostInitialParams();
    fullScreenImagePostNavigator = MockFullScreenImagePostNavigator();

//DO-NOT-REMOVE MVP_INIT_MOCKS

    // USE CASES
    getPostsListFailure = MockGetPostsListFailure();
    getPostsListUseCase = MockGetPostsListUseCase();
    likeUnlikePostFailure = MockLikeUnlikePostFailure();
    likeUnlikePostUseCase = MockLikeDislikePostUseCase();

    getSoundsListFailure = MockGetSoundsListFailure();
    getSoundsListUseCase = MockGetSoundsListUseCase();

    likeUnlikeCommentFailure = MockLikeUnlikeCommentFailure();
    likeUnlikeCommentUseCase = MockLikeUnlikeCommentUseCase();

    getCommentsFailure = MockGetCommentsFailure();
    getCommentsUseCase = MockGetCommentsUseCase();
    getCommentByIdUseCase = MockGetCommentByIdUseCase();

    getLinkMetadataFailure = MockGetLinkMetadataFailure();
    getLinkMetadataUseCase = MockGetLinkMetadataUseCase();

    createCommentFailure = MockCreateCommentFailure();
    createCommentUseCase = MockCreateCommentUseCase();

    createPostFailure = MockCreatePostFailure();
    createPostUseCase = MockCreatePostUseCase();

    getCommentsPreviewFailure = MockGetCommentsPreviewFailure();
    getCommentsPreviewUseCase = MockGetCommentsPreviewUseCase();

    voteInPollFailure = MockVoteInPollFailure();
    voteInPollUseCase = MockVoteInPollUseCase();

    getPostUseCase = MockGetPostUseCase();
    getPostByIdFailure = MockGetPostByIdFailure();

    deleteCommentFailure = MockDeleteCommentFailure();
    deleteCommentUseCase = MockDeleteCommentUseCase();

    getPinnedCommentsUseCase = MockGetPinnedCommentsUseCase();
    pinCommentUseCase = MockPinCommentUseCase();
    unpinCommentUseCase = MockUnpinCommentUseCase();

    getPostCollectionsFailure = MockGetPostCollectionsFailure();

    unreactToPostFailure = MockUnreactToPostFailure();
    unreactToPostUseCase = MockUnreactToPostUseCase();

    unreactToCommentFailure = MockUnreactToCommentFailure();
    unreactToCommentUseCase = MockUnreactToCommentUseCase();

//DO-NOT-REMOVE USE_CASE_INIT_MOCKS

    // REPOSITORIES
    postsRepository = MockPostsRepository();
    commentsRepository = MockCommentsRepository();
//DO-NOT-REMOVE REPOSITORIES_INIT_MOCKS

    // STORES
    getCommentsQueryGenerator = MockGetCommentsQueryGenerator();
    //DO-NOT-REMOVE STORES_INIT_MOCKS
    postsListInfoProvider = MockPostsListInfoProvider();
  }

  static void _initFallbacks() {
    //DO-NOT-REMOVE FEATURES_FALLBACKS
    // MVP
    registerFallbackValue(MockSelectCircleInitialParams());
    registerFallbackValue(MockTextPostCreationPresenter());
    registerFallbackValue(MockTextPostCreationPresentationModel());
    registerFallbackValue(MockTextPostCreationInitialParams());
    registerFallbackValue(MockTextPostCreationNavigator());
    registerFallbackValue(MockPostCreationIndexPresenter());
    registerFallbackValue(MockPostCreationIndexPresentationModel());
    registerFallbackValue(MockPostCreationIndexInitialParams());
    registerFallbackValue(MockPostCreationIndexNavigator());
    registerFallbackValue(MockLinkPostCreationPresenter());
    registerFallbackValue(MockLinkPostCreationPresentationModel());
    registerFallbackValue(MockLinkPostCreationInitialParams());
    registerFallbackValue(MockLinkPostCreationNavigator());
    registerFallbackValue(MockPollPostCreationPresenter());
    registerFallbackValue(MockPollPostCreationPresentationModel());
    registerFallbackValue(MockPollPostCreationInitialParams());
    registerFallbackValue(MockPollPostCreationNavigator());
    registerFallbackValue(MockPhotoPostCreationPresenter());
    registerFallbackValue(MockPhotoPostCreationPresentationModel());
    registerFallbackValue(MockPhotoPostCreationInitialParams());
    registerFallbackValue(MockPhotoPostCreationNavigator());
    registerFallbackValue(MockVideoPostCreationPresenter());
    registerFallbackValue(MockVideoPostCreationPresentationModel());
    registerFallbackValue(MockVideoPostCreationInitialParams());
    registerFallbackValue(MockVideoPostCreationNavigator());
    registerFallbackValue(MockImagePostPresenter());
    registerFallbackValue(MockImagePostPresentationModel());
    registerFallbackValue(MockImagePostInitialParams());
    registerFallbackValue(MockImagePostNavigator());
    registerFallbackValue(MockLinkPostPresenter());
    registerFallbackValue(MockLinkPostPresentationModel());
    registerFallbackValue(MockLinkPostInitialParams());
    registerFallbackValue(MockLinkPostNavigator());
    registerFallbackValue(MockCommentChatPresenter());
    registerFallbackValue(MockCommentChatPresentationModel());
    registerFallbackValue(MockCommentChatInitialParams());
    registerFallbackValue(MockCommentChatNavigator());
    registerFallbackValue(MockPostPollPresenter());
    registerFallbackValue(MockPostPollPresentationModel());
    registerFallbackValue(MockPostPollInitialParams());
    registerFallbackValue(MockPostPollNavigator());
    registerFallbackValue(MockTextPostPresenter());
    registerFallbackValue(MockTextPostPresentationModel());
    registerFallbackValue(MockTextPostInitialParams());
    registerFallbackValue(MockTextPostNavigator());
    registerFallbackValue(MockVideoPostPresenter());
    registerFallbackValue(MockVideoPostPresentationModel());
    registerFallbackValue(MockVideoPostInitialParams());
    registerFallbackValue(MockVideoPostNavigator());
    registerFallbackValue(MockPostsListPresenter());
    registerFallbackValue(MockPostsListPresentationModel());
    registerFallbackValue(MockPostsListInitialParams());
    registerFallbackValue(MockPostsListNavigator());
    registerFallbackValue(MockPostOverlayPresenter());
    registerFallbackValue(MockPostOverlayPresentationModel());
    registerFallbackValue(MockPostOverlayInitialParams());
    registerFallbackValue(MockPostOverlayNavigator());

    registerFallbackValue(MockPostDetailsPresenter());
    registerFallbackValue(MockPostDetailsPresentationModel());
    registerFallbackValue(MockPostDetailsInitialParams());
    registerFallbackValue(MockPostDetailsNavigator());

    registerFallbackValue(MockSelectCirclePresenter());
    registerFallbackValue(MockSelectCirclePresentationModel());
    registerFallbackValue(MockSelectCircleInitialParams());
    registerFallbackValue(MockSelectCircleNavigator());

    registerFallbackValue(MockVideoPostRecordingPresenter());
    registerFallbackValue(MockVideoPostRecordingPresentationModel());
    registerFallbackValue(MockVideoPostRecordingInitialParams());
    registerFallbackValue(MockVideoPostRecordingNavigator());

    registerFallbackValue(MockSingleFeedPresenter());
    registerFallbackValue(MockSingleFeedPresentationModel());
    registerFallbackValue(MockSingleFeedInitialParams());
    registerFallbackValue(MockSingleFeedNavigator());

    registerFallbackValue(MockAfterPostDialogPresenter());
    registerFallbackValue(MockAfterPostDialogPresentationModel());
    registerFallbackValue(MockAfterPostDialogInitialParams());
    registerFallbackValue(MockAfterPostDialogNavigator());

    registerFallbackValue(MockSavePostToCollectionPresenter());
    registerFallbackValue(MockSavePostToCollectionPresentationModel());
    registerFallbackValue(MockSavePostToCollectionInitialParams());
    registerFallbackValue(MockSavePostToCollectionNavigator());

    registerFallbackValue(MockCreateNewCollectionPresenter());
    registerFallbackValue(MockCreateNewCollectionPresentationModel());
    registerFallbackValue(MockCreateNewCollectionInitialParams());
    registerFallbackValue(MockCreateNewCollectionNavigator());

    registerFallbackValue(MockFullScreenImagePostPresenter());
    registerFallbackValue(MockFullScreenImagePostPresentationModel());
    registerFallbackValue(MockFullScreenImagePostInitialParams());
    registerFallbackValue(MockFullScreenImagePostNavigator());

//DO-NOT-REMOVE MVP_MOCK_FALLBACK_VALUE

    // USE CASES
    registerFallbackValue(MockGetPostsListFailure());
    registerFallbackValue(MockGetPostsListUseCase());
    registerFallbackValue(MockLikeUnlikePostFailure());
    registerFallbackValue(MockLikeDislikePostUseCase());
    registerFallbackValue(MockLikeUnlikeCommentFailure());
    registerFallbackValue(MockLikeUnlikeCommentUseCase());
    registerFallbackValue(MockGetCommentsFailure());
    registerFallbackValue(MockGetCommentsUseCase());
    registerFallbackValue(MockGetCommentByIdUseCase());

    registerFallbackValue(MockGetLinkMetadataFailure());
    registerFallbackValue(MockGetLinkMetadataUseCase());

    registerFallbackValue(MockCreateCommentFailure());
    registerFallbackValue(MockCreateCommentUseCase());

    registerFallbackValue(MockCreatePostFailure());
    registerFallbackValue(MockCreatePostUseCase());

    registerFallbackValue(MockGetCommentsPreviewFailure());
    registerFallbackValue(MockGetCommentsPreviewUseCase());

    registerFallbackValue(MockVoteInPollFailure());
    registerFallbackValue(MockVoteInPollUseCase());

    registerFallbackValue(MockGetPostUseCase());
    registerFallbackValue(MockGetPostByIdFailure());

    registerFallbackValue(MockDeleteCommentFailure());
    registerFallbackValue(MockDeleteCommentUseCase());

    registerFallbackValue(MockGetPostCollectionsFailure());

    registerFallbackValue(MockUnreactToPostFailure());
    registerFallbackValue(MockUnreactToPostUseCase());

    registerFallbackValue(MockUnreactToCommentFailure());
    registerFallbackValue(MockUnreactToCommentUseCase());

//DO-NOT-REMOVE USE_CASE_MOCK_FALLBACK_VALUE

    // REPOSITORIES
    registerFallbackValue(MockPostsRepository());
    registerFallbackValue(MockCommentsRepository());
//DO-NOT-REMOVE REPOSITORIES_MOCK_FALLBACK_VALUE

    // STORES
    registerFallbackValue(MockGetCommentsQueryGenerator());
    //DO-NOT-REMOVE STORES_MOCK_FALLBACK_VALUE

    registerFallbackValue(Stubs.feed);
    registerFallbackValue(const Id('1234'));
    registerFallbackValue(const Cursor.firstPage());
    registerFallbackValue('searchQuery');
    registerFallbackValue(const CreatePostInput.empty());
    registerFallbackValue(MockPostsListInfoProvider());
    registerFallbackValue(const SavePostInput.empty());
    registerFallbackValue(const Post.empty());
    registerFallbackValue(const BasicCircle.empty());
    registerFallbackValue(const VoteInPollInput.empty());
    registerFallbackValue(MockUploadMediaInitialParams());
  }
}
