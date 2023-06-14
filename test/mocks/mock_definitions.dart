import 'package:bloc_test/bloc_test.dart';
import "package:dio/dio.dart" as dio;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/data/assets_loader.dart';
import 'package:picnic_app/core/data/firebase/actions/firebase_actions_factory.dart';
import 'package:picnic_app/core/data/firebase/actions/log_in_with_phone_action.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/imgly_wrapper.dart';
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';
import 'package:picnic_app/core/data/shared_preferences_provider.dart';
import 'package:picnic_app/core/domain/get_auth_token_failure.dart';
import "package:picnic_app/core/domain/model/accept_seeds_offer_failure.dart";
import 'package:picnic_app/core/domain/model/add_post_to_collection_failure.dart';
import 'package:picnic_app/core/domain/model/app_info.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import "package:picnic_app/core/domain/model/block_user_failure.dart";
import "package:picnic_app/core/domain/model/cancel_seeds_offer_failure.dart";
import 'package:picnic_app/core/domain/model/check_username_availability_failure.dart';
import 'package:picnic_app/core/domain/model/copy_text_failure.dart';
import 'package:picnic_app/core/domain/model/delete_posts_failure.dart';
import 'package:picnic_app/core/domain/model/follow_unfollow_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_app_info_failure.dart';
import 'package:picnic_app/core/domain/model/get_circle_by_name_failure.dart';
import "package:picnic_app/core/domain/model/get_circle_stats_failure.dart";
import 'package:picnic_app/core/domain/model/get_circles_failure.dart';
import 'package:picnic_app/core/domain/model/get_collections_failure.dart';
import "package:picnic_app/core/domain/model/get_feature_flags_failure.dart";
import 'package:picnic_app/core/domain/model/get_language_failure.dart';
import "package:picnic_app/core/domain/model/get_phone_gallery_assets_failure.dart";
import 'package:picnic_app/core/domain/model/get_post_creation_circles_failure.dart';
import 'package:picnic_app/core/domain/model/get_runtime_permission_status_failure.dart';
import 'package:picnic_app/core/domain/model/get_should_show_circles_selection_failure.dart';
import 'package:picnic_app/core/domain/model/get_slice_members_failure.dart';
import 'package:picnic_app/core/domain/model/get_slices_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_by_username_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_circles_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_failure.dart';
import 'package:picnic_app/core/domain/model/get_user_scoped_pod_token_failure.dart';
import "package:picnic_app/core/domain/model/haptic_feedback_failure.dart";
import "package:picnic_app/core/domain/model/join_circle_failure.dart";
import 'package:picnic_app/core/domain/model/join_slice_failure.dart';
import "package:picnic_app/core/domain/model/leave_circle_failure.dart";
import 'package:picnic_app/core/domain/model/leave_slice_failure.dart';
import "package:picnic_app/core/domain/model/log_out_failure.dart";
import 'package:picnic_app/core/domain/model/mention_user_failure.dart';
import 'package:picnic_app/core/domain/model/notify_contact_failure.dart';
import "package:picnic_app/core/domain/model/open_native_app_settings_failure.dart";
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/recaptcha_verification_failure.dart';
import "package:picnic_app/core/domain/model/reject_seeds_offer_failure.dart";
import 'package:picnic_app/core/domain/model/request_runtime_permission_failure.dart';
import "package:picnic_app/core/domain/model/save_photo_to_gallery_failure.dart";
import "package:picnic_app/core/domain/model/save_post_to_collection_failure.dart";
import "package:picnic_app/core/domain/model/set_language_failure.dart";
import 'package:picnic_app/core/domain/model/set_should_show_circles_selection_failure.dart';
import 'package:picnic_app/core/domain/model/share_post_failure.dart';
import "package:picnic_app/core/domain/model/unblock_user_failure.dart";
import "package:picnic_app/core/domain/model/update_circle_failure.dart";
import 'package:picnic_app/core/domain/model/update_current_user_failure.dart';
import 'package:picnic_app/core/domain/model/update_slice_failure.dart';
import 'package:picnic_app/core/domain/model/upload_contacts_failure.dart';
import 'package:picnic_app/core/domain/repositories/app_badge_repository.dart';
import 'package:picnic_app/core/domain/repositories/app_info_repository.dart';
import 'package:picnic_app/core/domain/repositories/attachment_repository.dart';
import 'package:picnic_app/core/domain/repositories/audio_player_repository.dart';
import 'package:picnic_app/core/domain/repositories/auth_repository.dart';
import 'package:picnic_app/core/domain/repositories/auth_token_repository.dart';
import 'package:picnic_app/core/domain/repositories/background_api_repository.dart';
import 'package:picnic_app/core/domain/repositories/cache_management_repository.dart';
import 'package:picnic_app/core/domain/repositories/circles_repository.dart';
import 'package:picnic_app/core/domain/repositories/collections_repository.dart';
import 'package:picnic_app/core/domain/repositories/contacts_repository.dart';
import 'package:picnic_app/core/domain/repositories/deep_links_repository.dart';
import 'package:picnic_app/core/domain/repositories/download_repository.dart';
import 'package:picnic_app/core/domain/repositories/feature_flags_repository.dart';
import 'package:picnic_app/core/domain/repositories/haptic_repository.dart';
import 'package:picnic_app/core/domain/repositories/local_storage_repository.dart';
import 'package:picnic_app/core/domain/repositories/phone_gallery_repository.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/core/domain/repositories/post_creation_circles_repository.dart';
import 'package:picnic_app/core/domain/repositories/private_profile_repository.dart';
import 'package:picnic_app/core/domain/repositories/recaptcha_repository.dart';
import 'package:picnic_app/core/domain/repositories/runtime_permissions_repository.dart';
import 'package:picnic_app/core/domain/repositories/secure_local_storage_repository.dart';
import 'package:picnic_app/core/domain/repositories/seeds_repository.dart';
import 'package:picnic_app/core/domain/repositories/session_expired_repository.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/domain/stores/user_circles_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import "package:picnic_app/core/domain/use_cases/accept_seeds_offer_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/add_deeplink_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/add_post_to_collection_use_case.dart';
import "package:picnic_app/core/domain/use_cases/add_session_expired_listener_use_case.dart";
import "package:picnic_app/core/domain/use_cases/block_user_use_case.dart";
import "package:picnic_app/core/domain/use_cases/cancel_seeds_offer_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/check_username_availability_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/control_audio_play_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/copy_text_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_attachments_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_auth_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_by_name_use_case.dart';
import "package:picnic_app/core/domain/use_cases/get_circle_stats_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/get_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_contacts_use_case.dart';
import "package:picnic_app/core/domain/use_cases/get_feature_flags_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/get_languages_list_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_phone_contacts_use_case.dart';
import "package:picnic_app/core/domain/use_cases/get_phone_gallery_assets_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/get_post_creation_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_runtime_permission_status_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_slice_members_by_role_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_slices_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_trending_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_by_username_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_scoped_pod_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import "package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/image_watermark_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/increment_app_badge_count_use_case.dart';
import "package:picnic_app/core/domain/use_cases/join_circle_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/join_slice_use_case.dart';
import "package:picnic_app/core/domain/use_cases/leave_circle_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/leave_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/listen_to_deep_links_use_case.dart';
import "package:picnic_app/core/domain/use_cases/log_out_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/mention_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/notify_contact_use_case.dart';
import "package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/recaptcha_verification_use_case.dart';
import "package:picnic_app/core/domain/use_cases/reject_seeds_offer_use_case.dart";
import "package:picnic_app/core/domain/use_cases/remove_session_expired_listener_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import "package:picnic_app/core/domain/use_cases/save_photo_to_gallery_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/save_post_screen_time_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_video_to_gallery_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import "package:picnic_app/core/domain/use_cases/set_language_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/set_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import "package:picnic_app/core/domain/use_cases/unblock_user_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import "package:picnic_app/core/domain/use_cases/update_circle_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/update_current_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_attachment_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_contacts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/video_thumbnail_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/fx_effect_overlay/fx_effect.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';
import 'package:picnic_app/core/utils/periodic_task_executor.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/features/analytics/analytics_observer.dart';
import 'package:picnic_app/features/chat/domain/model/unread_chat.dart';
import 'package:picnic_app/features/chat/domain/use_cases/start_unread_chats_listening_use_case.dart';
import 'package:picnic_app/features/circles/domain/model/resolve_report_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_posts_repository.dart';
import 'package:picnic_app/features/circles/domain/use_cases/resolve_report_use_case.dart';
import 'package:picnic_app/features/connection_status/domain/repositories/connection_status_repository.dart';
import 'package:picnic_app/features/posts/domain/model/view_post_failure.dart';
import 'package:picnic_app/features/posts/domain/stores/video_mute_store.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';
import 'package:picnic_app/features/profile/achievements/achievements_initial_params.dart';
import 'package:picnic_app/features/profile/achievements/achievements_navigator.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presentation_model.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presenter.dart';
import 'package:picnic_app/features/profile/domain/model/load_avatar_borders_failure.dart';
import 'package:picnic_app/features/profile/domain/model/save_avatar_border_failure.dart';
import 'package:picnic_app/features/profile/domain/use_cases/load_avatar_borders_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/save_avatar_border_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/send_glitter_bomb_use_case.dart';
//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAppNavigator extends Mock implements AppNavigator {}

