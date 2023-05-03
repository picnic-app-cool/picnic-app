import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import "package:picnic_app/features/profile/collection/collection_initial_params.dart";
import "package:picnic_app/features/profile/collection/collection_navigator.dart";
import "package:picnic_app/features/profile/collection/collection_presentation_model.dart";
import "package:picnic_app/features/profile/collection/collection_presenter.dart";
import 'package:picnic_app/features/profile/domain/model/create_collection_failure.dart';
import "package:picnic_app/features/profile/domain/model/delete_collection_failure.dart";
import "package:picnic_app/features/profile/domain/model/edit_profile_failure.dart";
import 'package:picnic_app/features/profile/domain/model/get_followers_failure.dart';
import "package:picnic_app/features/profile/domain/model/get_notifications_failure.dart";
import "package:picnic_app/features/profile/domain/model/get_posts_in_collection_failure.dart";
import "package:picnic_app/features/profile/domain/model/get_private_profile_failure.dart";
import 'package:picnic_app/features/profile/domain/model/get_profile_stats_failure.dart';
import "package:picnic_app/features/profile/domain/model/get_saved_posts_failure.dart";
import 'package:picnic_app/features/profile/domain/model/get_unread_notifications_count_failure.dart';
import "package:picnic_app/features/profile/domain/model/get_user_posts_failure.dart";
import "package:picnic_app/features/profile/domain/model/remove_collection_posts_failure.dart";
import 'package:picnic_app/features/profile/domain/model/send_glitter_bomb_failure.dart';
import "package:picnic_app/features/profile/domain/model/update_profile_image_failure.dart";
import 'package:picnic_app/features/profile/domain/repositories/get_user_posts_repository.dart';
import 'package:picnic_app/features/profile/domain/repositories/saved_posts_repository.dart';
import 'package:picnic_app/features/profile/domain/use_cases/create_collection_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/delete_collection_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/edit_profile_use_case.dart";
import 'package:picnic_app/features/profile/domain/use_cases/get_followers_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/get_notifications_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/get_posts_in_collection_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/get_private_profile_use_case.dart";
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/get_saved_posts_use_case.dart";
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/get_user_posts_use_case.dart";
import "package:picnic_app/features/profile/domain/use_cases/remove_collection_post_use_case.dart";
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';
import "package:picnic_app/features/profile/domain/use_cases/update_profile_image_use_case.dart";
import 'package:picnic_app/features/profile/edit_profile/edit_profile_initial_params.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presenter.dart';
import 'package:picnic_app/features/profile/followers/followers_initial_params.dart';
import 'package:picnic_app/features/profile/followers/followers_navigator.dart';
import 'package:picnic_app/features/profile/followers/followers_presentation_model.dart';
import 'package:picnic_app/features/profile/followers/followers_presenter.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/profile/invite_friends/invite_friends_bottom_sheet_presenter.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_initial_params.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_navigator.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presentation_model.dart';
import 'package:picnic_app/features/profile/notifications/notifications_list_presenter.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_navigator.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_presenter.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_navigator.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_presenter.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_navigator.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presentation_model.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockPrivateProfilePresenter extends MockCubit<PrivateProfileViewModel> implements PrivateProfilePresenter {}

class MockPrivateProfilePresentationModel extends Mock implements PrivateProfilePresentationModel {}

class MockPrivateProfileInitialParams extends Mock implements PrivateProfileInitialParams {}

class MockPrivateProfileNavigator extends Mock implements PrivateProfileNavigator {}

class MockNotificationsPresenter extends MockCubit<NotificationsViewModel> implements NotificationsListPresenter {}

class MockNotificationsPresentationModel extends Mock implements NotificationsListPresentationModel {}

class MockNotificationsInitialParams extends Mock implements NotificationsListInitialParams {}

class MockNotificationsNavigator extends Mock implements NotificationsListNavigator {}

class MockFollowersPresenter extends MockCubit<FollowersViewModel> implements FollowersPresenter {}

class MockFollowersPresentationModel extends Mock implements FollowersPresentationModel {}

class MockFollowersInitialParams extends Mock implements FollowersInitialParams {}

class MockFollowersNavigator extends Mock implements FollowersNavigator {}

class MockSavedPostsPresenter extends MockCubit<SavedPostsViewModel> implements SavedPostsPresenter {}

class MockSavedPostsPresentationModel extends Mock implements SavedPostsPresentationModel {}

class MockSavedPostsInitialParams extends Mock implements SavedPostsInitialParams {}

