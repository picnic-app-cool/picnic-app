import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus_platform_interface/package_info_platform_interface.dart';
import 'package:picnic_app/core/data/app_tracking_transparency_initializer.dart';
import 'package:picnic_app/core/data/assets_loader.dart';
import 'package:picnic_app/core/data/audioplayers_audio_player_repository.dart';
import 'package:picnic_app/core/data/background_api_execution_repository.dart';
import 'package:picnic_app/core/data/centrifuge/centrifuge_client_factory.dart';
import 'package:picnic_app/core/data/device_app_info_repository.dart';
import 'package:picnic_app/core/data/device_haptic_repository.dart';
import 'package:picnic_app/core/data/dio_download_repository.dart';
import 'package:picnic_app/core/data/firebase/actions/firebase_actions_factory.dart';
import 'package:picnic_app/core/data/firebase/firebase_background_messages_initializer.dart';
import 'package:picnic_app/core/data/firebase/firebase_dynamic_links_initializer.dart';
import 'package:picnic_app/core/data/firebase/firebase_dynamic_links_source.dart';
import 'package:picnic_app/core/data/firebase/firebase_provider.dart';
import 'package:picnic_app/core/data/firebase_graphql_auth_repository.dart';
import 'package:picnic_app/core/data/flutter_app_badge_repository.dart';
import 'package:picnic_app/core/data/flutter_phone_gallery_repository.dart';
import 'package:picnic_app/core/data/flutter_runtime_permissions_repository.dart';
import 'package:picnic_app/core/data/graphql/graphql_client.dart';
import 'package:picnic_app/core/data/graphql/graphql_client_factory.dart';
import 'package:picnic_app/core/data/graphql/graphql_failure_mapper.dart';
import 'package:picnic_app/core/data/graphql/graphql_logger.dart';
import 'package:picnic_app/core/data/graphql/graphql_unauthenticated_failure_handler.dart';
import 'package:picnic_app/core/data/graphql/graphql_variables_processor.dart';
import 'package:picnic_app/core/data/graphql/isolate/graphql_isolate_dependencies_configurator.dart';
import 'package:picnic_app/core/data/graphql_attachment_repository.dart';
import 'package:picnic_app/core/data/graphql_cache_management_repository.dart';
import 'package:picnic_app/core/data/graphql_circles_repository.dart';
import 'package:picnic_app/core/data/graphql_collections_repository.dart';
import 'package:picnic_app/core/data/graphql_get_contacts_repository.dart';
import 'package:picnic_app/core/data/graphql_pods_repository.dart';
import 'package:picnic_app/core/data/graphql_post_creation_circles_repository.dart';
import 'package:picnic_app/core/data/graphql_seeds_repository.dart';
import 'package:picnic_app/core/data/graphql_slices_repository.dart';
import 'package:picnic_app/core/data/graphql_social_accounts_repository.dart';
import 'package:picnic_app/core/data/graphql_users_repository.dart';
import 'package:picnic_app/core/data/hive/hive_client_factory.dart';
import 'package:picnic_app/core/data/hive/hive_client_primitive_factory.dart';
import 'package:picnic_app/core/data/hive/hive_initializer.dart';
import 'package:picnic_app/core/data/hive/hive_path_provider.dart';
import 'package:picnic_app/core/data/hive_local_storage_repository.dart';
import 'package:picnic_app/core/data/impl_deep_links_repository.dart';
import 'package:picnic_app/core/data/impl_session_expired_repository.dart';
import 'package:picnic_app/core/data/jwt_token_decoder_repository.dart';
import 'package:picnic_app/core/data/local_user_preferences_repository.dart';
import 'package:picnic_app/core/data/mobile_feature_flags_repository.dart';
import 'package:picnic_app/core/data/native_recaptcha_repository.dart';
import 'package:picnic_app/core/data/photo_manager/photo_manager_initializer.dart';
import 'package:picnic_app/core/data/secure_storage/flutter_secure_local_storage_repository.dart';
import 'package:picnic_app/core/data/secure_storage_auth_token_repository.dart';
import 'package:picnic_app/core/data/session_invalidated_listeners_container.dart';
import 'package:picnic_app/core/data/shared_preferences_provider.dart';
import 'package:picnic_app/core/data/universal_links_initializer.dart';
import 'package:picnic_app/core/domain/model/feature_flags/feature_flags_defaults.dart';
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
import 'package:picnic_app/core/domain/repositories/library_initializer.dart';
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
import 'package:picnic_app/core/domain/repositories/social_accounts_repository.dart';
import 'package:picnic_app/core/domain/repositories/token_decoder_repository.dart';
import 'package:picnic_app/core/domain/repositories/user_preferences_repository.dart';
import 'package:picnic_app/core/domain/repositories/users_repository.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/stores/feature_flags_store.dart';
import 'package:picnic_app/core/domain/stores/unread_counters_store.dart';
import 'package:picnic_app/core/domain/stores/user_circles_store.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/domain/use_cases/accept_seeds_offer_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/add_deeplink_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/add_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/add_session_expired_listener_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/block_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/cancel_seeds_offer_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/control_audio_play_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/copy_text_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/delete_posts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_attachments_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_by_name_use_case.dart';
import "package:picnic_app/core/domain/use_cases/get_circle_stats_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/get_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_collections_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_contacts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_feature_flags_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_featured_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_phone_contacts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_phone_gallery_assets_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_post_creation_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_recommended_chats_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_runtime_permission_status_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_slice_members_by_role_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_slices_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_trending_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_by_username_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_scoped_pod_token_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_stats_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/haptic_feedback_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/image_watermark_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/increment_app_badge_count_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/leave_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/leave_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/listen_to_deep_links_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/log_out_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/mention_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/notify_contact_use_case.dart';
import "package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart";
import 'package:picnic_app/core/domain/use_cases/recaptcha_verification_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/reject_seeds_offer_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/remove_session_expired_listener_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_photo_to_gallery_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_screen_time_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_post_to_collection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/save_video_to_gallery_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_pods_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_language_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/share_post_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/unblock_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_app_badge_count_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_circle_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_current_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/update_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/upload_contacts_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/view_post_use_case.dart';
import 'package:picnic_app/core/environment_config/environment_config_provider.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/device_platform_provider.dart';
import 'package:picnic_app/core/utils/periodic_task_executor.dart';
import 'package:picnic_app/core/utils/throttler.dart';
import 'package:picnic_app/core/validators/age_validator.dart';
import 'package:picnic_app/core/validators/exact_length_validator.dart';
import 'package:picnic_app/core/validators/full_name_validator.dart';
import 'package:picnic_app/core/validators/phone_validator.dart';
import 'package:picnic_app/core/validators/username_validator.dart';
import 'package:picnic_app/core/validators/verification_code_validator.dart';
import 'package:picnic_app/features/analytics/dependency_injection/feature_component.dart' as analytics;
import 'package:picnic_app/features/app_init/dependency_injection/feature_component.dart' as app_init;
import 'package:picnic_app/features/avatar_selection/dependency_injection/feature_component.dart' as avatar_selection;
import 'package:picnic_app/features/chat/dependency_injection/feature_component.dart' as chat;
import 'package:picnic_app/features/chat/domain/use_cases/start_unread_chats_listening_use_case.dart';
import 'package:picnic_app/features/circles/dependency_injection/feature_component.dart' as circles;
import 'package:picnic_app/features/connection_status/dependency_injection/feature_component.dart' as connection_status;
import 'package:picnic_app/features/create_circle/dependency_injection/feature_component.dart' as create_circle;
import 'package:picnic_app/features/create_slice/dependency_injection/feature_component.dart' as create_slice;
import 'package:picnic_app/features/debug/dependency_injection/feature_component.dart' as debug;
import 'package:picnic_app/features/deeplink_handler/dependency_injection/feature_component.dart' as deeplink_handler;
import 'package:picnic_app/features/discord/dependency_injection/feature_component.dart' as discord;
import 'package:picnic_app/features/discover/dependency_injection/feature_component.dart' as discover;
import 'package:picnic_app/features/feed/dependency_injection/feature_component.dart' as feed;
import 'package:picnic_app/features/force_update/dependency_injection/feature_component.dart' as force_update;
import 'package:picnic_app/features/image_picker/dependency_injection/feature_component.dart' as image_picker;
import 'package:picnic_app/features/in_app_events/dependency_injection/feature_component.dart' as in_app_notifications;
import "package:picnic_app/features/loading_splash/dependency_injection/feature_component.dart" as loading_splash;
import 'package:picnic_app/features/main/dependency_injection/feature_component.dart' as main;
import 'package:picnic_app/features/media_picker/dependency_injection/feature_component.dart' as media_picker;
import 'package:picnic_app/features/onboarding/dependency_injection/feature_component.dart' as onboarding;
import 'package:picnic_app/features/photo_editor/dependency_injection/feature_component.dart' as photo_editor;
import 'package:picnic_app/features/pods/dependency_injection/feature_component.dart' as pods;
import 'package:picnic_app/features/posts/dependency_injection/feature_component.dart' as post_creation;
import 'package:picnic_app/features/profile/achievements/achievements_initial_params.dart';
import 'package:picnic_app/features/profile/achievements/achievements_navigator.dart';
import 'package:picnic_app/features/profile/achievements/achievements_page.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presentation_model.dart';
import 'package:picnic_app/features/profile/achievements/achievements_presenter.dart';
import 'package:picnic_app/features/profile/data/graphql_private_profile_repository.dart';
import 'package:picnic_app/features/profile/dependency_injection/feature_component.dart' as profile;
import 'package:picnic_app/features/profile/domain/use_cases/load_avatar_borders_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/save_avatar_border_use_case.dart';
import 'package:picnic_app/features/push_notifications/dependency_injection/feature_component.dart'
    as push_notifications;
