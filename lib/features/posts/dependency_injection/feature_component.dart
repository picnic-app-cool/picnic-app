import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_initial_params.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_navigator.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_page.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presentation_model.dart';
import 'package:picnic_app/features/posts/after_post/after_post_dialog_presenter.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_initial_params.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_navigator.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_page.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_presentation_model.dart';
import 'package:picnic_app/features/posts/choose_media/choose_media_presenter.dart';
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_navigator.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_page.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_presentation_model.dart";
import "package:picnic_app/features/posts/create_new_collection/create_new_collection_presenter.dart";
import 'package:picnic_app/features/posts/data/get_comments_query_generator.dart';
import 'package:picnic_app/features/posts/data/graphql_comments_repository.dart';
import 'package:picnic_app/features/posts/data/graphql_posts_repository.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:picnic_app/features/posts/domain/stores/video_mute_store.dart';
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
import 'package:picnic_app/features/posts/domain/use_cases/unreact_to_post_use_case.dart';
import "package:picnic_app/features/posts/domain/use_cases/vote_in_poll_use_case.dart";
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_initial_params.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_navigator.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_page.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/full_screen_image/full_screen_image_post_presenter.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_page.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post_creation/link_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_page.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_page.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post_creation/poll_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_navigator.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_page.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presentation_model.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_presenter.dart';
import 'package:picnic_app/features/posts/post_details/post_details_initial_params.dart';
import "package:picnic_app/features/posts/post_details/post_details_navigator.dart";
import "package:picnic_app/features/posts/post_details/post_details_page.dart";
import "package:picnic_app/features/posts/post_details/post_details_presentation_model.dart";
import "package:picnic_app/features/posts/post_details/post_details_presenter.dart";
import 'package:picnic_app/features/posts/post_overlay/post_overlay_initial_params.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_navigator.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_page.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presentation_model.dart';
import 'package:picnic_app/features/posts/post_overlay/post_overlay_presenter.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_navigator.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presentation_model.dart';
import 'package:picnic_app/features/posts/post_share/post_share_presenter.dart';
import "package:picnic_app/features/posts/posts_list/posts_list_initial_params.dart";
import "package:picnic_app/features/posts/posts_list/posts_list_navigator.dart";
import "package:picnic_app/features/posts/posts_list/posts_list_presentation_model.dart";
import "package:picnic_app/features/posts/posts_list/posts_list_presenter.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_page.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presentation_model.dart";
import "package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presenter.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_initial_params.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_navigator.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_page.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_presentation_model.dart";
import "package:picnic_app/features/posts/select_circle/select_circle_presenter.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_initial_params.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_navigator.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_page.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_presentation_model.dart";
import "package:picnic_app/features/posts/single_feed/single_feed_presenter.dart";
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_initial_params.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_navigator.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_page.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presentation_model.dart';
import 'package:picnic_app/features/posts/sound_attachment/sound_attachment_presenter.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_page.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_creation/text_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_initial_params.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_navigator.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_page.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presentation_model.dart';
import 'package:picnic_app/features/posts/upload_media/upload_media_presenter.dart';
import 'package:picnic_app/features/posts/video_post/horizontal_video_overlay.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_initial_params.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_navigator.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_page.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post_creation/video_post_creation_presenter.dart';
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_initial_params.dart";
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_navigator.dart";
import 'package:picnic_app/features/posts/video_post_recording/video_post_recording_page.dart';
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_presentation_model.dart";
import "package:picnic_app/features/posts/video_post_recording/video_post_recording_presenter.dart";
//DO-NOT-REMOVE APP_COMPONENT_IMPORTS

/// registers all the dependencies in dependency graph in get_it package
void configureDependencies() {
  _configureGeneralDependencies();
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
}