// MVP

class MockAchievementsPresenter extends MockCubit<AchievementsViewModel> implements AchievementsPresenter {}

class MockAchievementsPresentationModel extends Mock implements AchievementsPresentationModel {}

class MockAchievementsInitialParams extends Mock implements AchievementsInitialParams {}

class MockAchievementsNavigator extends Mock implements AchievementsNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockFollowUserFailure extends Mock implements FollowUnfollowUserFailure {}

class MockFollowUserUseCase extends Mock implements FollowUnfollowUserUseCase {}

class MockCheckUsernameAvailabilityFailure extends Mock implements CheckUsernameAvailabilityFailure {}

class MockCheckUsernameAvailabilityUseCase extends Mock implements CheckUsernameAvailabilityUseCase {}

class MockLoadAvatarBordersFailure extends Mock implements LoadAvatarBordersFailure {}

class MockLoadAvatarBordersUseCase extends Mock implements LoadAvatarBordersUseCase {}

class MockSaveAvatarBorderFailure extends Mock implements SaveAvatarBorderFailure {}

class MockGetLanguageUseCase extends Mock implements GetLanguagesListUseCase {}

class MockGetLanguageFailure extends Mock implements GetLanguageFailure {}

class MockSaveAvatarBorderUseCase extends Mock implements SaveAvatarBorderUseCase {}