import 'package:picnic_app/features/reports/dependency_injection/feature_component.dart' as reports;
import 'package:picnic_app/features/seeds/dependency_injection/feature_component.dart' as seeds;
import 'package:picnic_app/features/settings/dependency_injection/feature_component.dart' as settings;
import 'package:picnic_app/features/slices/dependency_injection/feature_component.dart' as slices;
import 'package:picnic_app/features/social_accounts/dependency_injection/feature_component.dart' as social_accounts;
import 'package:picnic_app/features/user_agreement/dependency_injection/feature_component.dart' as user_agreement;
import 'package:picnic_app/features/video_editor/dependency_injection/feature_component.dart' as video_editor;
import 'package:picnic_app/firebase_options.dart';

//DO-NOT-REMOVE APP_COMPONENT_IMPORTS
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/utils/root_navigator_observer.dart';
import 'package:picnic_app/picnic_app_init_params.dart';
import 'package:picnic_app/ui/widgets/video_player/video_player_controller_factory.dart';
import 'package:picnic_app/utils/clipboard_manager.dart';
import 'package:recaptcha_verification/recaptcha_verification.dart';

final getIt = GetIt.instance;

T maybeGetIt<T extends Object>({required T Function() orElse}) {
  return getIt.isRegistered<T>() ? getIt() : orElse();
}