class MockSavedPostsNavigator extends Mock implements SavedPostsNavigator {}

class MockEditProfilePresenter extends MockCubit<EditProfileViewModel> implements EditProfilePresenter {}

class MockEditProfilePresentationModel extends Mock implements EditProfilePresentationModel {}

class MockEditProfileInitialParams extends Mock implements EditProfileInitialParams {}

class MockEditProfileNavigator extends Mock implements EditProfileNavigator {}

class MockPublicProfilePresenter extends MockCubit<PublicProfileViewModel> implements PublicProfilePresenter {}

class MockPublicProfilePresentationModel extends Mock implements PublicProfilePresentationModel {}

class MockPublicProfileInitialParams extends Mock implements PublicProfileInitialParams {}

class MockPublicProfileNavigator extends Mock implements PublicProfileNavigator {}

class MockCollectionPresenter extends MockCubit<CollectionViewModel> implements CollectionPresenter {}

class MockCollectionPresentationModel extends Mock implements CollectionPresentationModel {}

class MockCollectionInitialParams extends Mock implements CollectionInitialParams {}

class MockCollectionNavigator extends Mock implements CollectionNavigator {}

class MockInviteFriendsBottomSheetPresenter extends MockCubit<InviteFriendsBottomSheetViewModel>
    implements InviteFriendsBottomSheetPresenter {}

class MockInviteFriendsBottomSheetPresentationModel extends Mock implements InviteFriendsBottomSheetPresentationModel {}

class MockInviteFriendsBottomSheetInitialParams extends Mock implements InviteFriendsBottomSheetInitialParams {}

class MockInviteFriendsBottomSheetNavigator extends Mock implements InviteFriendsBottomSheetNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockGetSavedPostsFailure extends Mock implements GetSavedPostsFailure {}

class MockGetSavedPostsUseCase extends Mock implements GetSavedPostsUseCase {}

class MockGetFollowersFailure extends Mock implements GetFollowersFailure {}

class MockGetFollowersUseCase extends Mock implements GetFollowersUseCase {}

class MockGetPrivateProfileFailure extends Mock implements GetPrivateProfileFailure {}

class MockGetPrivateProfileUseCase extends Mock implements GetPrivateProfileUseCase {}

class MockGetPostsInCollectionFailure extends Mock implements GetPostsInCollectionFailure {}

class MockGetPostsInCollectionUseCase extends Mock implements GetPostsInCollectionUseCase {}

class MockGetUserPostsFailure extends Mock implements GetUserPostsFailure {}

class MockGetUserPostsUseCase extends Mock implements GetUserPostsUseCase {}

class MockGetNotificationsFailure extends Mock implements GetNotificationsFailure {}

class MockGetNotificationsUseCase extends Mock implements GetNotificationsUseCase {}

class MockEditProfileFailure extends Mock implements EditProfileFailure {}

class MockEditProfileUseCase extends Mock implements EditProfileUseCase {}

class MockUpdateProfileImageFailure extends Mock implements UpdateProfileImageFailure {}

class MockUpdateProfileImageUseCase extends Mock implements UpdateProfileImageUseCase {}

class MockSendGlitterBombFailure extends Mock implements SendGlitterBombFailure {}

class MockSendGlitterBombUseCase extends Mock implements SendGlitterBombUseCase {}

class MockRemoveCollectionPostsFailure extends Mock implements RemoveCollectionPostsFailure {}

class MockRemoveCollectionPostsUseCase extends Mock implements RemoveCollectionPostUseCase {}

class MockDeleteCollectionFailure extends Mock implements DeleteCollectionFailure {}

class MockDeleteCollectionUseCase extends Mock implements DeleteCollectionUseCase {}

class MockGetUnreadNotificationsCountFailure extends Mock implements GetUnreadNotificationsCountFailure {}

class MockGetUnreadNotificationsCountUseCase extends Mock implements GetUnreadNotificationsCountUseCase {}

class MockGetProfileStatsFailure extends Mock implements GetProfileStatsFailure {}

class MockGetProfileStatsUseCase extends Mock implements GetProfileStatsUseCase {}

class MockCreateCollectionFailure extends Mock implements CreateCollectionFailure {}

class MockCreateCollectionUseCase extends Mock implements CreateCollectionUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockSavedPostsRepository extends Mock implements SavedPostsRepository {}

class MockGetUserPostsRepository extends Mock implements GetUserPostsRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