class MockGetRuntimePermissionStatusFailure extends Mock implements GetRuntimePermissionStatusFailure {}

class MockGetRuntimePermissionStatusUseCase extends Mock implements GetRuntimePermissionStatusUseCase {}

class MockRequestRuntimePermissionFailure extends Mock implements RequestRuntimePermissionFailure {}

class MockRequestRuntimePermissionUseCase extends Mock implements RequestRuntimePermissionUseCase {}

class MockSendGlitterBombUseCase extends Mock implements SendGlitterBombUseCase {}

class MockGetUserFailure extends Mock implements GetUserFailure {}

class MockGetUserUseCase extends Mock implements GetUserUseCase {}

class MockSearchUsersUseCase extends Mock implements SearchUsersUseCase {}

class MockGetCollectionsFailure extends Mock implements GetCollectionsFailure {}

class MockGetCollectionsUseCase extends Mock implements GetCollectionsUseCase {}

class MockGetCirclesFailure extends Mock implements GetCirclesFailure {}

class MockGetCirclesUseCase extends Mock implements GetCirclesUseCase {}

class MockGetUserCirclesFailure extends Mock implements GetUserCirclesFailure {}

class MockGetUserCirclesUseCase extends Mock implements GetUserCirclesUseCase {}

class MockBlockUserFailure extends Mock implements BlockUserFailure {}

class MockBlockUserUseCase extends Mock implements BlockUserUseCase {}

class MockLogOutFailure extends Mock implements LogOutFailure {}

class MockLogOutUseCase extends Mock implements LogOutUseCase {}

class MockUnblockUserFailure extends Mock implements UnblockUserFailure {}

class MockUnblockUserUseCase extends Mock implements UnblockUserUseCase {}

class MockAudioPlayerRepository extends Mock implements AudioPlayerRepository {}

class MockControlAudioPlayUseCase extends Mock implements ControlAudioPlayUseCase {}

class MockSavePostToCollectionFailure extends Mock implements SavePostToCollectionFailure {}

class MockSavePostToCollectionUseCase extends Mock implements SavePostToCollectionUseCase {}