/// registers all the dependencies in dependency graph in get_it package
// ignore: long-method
void configureDependencies(
  PicnicAppInitParams initParams,
) {
  onboarding.configureDependencies();
  feed.configureDependencies();
  app_init.configureDependencies();
  profile.configureDependencies();
  post_creation.configureDependencies();
  settings.configureDependencies();
  avatar_selection.configureDependencies();
  circles.configureDependencies();
  chat.configureDependencies();
  discover.configureDependencies();
  photo_editor.configureDependencies();
  image_picker.configureDependencies();
  media_picker.configureDependencies();
  push_notifications.configureDependencies();
  video_editor.configureDependencies();
  seeds.configureDependencies();
  main.configureDependencies();
  debug.configureDependencies();
  reports.configureDependencies();
  create_circle.configureDependencies();
  create_slice.configureDependencies();
  deeplink_handler.configureDependencies();
  in_app_notifications.configureDependencies();
  loading_splash.configureDependencies();
  analytics.configureDependencies();
  slices.configureDependencies();
  force_update.configureDependencies();
  user_agreement.configureDependencies();
  connection_status.configureDependencies();
  discord.configureDependencies();
  pods.configureDependencies();
  social_accounts.configureDependencies();
//DO-NOT-REMOVE FEATURE_COMPONENT_INIT

  _configureGeneralDependencies(initParams);
  _configureRepositories();
  _configureStores();
  _configureUseCases();
  _configureMvp();
  _configureFirebase();
}