//ignore: long-method
void _configureGeneralDependencies() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<GetCommentsQueryGenerator>(
          () => const GetCommentsQueryGenerator(),
        )
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<PostsRepository>(
          () => GraphQlPostsRepository(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CommentsRepository>(
          () => GraphQlCommentsRepository(
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE REPOSITORIES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureStores() {
  // ignore: unnecessary_statements
  getIt
        ..registerLazySingleton<VideoMuteStore>(
          () => VideoMuteStore(),
        )
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<GetFeedPostsListUseCase>(
          () => GetFeedPostsListUseCase(getIt()),
        )
        ..registerFactory<LikeDislikePostUseCase>(
          () => LikeDislikePostUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<GetSoundsListUseCase>(
          () => GetSoundsListUseCase(getIt()),
        )
        ..registerFactory<LikeUnlikeCommentUseCase>(
          () => LikeUnlikeCommentUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<GetCommentsUseCase>(
          () => GetCommentsUseCase(getIt()),
        )
        ..registerFactory<GetCommentByIdUseCase>(
          () => GetCommentByIdUseCase(getIt()),
        )
        ..registerFactory<GetLinkMetadataUseCase>(
          () => GetLinkMetadataUseCase(
            getIt(),
          ),
        )
        ..registerFactory<CreateCommentUseCase>(
          () => CreateCommentUseCase(
            getIt(),
          ),
        )
        ..registerFactory<CreatePostUseCase>(
          () => CreatePostUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCommentsPreviewUseCase>(
          () => GetCommentsPreviewUseCase(
            getIt(),
          ),
        )
        ..registerFactory<VoteInPollUseCase>(
          () => VoteInPollUseCase(getIt()),
        )
        ..registerFactory<GetPostUseCase>(
          () => GetPostUseCase(getIt()),
        )
        ..registerFactory<DeleteCommentUseCase>(
          () => DeleteCommentUseCase(getIt()),
        )
        ..registerFactory<GetPinnedCommentsUseCase>(
          () => GetPinnedCommentsUseCase(getIt()),
        )
        ..registerFactory<PinCommentUseCase>(
          () => PinCommentUseCase(getIt()),
        )
        ..registerFactory<UnpinCommentUseCase>(
          () => UnpinCommentUseCase(getIt()),
        )
        ..registerFactory<UnreactToPostUseCase>(
          () => UnreactToPostUseCase(
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE USE_CASES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureMvp() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<ChooseMediaNavigator>(
          () => ChooseMediaNavigator(getIt()),
        )
        ..registerFactoryParam<ChooseMediaPresentationModel, ChooseMediaInitialParams, dynamic>(
          (params, _) => ChooseMediaPresentationModel.initial(params),
        )
        ..registerFactoryParam<ChooseMediaPresenter, ChooseMediaInitialParams, dynamic>(
          (params, _) => ChooseMediaPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<ChooseMediaPage, ChooseMediaInitialParams, dynamic>(
          (params, _) => ChooseMediaPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<TextPostCreationNavigator>(
          () => TextPostCreationNavigator(getIt()),
        )
        ..registerFactoryParam<TextPostCreationPresentationModel, TextPostCreationInitialParams, dynamic>(
          (params, _) => TextPostCreationPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<TextPostCreationPresenter, TextPostCreationInitialParams, dynamic>(
          (initialParams, _) => TextPostCreationPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<TextPostCreationPage, TextPostCreationInitialParams, dynamic>(
          (initialParams, _) => TextPostCreationPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<LinkPostCreationNavigator>(
          () => LinkPostCreationNavigator(getIt()),
        )
        ..registerFactoryParam<LinkPostCreationPresentationModel, LinkPostCreationInitialParams, dynamic>(
          (params, _) => LinkPostCreationPresentationModel.initial(params),
        )
        ..registerFactoryParam<LinkPostCreationPresenter, LinkPostCreationInitialParams, dynamic>(
          (initialParams, _) => LinkPostCreationPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<LinkPostCreationPage, LinkPostCreationInitialParams, dynamic>(
          (initialParams, _) => LinkPostCreationPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PostCreationIndexNavigator>(
          () => PostCreationIndexNavigator(getIt()),
        )
        ..registerFactoryParam<PostCreationIndexPresentationModel, PostCreationIndexInitialParams, dynamic>(
          (params, _) => PostCreationIndexPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<PostCreationIndexPresenter, PostCreationIndexInitialParams, dynamic>(
          (initialParams, _) => PostCreationIndexPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PostCreationIndexPage, PostCreationIndexInitialParams, dynamic>(
          (initialParams, _) {
            return PostCreationIndexPage(
              presenter: getIt(param1: initialParams),
            );
          },
        )
        ..registerFactory<PollPostCreationNavigator>(
          () => PollPostCreationNavigator(getIt()),
        )
        ..registerFactoryParam<PollPostCreationPresentationModel, PollPostCreationInitialParams, dynamic>(
          (params, _) => PollPostCreationPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<PollPostCreationPresenter, PollPostCreationInitialParams, dynamic>(
          (initialParams, _) => PollPostCreationPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PollPostCreationPage, PollPostCreationInitialParams, dynamic>(
          (initialParams, _) => PollPostCreationPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PhotoPostCreationNavigator>(
          () => PhotoPostCreationNavigator(
            getIt(),
          ),
        )
        ..registerFactoryParam<PhotoPostCreationPresentationModel, PhotoPostCreationInitialParams, dynamic>(
          (params, _) => PhotoPostCreationPresentationModel.initial(params),
        )
        ..registerFactoryParam<PhotoPostCreationPresenter, PhotoPostCreationInitialParams, dynamic>(
          (initialParams, _) => PhotoPostCreationPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PhotoPostCreationPage, PhotoPostCreationInitialParams, dynamic>(
          (initialParams, _) => PhotoPostCreationPage(
            presenter: getIt(param1: initialParams),
            cameraController: initialParams.cameraController,
          ),
        )
        ..registerFactory<VideoPostCreationNavigator>(
          () => VideoPostCreationNavigator(getIt()),
        )
        ..registerFactoryParam<VideoPostCreationPresentationModel, VideoPostCreationInitialParams, dynamic>(
          (params, _) => VideoPostCreationPresentationModel.initial(params),
        )
        ..registerFactoryParam<VideoPostCreationPresenter, VideoPostCreationInitialParams, dynamic>(
          (initialParams, _) => VideoPostCreationPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<VideoPostCreationPage, VideoPostCreationInitialParams, dynamic>(
          (initialParams, _) => VideoPostCreationPage(
            presenter: getIt(param1: initialParams),
            cameraController: initialParams.cameraController,
          ),
        )
        ..registerFactory<PostsListNavigator>(
          () => PostsListNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<PostsListPresentationModel, PostsListInitialParams, dynamic>(
          (params, _) => PostsListPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<PostsListPresenter, PostsListInitialParams, dynamic>(
          (params, _) => PostsListPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<SoundAttachmentNavigator>(
          () => SoundAttachmentNavigator(getIt()),
        )
        ..registerFactoryParam<SoundAttachmentViewModel, SoundAttachmentInitialParams, dynamic>(
          (params, _) => SoundAttachmentPresentationModel.initial(params),
        )
        ..registerFactoryParam<SoundAttachmentPresenter, SoundAttachmentInitialParams, dynamic>(
          (params, _) => SoundAttachmentPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SoundAttachmentPage, SoundAttachmentInitialParams, dynamic>(
          (params, _) => SoundAttachmentPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<PostOverlayNavigator>(
          () => PostOverlayNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<PostOverlayViewModel, PostOverlayInitialParams, dynamic>(
          (params, _) => PostOverlayPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PostOverlayPresenter, PostOverlayInitialParams, dynamic>(
          (params, _) => PostOverlayPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PostOverlayPage, PostOverlayInitialParams, dynamic>(
          (params, _) => PostOverlayPage(presenter: getIt(param1: params)),
        )
        ..registerFactoryParam<HorizontalVideoOverlay, PostOverlayInitialParams, dynamic>(
          (params, _) => HorizontalVideoOverlay(presenter: getIt(param1: params)),
        )
        ..registerFactory<PostDetailsNavigator>(
          () => PostDetailsNavigator(getIt()),
        )
        ..registerFactoryParam<PostDetailsPresentationModel, PostDetailsInitialParams, dynamic>(
          (params, _) => PostDetailsPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<PostDetailsPresenter, PostDetailsInitialParams, dynamic>(
          (params, _) => PostDetailsPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PostDetailsPage, PostDetailsInitialParams, dynamic>(
          (params, _) => PostDetailsPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<SelectCircleNavigator>(
          () => SelectCircleNavigator(getIt()),
        )
        ..registerFactoryParam<SelectCirclePresentationModel, SelectCircleInitialParams, dynamic>(
          (params, _) => SelectCirclePresentationModel.initial(params),
        )
        ..registerFactoryParam<SelectCirclePresenter, SelectCircleInitialParams, dynamic>(
          (params, _) => SelectCirclePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SelectCirclePage, SelectCircleInitialParams, dynamic>(
          (params, _) => SelectCirclePage(presenter: getIt(param1: params)),
        )
        ..registerFactory<VideoPostRecordingNavigator>(
          () => VideoPostRecordingNavigator(getIt()),
        )
        ..registerFactoryParam<VideoPostRecordingViewModel, VideoPostRecordingInitialParams, dynamic>(
          (params, _) => VideoPostRecordingPresentationModel.initial(params),
        )
        ..registerFactoryParam<VideoPostRecordingPresenter, VideoPostRecordingInitialParams, dynamic>(
          (params, _) => VideoPostRecordingPresenter(getIt(param1: params), getIt()),
        )
        ..registerFactoryParam<VideoPostRecordingPage, VideoPostRecordingInitialParams, dynamic>(
          (params, _) => VideoPostRecordingPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<SingleFeedNavigator>(
          () => SingleFeedNavigator(getIt()),
        )
        ..registerFactoryParam<SingleFeedViewModel, SingleFeedInitialParams, dynamic>(
          (params, _) => SingleFeedPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<SingleFeedPresenter, SingleFeedInitialParams, dynamic>(
          (params, _) => SingleFeedPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SingleFeedPage, SingleFeedInitialParams, dynamic>(
          (params, _) => SingleFeedPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<AfterPostDialogNavigator>(
          () => AfterPostDialogNavigator(getIt()),
        )
        ..registerFactoryParam<AfterPostDialogViewModel, AfterPostDialogInitialParams, dynamic>(
          (params, _) => AfterPostDialogPresentationModel.initial(params),
        )
        ..registerFactoryParam<AfterPostDialogPresenter, AfterPostDialogInitialParams, dynamic>(
          (params, _) => AfterPostDialogPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<AfterPostDialogPage, AfterPostDialogInitialParams, dynamic>(
          (params, _) => AfterPostDialogPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<SavePostToCollectionNavigator>(
          () => SavePostToCollectionNavigator(getIt()),
        )
        ..registerFactoryParam<SavePostToCollectionViewModel, SavePostToCollectionInitialParams, dynamic>(
          (params, _) => SavePostToCollectionPresentationModel.initial(params),
        )
        ..registerFactoryParam<SavePostToCollectionPresenter, SavePostToCollectionInitialParams, dynamic>(
          (params, _) => SavePostToCollectionPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SavePostToCollectionPage, SavePostToCollectionInitialParams, dynamic>(
          (params, _) => SavePostToCollectionPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<PostShareNavigator>(
          () => PostShareNavigator(getIt()),
        )
        ..registerFactoryParam<PostShareViewModel, PostShareInitialParams, dynamic>(
          (params, _) => PostSharePresentationModel.initial(params),
        )
        ..registerFactoryParam<PostSharePresenter, PostShareInitialParams, dynamic>(
          (initialParams, _) => PostSharePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CreateNewCollectionNavigator>(
          () => CreateNewCollectionNavigator(getIt()),
        )
        ..registerFactoryParam<CreateNewCollectionViewModel, CreateNewCollectionInitialParams, dynamic>(
          (params, _) => CreateNewCollectionPresentationModel.initial(params),
        )
        ..registerFactoryParam<CreateNewCollectionPresenter, CreateNewCollectionInitialParams, dynamic>(
          (params, _) => CreateNewCollectionPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CreateNewCollectionPage, CreateNewCollectionInitialParams, dynamic>(
          (params, _) => CreateNewCollectionPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<UploadMediaNavigator>(
          () => UploadMediaNavigator(getIt()),
        )
        ..registerFactoryParam<UploadMediaViewModel, UploadMediaInitialParams, dynamic>(
          (params, _) => UploadMediaPresentationModel.initial(params),
        )
        ..registerFactoryParam<UploadMediaPresenter, UploadMediaInitialParams, dynamic>(
          (params, _) => UploadMediaPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<UploadMediaPage, UploadMediaInitialParams, dynamic>(
          (params, _) => UploadMediaPage(presenter: getIt(param1: params)),
        )
        ..registerFactoryParam<FullScreenImagePostPage, FullScreenImagePostInitialParams, dynamic>(
          (params, _) => FullScreenImagePostPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<FullScreenImagePostNavigator>(
          () => FullScreenImagePostNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<FullScreenImagePostViewModel, FullScreenImagePostInitialParams, dynamic>(
          (params, _) => FullScreenImagePostPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<FullScreenImagePostPresenter, FullScreenImagePostInitialParams, dynamic>(
          (params, _) => FullScreenImagePostPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