class MockSetLanguageFailure extends Mock implements SetLanguageFailure {}

class MockSetLanguageUseCase extends Mock implements SetLanguageUseCase {}

class MockViewPostUseCase extends Mock implements ViewPostUseCase {}

class MockSavePostScreenTimeUseCase extends Mock implements SavePostScreenTimeUseCase {}

class MockViewPostFailure extends Mock implements ViewPostFailure {}

class MockJoinCircleFailure extends Mock implements JoinCircleFailure {}

class MockJoinCircleUseCase extends Mock implements JoinCircleUseCase {}

class MockLeaveCircleFailure extends Mock implements LeaveCircleFailure {}

class MockLeaveCircleUseCase extends Mock implements LeaveCircleUseCase {}

class MockCancelSeedsOfferFailure extends Mock implements CancelSeedsOfferFailure {}

class MockCancelSeedsOfferUseCase extends Mock implements CancelSeedsOfferUseCase {}

class MockRejectSeedsOfferFailure extends Mock implements RejectSeedsOfferFailure {}

class MockRejectSeedsOfferUseCase extends Mock implements RejectSeedsOfferUseCase {}

class MockAcceptSeedsOfferFailure extends Mock implements AcceptSeedsOfferFailure {}

class MockAcceptSeedsOfferUseCase extends Mock implements AcceptSeedsOfferUseCase {}

class MockAddSessionExpiredListenerUseCase extends Mock implements AddSessionExpiredListenerUseCase {}

class MockRemoveSessionExpiredListenerUseCase extends Mock implements RemoveSessionExpiredListenerUseCase {}

class MockGetFeatureFlagsFailure extends Mock implements GetFeatureFlagsFailure {}

class MockGetFeatureFlagsUseCase extends Mock implements GetFeatureFlagsUseCase {}

class MockUpdateCircleFailure extends Mock implements UpdateCircleFailure {}

class MockUpdateCircleUseCase extends Mock implements UpdateCircleUseCase {}

class MockGetPhoneGalleryAssetsFailure extends Mock implements GetPhoneGalleryAssetsFailure {}

class MockGetPhoneGalleryAssetsUseCase extends Mock implements GetPhoneGalleryAssetsUseCase {}

class MockGetAttachmentsUseCase extends Mock implements GetAttachmentsUseCase {}

class MockResolveReportFailure extends Mock implements ResolveReportFailure {}

class MockResolveReportUseCase extends Mock implements ResolveReportUseCase {}

class MockUploadAttachmentUseCase extends Mock implements UploadAttachmentUseCase {}

class MockVideoThumbnailUseCase extends Mock implements VideoThumbnailUseCase {}

class MockHapticFeedbackFailure extends Mock implements HapticFeedbackFailure {}

class MockHapticFeedbackUseCase extends Mock implements HapticFeedbackUseCase {}

class MockAddDeepLinkUseCase extends Mock implements AddDeepLinkUseCase {}

class MockStartUnreadChatsListeningUseCase extends Mock implements StartUnreadChatsListeningUseCase {}

class MockListenToDeepLinksUseCase extends Mock implements ListenToDeepLinksUseCase {}

class MockGetSlicesFailure extends Mock implements GetSlicesFailure {}

class MockGetSlicesUseCase extends Mock implements GetSlicesUseCase {}

class MockGetSliceMemberByRoleUseCase extends Mock implements GetSliceMembersByRoleUseCase {}

class MockGetSliceMembersFailure extends Mock implements GetSliceMembersFailure {}

class MockUpdateSliceFailure extends Mock implements UpdateSliceFailure {}

class MockUpdateSliceUseCase extends Mock implements UpdateSliceUseCase {}

class MockGetCircleStatsFailure extends Mock implements GetCircleStatsFailure {}

class MockGetCircleStatsUseCase extends Mock implements GetCircleStatsUseCase {}

class MockSavePhotoToGalleryFailure extends Mock implements SavePhotoToGalleryFailure {}

class MockSavePhotoToGalleryUseCase extends Mock implements SavePhotoToGalleryUseCase {}

class MockSaveVideoToGalleryUseCase extends Mock implements SaveVideoToGalleryUseCase {}

class MockImageWatermarkUseCase extends Mock implements ImageWatermarkUseCase {}

class MockGetPostCreationCirclesFailure extends Mock implements GetPostCreationCirclesFailure {}

