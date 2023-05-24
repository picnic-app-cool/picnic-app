import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_initial_params.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_navigator.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presentation_model.dart';
import 'package:picnic_app/features/feed/circles_side_menu/circles_side_menu_presenter.dart';
import 'package:picnic_app/features/feed/data/graphql_feed_repository.dart';
import 'package:picnic_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:picnic_app/features/feed/domain/stores/local_feeds_store.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_feeds_list_use_case.dart';
import "package:picnic_app/features/feed/domain/use_cases/get_popular_feed_use_case.dart";
import 'package:picnic_app/features/feed/feed_home/feed_home_initial_params.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_navigator.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_page.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_home/feed_home_presenter.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_initial_params.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_navigator.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_page.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presentation_model.dart';
import 'package:picnic_app/features/feed/feed_more/feed_more_presenter.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_initial_params.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_navigator.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presentation_model.dart';
import 'package:picnic_app/features/feed/post_uploading_progress/post_uploading_progress_presenter.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_initial_params.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_navigator.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_page.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presentation_model.dart';
import 'package:picnic_app/features/posts/comment_chat/comment_chat_presenter.dart';
import 'package:picnic_app/features/posts/image_post/image_post_initial_params.dart';
import 'package:picnic_app/features/posts/image_post/image_post_navigator.dart';
import 'package:picnic_app/features/posts/image_post/image_post_page.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presentation_model.dart';
import 'package:picnic_app/features/posts/image_post/image_post_presenter.dart';
import 'package:picnic_app/features/posts/link_post/link_post_initial_params.dart';
import 'package:picnic_app/features/posts/link_post/link_post_navigator.dart';
import 'package:picnic_app/features/posts/link_post/link_post_page.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presentation_model.dart';
import 'package:picnic_app/features/posts/link_post/link_post_presenter.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_initial_params.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_navigator.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_page.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presentation_model.dart';
import 'package:picnic_app/features/posts/poll_post/poll_post_presenter.dart';
import 'package:picnic_app/features/posts/text_post/text_post_initial_params.dart';
import 'package:picnic_app/features/posts/text_post/text_post_navigator.dart';
import 'package:picnic_app/features/posts/text_post/text_post_page.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post/text_post_presenter.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_navigator.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_page.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_feed/text_post_feed_presenter.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_initial_params.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_navigator.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_page.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_presentation_model.dart';
import 'package:picnic_app/features/posts/text_post_profile/text_post_profile_presenter.dart';
import 'package:picnic_app/features/posts/video_post/video_post_initial_params.dart';
import 'package:picnic_app/features/posts/video_post/video_post_navigator.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presentation_model.dart';
import 'package:picnic_app/features/posts/video_post/video_post_presenter.dart';

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
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt.registerFactory<FeedRepository>(
    () => GraphQlFeedRepository(
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
        ..registerLazySingleton<LocalFeedsStore>(
          () => LocalFeedsStore(),
        )
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<GetFeedsListUseCase>(
          () => GetFeedsListUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetPopularFeedUseCase>(
          () => GetPopularFeedUseCase(
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
        ..registerFactory<LinkPostNavigator>(
          () => LinkPostNavigator(getIt()),
        )
        ..registerFactoryParam<LinkPostPresentationModel, LinkPostInitialParams, dynamic>(
          (params, _) => LinkPostPresentationModel.initial(params),
        )
        ..registerFactoryParam<LinkPostPresenter, LinkPostInitialParams, dynamic>(
          (initialParams, _) => LinkPostPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<LinkPostPage, LinkPostInitialParams, dynamic>(
          (initialParams, _) => LinkPostPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PollPostNavigator>(
          () => PollPostNavigator(getIt()),
        )
        ..registerFactoryParam<PollPostPresentationModel, PollPostInitialParams, dynamic>(
          (params, _) => PollPostPresentationModel.initial(params),
        )
        ..registerFactoryParam<PollPostPresenter, PollPostInitialParams, dynamic>(
          (initialParams, _) => PollPostPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PollPostPage, PollPostInitialParams, dynamic>(
          (initialParams, _) => PollPostPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<ImagePostNavigator>(
          () => ImagePostNavigator(getIt()),
        )
        ..registerFactoryParam<ImagePostPresentationModel, ImagePostInitialParams, dynamic>(
          (params, _) => ImagePostPresentationModel.initial(params),
        )
        ..registerFactoryParam<ImagePostPresenter, ImagePostInitialParams, dynamic>(
          (initialParams, _) => ImagePostPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<ImagePostPage, ImagePostInitialParams, dynamic>(
          (initialParams, _) => ImagePostPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<TextPostNavigator>(
          () => TextPostNavigator(getIt()),
        )
        ..registerFactoryParam<TextPostPresentationModel, TextPostInitialParams, dynamic>(
          (params, _) => TextPostPresentationModel.initial(params),
        )
        ..registerFactoryParam<TextPostPresenter, TextPostInitialParams, dynamic>(
          (initialParams, _) => TextPostPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<TextPostPage, TextPostInitialParams, dynamic>(
          (initialParams, _) => TextPostPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<TextPostFeedNavigator>(
          () => TextPostFeedNavigator(getIt()),
        )
        ..registerFactoryParam<TextPostFeedPresentationModel, TextPostFeedInitialParams, dynamic>(
          (params, _) => TextPostFeedPresentationModel.initial(
            params,
            getIt(param1: params.commentChatInitialParams),
            getIt(param1: params.postOverlayInitialParams),
          ),
        )
        ..registerFactoryParam<TextPostFeedPresenter, TextPostFeedInitialParams, dynamic>(
          (initialParams, _) => TextPostFeedPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(param1: initialParams.commentChatInitialParams),
            getIt(param1: initialParams.postOverlayInitialParams),
          ),
        )
        ..registerFactoryParam<TextPostFeedPage, TextPostFeedInitialParams, dynamic>(
          (initialParams, _) => TextPostFeedPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<TextPostProfileNavigator>(
          () => TextPostProfileNavigator(getIt()),
        )
        ..registerFactoryParam<TextPostProfilePresentationModel, TextPostProfileInitialParams, dynamic>(
          (params, _) => TextPostProfilePresentationModel.initial(
            params,
            getIt(param1: params.postOverlayInitialParams),
          ),
        )
        ..registerFactoryParam<TextPostProfilePresenter, TextPostProfileInitialParams, dynamic>(
          (initialParams, _) => TextPostProfilePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(param1: initialParams.postOverlayInitialParams),
          ),
        )
        ..registerFactoryParam<TextPostProfilePage, TextPostProfileInitialParams, dynamic>(
          (initialParams, _) => TextPostProfilePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<VideoPostNavigator>(
          () => VideoPostNavigator(getIt()),
        )
        ..registerFactoryParam<VideoPostPresentationModel, VideoPostInitialParams, dynamic>(
          (params, _) => VideoPostPresentationModel.initial(params),
        )
        ..registerFactoryParam<VideoPostPresenter, VideoPostInitialParams, dynamic>(
          (params, _) => VideoPostPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<FeedHomeNavigator>(
          () => FeedHomeNavigator(getIt()),
        )
        ..registerFactoryParam<FeedHomePresentationModel, FeedHomeInitialParams, dynamic>(
          (params, _) => FeedHomePresentationModel.initial(
            params,
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<FeedHomePresenter, FeedHomeInitialParams, dynamic>(
          (initialParams, _) => FeedHomePresenter(
            getIt(param1: initialParams),
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
        ..registerFactoryParam<FeedHomePage, FeedHomeInitialParams, dynamic>(
          (initialParams, _) => FeedHomePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PostUploadingProgressNavigator>(
          () => PostUploadingProgressNavigator(getIt()),
        )
        ..registerFactoryParam<PostUploadingProgressViewModel, PostUploadingProgressInitialParams, dynamic>(
          (params, _) => PostUploadingProgressPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<PostUploadingProgressPresenter, PostUploadingProgressInitialParams, dynamic>(
          (initialParams, _) => PostUploadingProgressPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CommentChatNavigator>(
          () => CommentChatNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<CommentChatViewModel, CommentChatInitialParams, dynamic>(
          (params, _) => CommentChatPresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CommentChatPresenter, CommentChatInitialParams, dynamic>(
          (initialParams, _) => CommentChatPresenter(
            getIt(param1: initialParams),
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
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CommentChatPage, CommentChatInitialParams, dynamic>(
          (initialParams, _) => CommentChatPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<FeedMoreNavigator>(
          () => FeedMoreNavigator(getIt()),
        )
        ..registerFactoryParam<FeedMoreViewModel, FeedMoreInitialParams, dynamic>(
          (params, _) => FeedMorePresentationModel.initial(params),
        )
        ..registerFactoryParam<FeedMorePresenter, FeedMoreInitialParams, dynamic>(
          (params, _) => FeedMorePresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<FeedMorePage, FeedMoreInitialParams, dynamic>(
          (params, _) => FeedMorePage(presenter: getIt(param1: params)),
        )
        ..registerFactory<CirclesSideMenuNavigator>(
          () => CirclesSideMenuNavigator(getIt()),
        )
        ..registerFactoryParam<CirclesSideMenuViewModel, CirclesSideMenuInitialParams, dynamic>(
          (params, _) => CirclesSideMenuPresentationModel.initial(
            params,
          ),
        )
        ..registerFactoryParam<CirclesSideMenuPresenter, CirclesSideMenuInitialParams, dynamic>(
          (params, _) => CirclesSideMenuPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
          ),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