//ignore: long-method
void _configureFirebase() {
  getIt //
    ..registerFactory(() => FirebaseProvider(getIt()))
    ..registerFactory<FirebaseOptions>(
      () => DefaultFirebaseOptions.currentPlatform,
    )
    ..registerFactory<PackageInfoPlatform>(
      () => PackageInfoPlatform.instance,
    )
    ..registerFactory(
      () => FirebaseActionsFactory(
        getIt(),
        getIt(),
      ),
    )
    ..registerLazySingleton<GoogleSignIn>(
      () {
        String? clientId;
        switch (defaultTargetPlatform) {
          case TargetPlatform.android:
            clientId = null;
            break;
          case TargetPlatform.fuchsia:
          case TargetPlatform.linux:
          case TargetPlatform.macOS:
          case TargetPlatform.windows:
            clientId = null;
            break;
          case TargetPlatform.iOS:
            clientId = getIt<FirebaseOptions>().iosClientId;
            break;
        }
        return GoogleSignIn(clientId: clientId);
      },
    );
}

//ignore: long-method
void _configureGeneralDependencies(
  PicnicAppInitParams appInitParams,
) {
  getIt
        ..registerFactory(() => appInitParams)
        ..registerFactory(() => GraphQLIsolateDependenciesConfigurator())
        ..registerFactory<EnvironmentConfigProvider>(
          () => appInitParams.environmentConfigProvider,
        )
        ..registerFactory<FeatureFlagsDefaults>(
          () => appInitParams.featureFlagsDefaults,
        )
        ..registerFactory<AppNavigator>(
          () => AppNavigator(),
        )
        ..registerFactory(() => Debouncer())
        ..registerFactory(() => Throttler())
        ..registerFactory(() => PhoneValidator())
        ..registerFactory(
          () => AgeValidator(),
        )
        ..registerFactory(
          () => UsernameValidator(),
        )
        ..registerFactory(
          () => FullNameValidator(),
        )
        ..registerFactoryParam<ExactLengthValidator, int, dynamic>(
          (length, _) => ExactLengthValidator(
            length: length,
          ),
        )
        ..registerFactory(
          () => VerificationCodeValidator(
            exactLengthValidator: getIt(param1: VerificationCodeValidator.codeLength),
          ),
        )
        ..registerFactory(() => CurrentTimeProvider())
        ..registerFactory(() => DevicePlatformProvider())
        ..registerFactory(() => PeriodicTaskExecutor())
        ..registerFactory(() => GraphQLLogger(getIt()))
        ..registerFactory(() => const GraphQLFailureMapper())
        ..registerFactory(() => GraphQLVariablesProcessor())
        ..registerFactory(() => AssetsLoader())
        ..registerFactory(
          () {
            return GraphQLUnauthenticatedFailureHandler(getIt(), getIt());
          },
        )
        ..registerFactory(
          () => GraphqlClientFactory(
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
        ..registerLazySingleton<GraphQLClient>(
          () => GraphQLClient(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory(() => HivePathProvider())
        ..registerLazySingleton<BackgroundApiRepository>(
          () => BackgroundApiExecutionRepository(),
        )
        ..registerFactory(() => HiveClientFactory())
        ..registerFactory(() => HiveClientPrimitiveFactory())
        ..registerFactory<List<LibraryInitializer>>(
          () => [
            AppTrackingTransparencyInitializer(),
            HiveInitializer(),
            PhotoManagerInitializer(getIt()),
            FirebaseDynamicLinksInitializer(getIt()),
            UniversalLinksInitializer(),
            FirebaseBackgroundMessagesInitializer(getIt()),
          ],
        )
        ..registerLazySingleton<RootNavigatorObserver>(
          () => RootNavigatorObserver(),
        )
        ..registerFactory<ClipboardManager>(() => ClipboardManager())
        ..registerFactory(() => CentrifugeClientFactory())
        ..registerFactory(() => FirebaseDynamicLinksSource())
        ..registerFactory(() => RecaptchaVerification())
        ..registerFactory(() => SharedPreferencesProvider())
        ..registerFactory(() => VideoPlayerControllerFactory())
      //DO-NOT-REMOVE GENERAL_DEPS_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureRepositories() {
  // ignore: unnecessary_statements
  getIt
        ..registerLazySingleton<AuthRepository>(
          () => FirebaseGraphqlAuthRepository(
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerLazySingleton<SessionInvalidatedListenersContainer>(
          () {
            return SessionInvalidatedListenersContainer();
          },
        )
        ..registerFactory<RuntimePermissionsRepository>(
          () => const FlutterRuntimePermissionsRepository(),
        )
        ..registerFactory<UsersRepository>(
          () => GraphqlUsersRepository(
            getIt(),
            getIt(),
          ), //TODO replace it with New backend
        )
        ..registerFactory<LocalStorageRepository>(
          () => HiveLocalStorageRepository(
            getIt(),
          ),
        )
        ..registerLazySingleton<SecureLocalStorageRepository>(
          () => FlutterSecureLocalStorageRepository(),
        )
        ..registerFactory<PrivateProfileRepository>(
          () => GraphqlPrivateProfileRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CollectionsRepository>(
          () => GraphqlCollectionsRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CirclesRepository>(
          () => GraphqlCirclesRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<AttachmentRepository>(
          () => GraphqlAttachmentRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<SeedsRepository>(
          () => GraphqlSeedsRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<SessionExpiredRepository>(
          () => ImplSessionExpiredRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<PhoneGalleryRepository>(
          () => FlutterPhoneGalleryRepository(),
        )
        ..registerFactory<DownloadRepository>(
          () => DioDownloadRepository(),
        )
        ..registerFactory<HapticRepository>(
          () => const DeviceHapticRepository(),
        )
        ..registerLazySingleton<DeepLinksRepository>(
          () => ImplDeepLinksRepository(),
        )
        ..registerFactory<SlicesRepository>(
          () => GraphqlSlicesRepository(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<FeatureFlagsRepository>(
          () => MobileFeatureFlagsRepository(getIt()),
        )
        ..registerFactory<PostCreationCirclesRepository>(
          () => GraphqlPostCreationCirclesRepository(getIt()),
        )
        ..registerFactory<AppInfoRepository>(
          () => const DeviceAppInfoRepository(),
        )
        ..registerFactory<RecaptchaRepository>(
          () => NativeRecaptchaRepository(getIt()),
        )
        ..registerFactory<ContactsRepository>(
          () => GraphQlGetContactsRepository(getIt()),
        )
        ..registerFactory<UserPreferencesRepository>(
          () => LocalUserPreferencesRepository(getIt()),
        )
        ..registerFactory<AppBadgeRepository>(
          () => FlutterAppBadgeRepository(getIt()),
        )
        ..registerFactory<CacheManagementRepository>(
          () => GraphqlCacheManagementRepository(
            getIt(),
          ),
        )
        ..registerLazySingleton<AuthTokenRepository>(
          () => SecureStorageAuthTokenRepository(
            getIt(),
          ),
        )
        ..registerLazySingleton<TokenDecoderRepository>(
          () => JwtTokenDecoderRepository(),
        )
        ..registerFactory<PodsRepository>(
          () => GraphqlPodsRepository(
            getIt(),
          ),
        )
        ..registerFactory<SocialAccountsRepository>(
          () => GraphqlSocialAccountsRepository(
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
        ..registerLazySingleton<UserStore>(
          () => UserStore(),
        )
        ..registerLazySingleton<UserCirclesStore>(
          () => UserCirclesStore(),
        )
        ..registerLazySingleton<FeatureFlagsStore>(
          () => FeatureFlagsStore(
            featureFlagsDefaults: getIt(),
          ),
        )
        ..registerLazySingleton<AppInfoStore>(
          () => AppInfoStore(),
        )
        ..registerLazySingleton<UnreadCountersStore>(
          () => UnreadCountersStore(),
        )
      //DO-NOT-REMOVE STORES_GET_IT_CONFIG
      ;
}

//ignore: long-method
void _configureUseCases() {
  // ignore: unnecessary_statements
  getIt
        ..registerFactory<LoadAvatarBordersUseCase>(
          () => const LoadAvatarBordersUseCase(),
        )
        ..registerFactory<SaveAvatarBorderUseCase>(
          () => const SaveAvatarBorderUseCase(),
        )
        ..registerFactory<GetRuntimePermissionStatusUseCase>(
          () => GetRuntimePermissionStatusUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RequestRuntimePermissionUseCase>(
          () => RequestRuntimePermissionUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserUseCase>(
          () => GetUserUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserStatsUseCase>(
          () => GetUserStatsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCollectionsUseCase>(
          () => GetCollectionsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetCirclesUseCase>(
          () => GetCirclesUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserCirclesUseCase>(
          () => GetUserCirclesUseCase(getIt()),
        )
        ..registerFactory<SearchUsersUseCase>(
          () => SearchUsersUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<BlockUserUseCase>(
          () => BlockUserUseCase(
            getIt(),
          ),
        )
        ..registerFactory<LogOutUseCase>(
          () => LogOutUseCase(
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<UnblockUserUseCase>(
          () => UnblockUserUseCase(
            getIt(),
          ),
        )
        ..registerLazySingleton<AudioPlayerRepository>(
          () => AudioPlayersAudioPlayerRepository(),
        )
        ..registerFactory<ControlAudioPlayUseCase>(
          () => ControlAudioPlayUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SavePostToCollectionUseCase>(
          () => SavePostToCollectionUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<SetLanguageUseCase>(
          () => SetLanguageUseCase(
            getIt(),
          ),
        )
        ..registerFactory<ViewPostUseCase>(
          () => ViewPostUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SavePostScreenTimeUseCase>(
          () => SavePostScreenTimeUseCase(
            getIt(),
          ),
        )
        ..registerFactory<JoinCircleUseCase>(
          () => JoinCircleUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<JoinCirclesUseCase>(
          () => JoinCirclesUseCase(getIt()),
        )
        ..registerFactory<LeaveCircleUseCase>(
          () => LeaveCircleUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CancelSeedsOfferUseCase>(
          () => CancelSeedsOfferUseCase(
            getIt(),
          ),
        )
        ..registerFactory<AcceptSeedsOfferUseCase>(
          () => AcceptSeedsOfferUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RejectSeedsOfferUseCase>(
          () => RejectSeedsOfferUseCase(
            getIt(),
          ),
        )
        ..registerFactory<AddSessionExpiredListenerUseCase>(
          () => AddSessionExpiredListenerUseCase(
            getIt(),
          ),
        )
        ..registerFactory<RemoveSessionExpiredListenerUseCase>(
          () => RemoveSessionExpiredListenerUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetFeatureFlagsUseCase>(
          () => GetFeatureFlagsUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<UpdateCircleUseCase>(
          () => UpdateCircleUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetPhoneGalleryAssetsUseCase>(
          () => GetPhoneGalleryAssetsUseCase(getIt()),
        )
        ..registerFactory<GetAttachmentsUseCase>(
          () => GetAttachmentsUseCase(getIt()),
        )
        ..registerFactory<HapticFeedbackUseCase>(
          () => HapticFeedbackUseCase(getIt()),
        )
        ..registerFactory<AddDeepLinkUseCase>(
          () => AddDeepLinkUseCase(getIt()),
        )
        ..registerFactory<ListenToDeepLinksUseCase>(
          () => ListenToDeepLinksUseCase(getIt()),
        )
        ..registerFactory<SavePhotoToGalleryUseCase>(
          () => SavePhotoToGalleryUseCase(getIt()),
        )
        ..registerFactory<SaveVideoToGalleryUseCase>(
          () => SaveVideoToGalleryUseCase(getIt()),
        )
        ..registerFactory<ImageWatermarkUseCase>(
          () => ImageWatermarkUseCase(getIt()),
        )
        ..registerFactory<GetCircleStatsUseCase>(
          () => GetCircleStatsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetPostCreationCirclesUseCase>(
          () => GetPostCreationCirclesUseCase(getIt()),
        )
        ..registerFactory<GetSlicesUseCase>(
          () => GetSlicesUseCase(getIt()),
        )
        ..registerFactory<GetRecommendedChatsUseCase>(
          () => GetRecommendedChatsUseCase(getIt()),
        )
        ..registerFactory<GetSliceMembersByRoleUseCase>(
          () => GetSliceMembersByRoleUseCase(getIt()),
        )
        ..registerFactory<OpenNativeAppSettingsUseCase>(
          () => OpenNativeAppSettingsUseCase(getIt()),
        )
        ..registerFactory<SetAppInfoUseCase>(
          () => SetAppInfoUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<CopyTextUseCase>(
          () => CopyTextUseCase(getIt()),
        )
        ..registerFactory<MentionUserUseCase>(
          () => MentionUserUseCase(getIt()),
        )
        ..registerFactory<UpdateSliceUseCase>(
          () => UpdateSliceUseCase(getIt()),
        )
        ..registerFactory<JoinSliceUseCase>(
          () => JoinSliceUseCase(getIt()),
        )
        ..registerFactory<LeaveSliceUseCase>(
          () => LeaveSliceUseCase(getIt()),
        )
        ..registerFactory<UpdateCurrentUserUseCase>(
          () => UpdateCurrentUserUseCase(getIt()),
        )
        ..registerFactory<SharePostUseCase>(
          () => SharePostUseCase(
            (getIt()),
          ),
        )
        ..registerFactory<RecaptchaVerificationUseCase>(
          () => RecaptchaVerificationUseCase(getIt()),
        )
        ..registerFactory<UploadContactsUseCase>(
          () => UploadContactsUseCase(getIt()),
        )
        ..registerFactory<NotifyContactUseCase>(
          () => NotifyContactUseCase(getIt()),
        )
        ..registerFactory<GetContactsUseCase>(
          () => GetContactsUseCase(getIt()),
        )
        ..registerFactory<DeletePostsUseCase>(
          () => DeletePostsUseCase(getIt()),
        )
        ..registerFactory<StartUnreadChatsListeningUseCase>(
          () => StartUnreadChatsListeningUseCase(getIt(), getIt()),
        )
        ..registerFactory<UpdateAppBadgeCountUseCase>(
          () => UpdateAppBadgeCountUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<IncrementAppBadgeCountUseCase>(
          () => IncrementAppBadgeCountUseCase(
            getIt(),
            getIt(),
          ),
        )
        ..registerFactory<GetPhoneContactsUseCase>(
          () => GetPhoneContactsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SetShouldShowCirclesSelectionUseCase>(
          () => SetShouldShowCirclesSelectionUseCase(getIt()),
        )
        ..registerFactory<GetShouldShowCirclesSelectionUseCase>(
          () => GetShouldShowCirclesSelectionUseCase(getIt()),
        )
        ..registerFactory<AddPostToCollectionUseCase>(
          () => AddPostToCollectionUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetUserByUsernameUseCase>(
          () => GetUserByUsernameUseCase(getIt()),
        )
        ..registerFactory<GetCircleByNameUseCase>(
          () => GetCircleByNameUseCase(getIt()),
        )
        ..registerFactory<GetUserScopedPodTokenUseCase>(
          () => GetUserScopedPodTokenUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetTrendingPodsUseCase>(
          () => GetTrendingPodsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<SearchPodsUseCase>(
          () => SearchPodsUseCase(
            getIt(),
          ),
        )
        ..registerFactory<GetFeaturedPodsUseCase>(
          () => GetFeaturedPodsUseCase(
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
        ..registerFactory<AchievementsNavigator>(
          () => AchievementsNavigator(getIt()),
        )
        ..registerFactoryParam<AchievementsPresentationModel, AchievementsInitialParams, dynamic>(
          (params, _) => AchievementsPresentationModel.initial(params),
        )
        ..registerFactoryParam<AchievementsPresenter, AchievementsInitialParams, dynamic>(
          (initialParams, _) => AchievementsPresenter(
            getIt(param1: initialParams),
            getIt(),
          ),
        )
        ..registerFactoryParam<AchievementsPage, AchievementsInitialParams, dynamic>(
          (initialParams, _) => AchievementsPage(
            presenter: getIt(param1: initialParams),
          ),
        )

      //DO-NOT-REMOVE MVP_GET_IT_CONFIG

      ;
}