class MockGetPostCreationCirclesUseCase extends Mock implements GetPostCreationCirclesUseCase {}

class MockOpenNativeAppSettingsFailure extends Mock implements OpenNativeAppSettingsFailure {}

class MockOpenNativeAppSettingsUseCase extends Mock implements OpenNativeAppSettingsUseCase {}

class MockGetAppInfoFailure extends Mock implements GetAppInfoFailure {}

class MockSetAppInfoUseCase extends Mock implements SetAppInfoUseCase {}

class MockCopyTextFailure extends Mock implements CopyTextFailure {}

class MockCopyTextUseCase extends Mock implements CopyTextUseCase {}

class MockMentionUserFailure extends Mock implements MentionUserFailure {}

class MockMentionUserUseCase extends Mock implements MentionUserUseCase {}

class MockUploadContactsFailure extends Mock implements UploadContactsFailure {}

class MockUploadContactsUseCase extends Mock implements UploadContactsUseCase {}

class MockJoinSliceFailure extends Mock implements JoinSliceFailure {}

class MockJoinSliceUseCase extends Mock implements JoinSliceUseCase {}

class MockLeaveSliceFailure extends Mock implements LeaveSliceFailure {}

class MockLeaveSliceUseCase extends Mock implements LeaveSliceUseCase {}

class MockUpdateCurrentUserFailure extends Mock implements UpdateCurrentUserFailure {}

class MockUpdateCurrentUserUseCase extends Mock implements UpdateCurrentUserUseCase {}

class MockSharePostFailure extends Mock implements SharePostFailure {}

class MockSharePostUseCase extends Mock implements SharePostUseCase {}

class MockRecaptchaVerificationFailure extends Mock implements RecaptchaVerificationFailure {}

class MockRecaptchaVerificationUseCase extends Mock implements RecaptchaVerificationUseCase {}

class MockNotifyContactFailure extends Mock implements NotifyContactFailure {}

class MockNotifyContactUseCase extends Mock implements NotifyContactUseCase {}

class MockGetContactsUseCase extends Mock implements GetContactsUseCase {}

class MockDeletePostsFailure extends Mock implements DeletePostsFailure {}

class MockDeletePostsUseCase extends Mock implements DeletePostsUseCase {}

class MockUpdateAppBadgeCountUseCase extends Mock implements UpdateAppBadgeCountUseCase {}

class MockIncrementAppBadgeCountUseCase extends Mock implements IncrementAppBadgeCountUseCase {}

class MockGetPhoneContactsUseCase extends Mock implements GetPhoneContactsUseCase {}

class MockSetShouldShowCirclesSelectionFailure extends Mock implements SetShouldShowCirclesSelectionFailure {}

class MockSetShouldShowCirclesSelectionUseCase extends Mock implements SetShouldShowCirclesSelectionUseCase {}

class MockGetShouldShowCirclesSelectionFailure extends Mock implements GetShouldShowCirclesSelectionFailure {}

class MockGetShouldShowCirclesSelectionUseCase extends Mock implements GetShouldShowCirclesSelectionUseCase {}

class MockAddPostToCollectionFailure extends Mock implements AddPostToCollectionFailure {}

class MockAddPostToCollectionUseCase extends Mock implements AddPostToCollectionUseCase {}

class MockGetAuthTokenFailure extends Mock implements GetAuthTokenFailure {}

class MockGetAuthTokenUseCase extends Mock implements GetAuthTokenUseCase {}

class MockGetUserByUsernameFailure extends Mock implements GetUserByUsernameFailure {}

class MockGetUserByUsernameUseCase extends Mock implements GetUserByUsernameUseCase {}

class MockGetCircleByNameFailure extends Mock implements GetCircleByNameFailure {}

class MockGetCircleByNameUseCase extends Mock implements GetCircleByNameUseCase {}

class MockGetUserScopedPodTokenFailure extends Mock implements GetUserScopedPodTokenFailure {}

class MockGetUserScopedPodTokenUseCase extends Mock implements GetUserScopedPodTokenUseCase {}

class MockGetTrendingPodsUseCase extends Mock implements GetTrendingPodsUseCase {}

class MockSearchPodsUseCase extends Mock implements SearchPodsUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockAuthRepository extends Mock implements AuthRepository {}

