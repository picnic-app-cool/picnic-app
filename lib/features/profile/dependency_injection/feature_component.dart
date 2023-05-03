import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import "package:picnic_app/features/profile/collection/collection_initial_params.dart";
import "package:picnic_app/features/profile/collection/collection_navigator.dart";
import "package:picnic_app/features/profile/collection/collection_page.dart";
import "package:picnic_app/features/profile/collection/collection_presentation_model.dart";
import "package:picnic_app/features/profile/collection/collection_presenter.dart";
import 'package:picnic_app/features/profile/data/graphql_get_user_posts_repository.dart';
import 'package:picnic_app/features/profile/data/graphql_saved_posts_repository.dart';
import 'package:picnic_app/features/profile/domain/repositories/get_user_posts_repository.dart';
import 'package:picnic_app/features/profile/domain/repositories/saved_posts_repository.dart';
import 'package:picnic_app/features/profile/domain/use_cases/create_collection_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/delete_collection_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/edit_profile_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/get_followers_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/get_notifications_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/get_posts_in_collection_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/get_private_profile_use_case.dart";
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/get_saved_posts_use_case.dart";
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/get_user_posts_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/remove_collection_post_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/update_profile_image_use_case.dart";
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_page.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presenter.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_page.dart';
import 'package:picnic_app/features/profile/followers/followers_presentation_model.dart';
import 'package:picnic_app/features/profile/followers/followers_presenter.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_page.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_navigator.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_page.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presenter.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_page.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presenter.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_page.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presenter.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_navigator.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_page.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presentation_model.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presenter.dart';
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
  getIt
        ..registerFactory<SavedPostsRepository>(
          () => GraphqlSavedPostsRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<GetUserPostsRepository>(
          () => GraphqlGetUserPostsRepository(
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
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<GetSavedPostsUseCase>(
          () => GetSavedPostsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetPrivateProfileUseCase>(
          () => GetPrivateProfileUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetFollowersUseCase>(
          () => GetFollowersUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetPostsInCollectionUseCase>(
          () => GetPostsInCollectionUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetNotificationsUseCase>(
          () => GetNotificationsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserPostsUseCase>(
          () => GetUserPostsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<EditProfileUseCase>(
          () => EditProfileUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<FollowUnfollowUserUseCase>(
          () => FollowUnfollowUserUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserActionUseCase>(
          () => const GetUserActionUseCase(),
        )
        ..registerFactory<UpdateProfileImageUseCase>(
          () => UpdateProfileImageUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<DeleteCollectionUseCase>(
          () => DeleteCollectionUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetProfileStatsUseCase>(
          () => GetProfileStatsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SendGlitterBombUseCase>(
          () => SendGlitterBombUseCase(getIt()),
        )
        ..registerFactory<RemoveCollectionPostUseCase>(
          () => RemoveCollectionPostUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUnreadNotificationsCountUseCase>(
          () => GetUnreadNotificationsCountUseCase(getIt()),
        )
        ..registerFactory<CreateCollectionUseCase>(
          () => CreateCollectionUseCase(
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
        ..registerFactory<PrivateProfileNavigator>(
          () => PrivateProfileNavigator(getIt()),
        )
        ..registerFactoryParam<PrivateProfilePresentationModel, PrivateProfileInitialParams, dynamic>(
          (params, _) => PrivateProfilePresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PrivateProfilePresenter, PrivateProfileInitialParams, dynamic>(
          (initialParams, _) => PrivateProfilePresenter(
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
          ),
        )
        ..registerFactoryParam<PrivateProfilePage, PrivateProfileInitialParams, dynamic>(
          (initialParams, _) => PrivateProfilePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<NotificationsListNavigator>(
          () => NotificationsListNavigator(
            getIt(),
          ),
        )
        ..registerFactoryParam<NotificationsListPresentationModel, NotificationsListInitialParams, dynamic>(
          (params, _) => NotificationsListPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<NotificationsListPresenter, NotificationsListInitialParams, dynamic>(
          (initialParams, _) => NotificationsListPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<NotificationsListPage, NotificationsListInitialParams, dynamic>(
          (initialParams, _) => NotificationsListPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<FollowersNavigator>(
          () => FollowersNavigator(getIt(), getIt()),
        )
        ..registerFactoryParam<FollowersPresentationModel, FollowersInitialParams, dynamic>(
          (params, _) => FollowersPresentationModel.initial(
            params,
            getIt(),
          ),
        )
        ..registerFactoryParam<FollowersPresenter, FollowersInitialParams, dynamic>(
          (initialParams, _) => FollowersPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<FollowersPage, FollowersInitialParams, dynamic>(
          (initialParams, _) => FollowersPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<SavedPostsNavigator>(
          () => SavedPostsNavigator(
            getIt(),
          ),
        )
        ..registerFactoryParam<SavedPostsPresentationModel, SavedPostsInitialParams, dynamic>(
          (params, _) => SavedPostsPresentationModel.initial(params),
        )
        ..registerFactoryParam<SavedPostsPresenter, SavedPostsInitialParams, dynamic>(
          (initialParams, _) => SavedPostsPresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<SavedPostsPage, SavedPostsInitialParams, dynamic>(
          (initialParams, _) => SavedPostsPage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<EditProfileNavigator>(
          () => EditProfileNavigator(getIt()),
        )
        ..registerFactoryParam<EditProfilePresentationModel, EditProfileInitialParams, dynamic>(
          (params, _) => EditProfilePresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<EditProfilePresenter, EditProfileInitialParams, dynamic>(
          (initialParams, _) => EditProfilePresenter(
            getIt(param1: initialParams),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<EditProfilePage, EditProfileInitialParams, dynamic>(
          (initialParams, _) => EditProfilePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<PublicProfileNavigator>(
          () => PublicProfileNavigator(getIt()),
        )
        ..registerFactoryParam<PublicProfilePresentationModel, PublicProfileInitialParams, dynamic>(
          (params, _) => PublicProfilePresentationModel.initial(
            params,
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<PublicProfilePresenter, PublicProfileInitialParams, dynamic>(
          (initialParams, _) => PublicProfilePresenter(
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
          ),
        )
        ..registerFactoryParam<PublicProfilePage, PublicProfileInitialParams, dynamic>(
          (initialParams, _) => PublicProfilePage(
            presenter: getIt(param1: initialParams),
          ),
        )
        ..registerFactory<CollectionNavigator>(
          () => CollectionNavigator(getIt()),
        )
        ..registerFactoryParam<CollectionPresentationModel, CollectionInitialParams, dynamic>(
          (params, _) => CollectionPresentationModel.initial(params, getIt()),
        )
        ..registerFactoryParam<CollectionPresenter, CollectionInitialParams, dynamic>(
          (params, _) => CollectionPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<CollectionPage, CollectionInitialParams, dynamic>(
          (params, _) => CollectionPage(presenter: getIt(param1: params)),
        )
        ..registerFactory<InviteFriendsBottomSheetNavigator>(
          () => InviteFriendsBottomSheetNavigator(getIt()),
        )
        ..registerFactoryParam<InviteFriendsBottomSheetViewModel, InviteFriendsBottomSheetInitialParams, dynamic>(
          (params, _) => InviteFriendsBottomSheetPresentationModel.initial(params),
        )
        ..registerFactoryParam<InviteFriendsBottomSheetPresenter, InviteFriendsBottomSheetInitialParams, dynamic>(
          (params, _) => InviteFriendsBottomSheetPresenter(
            getIt(param1: params),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactoryParam<InviteFriendsBottomSheetPage, InviteFriendsBottomSheetInitialParams, dynamic>(
          (params, _) => InviteFriendsBottomSheetPage(presenter: getIt(param1: params)),
        )

//DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