class MockRuntimePermissionsRepository extends Mock implements RuntimePermissionsRepository {}

class MockUsersRepository extends Mock implements UsersRepository {}

class MockLocalStoreRepository extends Mock implements LocalStorageRepository {}

class MockSecureLocalStoreRepository extends Mock implements SecureLocalStorageRepository {}

class MockBackgroundApiRepository extends Mock implements BackgroundApiRepository {}

class MockPrivateProfileRepository extends Mock implements PrivateProfileRepository {}

class MockCollectionsRepository extends Mock implements CollectionsRepository {}

class MockCirclesRepository extends Mock implements CirclesRepository {}

class MockCirclePostsRepository extends Mock implements CirclePostsRepository {}

class MockSeedsResRepository extends Mock implements SeedsRepository {}

class MockSessionExpiredRepository extends Mock implements SessionExpiredRepository {}

class MockPhoneGalleryRepository extends Mock implements PhoneGalleryRepository {}

class MockDownloadRepository extends Mock implements DownloadRepository {}

class MockAttachmentRepository extends Mock implements AttachmentRepository {}

class MockHapticRepository extends Mock implements HapticRepository {}

class MockDeepLinksRepository extends Mock implements DeepLinksRepository {}

class MockFeatureFlagsRepository extends Mock implements FeatureFlagsRepository {}

class MockPostCreationCirclesRepository extends Mock implements PostCreationCirclesRepository {}

class MockSlicesRepository extends Mock implements SlicesRepository {}

class MockAppInfoRepository extends Mock implements AppInfoRepository {}

class MockRecaptchaRepository extends Mock implements RecaptchaRepository {}

class MockContactsRepository extends Mock implements ContactsRepository {}

class MockGetContactsRepository extends Mock implements ContactsRepository {}

class MockAppBadgeRepository extends Mock implements AppBadgeRepository {}

class MockConnectionStatusRepository extends Mock implements ConnectionStatusRepository {}

class MockCacheManagementRepository extends Mock implements CacheManagementRepository {}

class MockAuthTokenRepository extends Mock implements AuthTokenRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
class MockUserStore extends MockCubit<PrivateProfile> implements UserStore {}

class MockUserCirclesStore extends MockCubit<PaginatedList<BasicCircle>> implements UserCirclesStore {}

class MockAppInfoStore extends MockCubit<AppInfo> implements AppInfoStore {}

class MockUnreadCountersStore extends MockCubit<List<UnreadChat>> implements UnreadCountersStore {}
//DO-NOT-REMOVE STORES_MOCK_DEFINITION

class MockDebouncer extends Mock implements Debouncer {}

class MockThrottler extends Mock implements Throttler {}

class MockPeriodicTaskExecutor extends Mock implements PeriodicTaskExecutor {}

class MockCurrentTimeProvider extends Mock implements CurrentTimeProvider {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseActionsFactory extends Mock implements FirebaseActionsFactory {}

class MockGraphQLClient extends Mock implements GraphQLClient {}

class MockLogInWithPhoneAction extends Mock implements LogInWithPhoneAction {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseUser extends Mock implements firebase.User {}

class MockClipboardManager extends Mock implements ClipboardManager {}

class MockSessionInvalidatedListenersContainer extends Mock implements SessionInvalidatedListenersContainer {}

class MockFeatureFlagsStore extends Mock implements FeatureFlagsStore {}

class MockVideoMuteStore extends Mock implements VideoMuteStore {}

class MockPicnicCameraController extends Mock implements PicnicCameraController {}

class MockEnvironmentConfigProvider extends Mock implements EnvironmentConfigProvider {}

class MockDevicePlatformProvider extends Mock implements DevicePlatformProvider {}

class MockImglyWrapper extends Mock implements ImglyWrapper {}

class MockAssetsLoader extends Mock implements AssetsLoader {}

class MockFxEffect extends Mock implements FxEffect {}

class MockAnalyticsObserver extends Mock implements AnalyticsObserver {}

class MockSharedPreferencesProvider extends Mock implements SharedPreferencesProvider {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockUserPreferencesRepository extends Mock implements UserPreferencesRepository {}

class MockLocalStorageValueListener<T> extends Mock implements LocalStorageValueListener<T> {}

class MockDioClient extends Mock implements dio.Dio {}

class MockPodsRepository extends Mock implements PodsRepository {}
