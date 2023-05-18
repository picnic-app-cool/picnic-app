import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/core/fx_effect_overlay/confetti_fx_effect.dart';
import 'package:picnic_app/core/fx_effect_overlay/lottie_fx_effect.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_navigator.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_presentation_model.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_settings/circle_settings_initial_params.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discover/discover_explore/discover_explore_initial_params.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/main/main_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/photo_editor/photo_editor_initial_params.dart';
import 'package:picnic_app/features/profile/private_profile/private_profile_initial_params.dart';
import 'package:picnic_app/features/profile/public_profile/public_profile_initial_params.dart';
import 'package:picnic_app/features/seeds/about_elections/about_elections_initial_params.dart';
import 'package:picnic_app/features/seeds/circle_governance/circle_governance_initial_params.dart';
import 'package:picnic_app/features/seeds/sell_seeds/sell_seeds_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/features/video_editor/video_editor_initial_params.dart';

class FeaturesIndexPresenter extends Cubit<FeaturesIndexViewModel> with SubscriptionsMixin {
  FeaturesIndexPresenter(
    FeaturesIndexPresentationModel model,
    UserStore userStore,
    this.navigator,
  ) : super(model) {
    listenTo<PrivateProfile>(
      stream: userStore.stream,
      subscriptionId: _userStoreSubscription,
      onChange: (user) {
        tryEmit(_model.copyWith(user: user));
      },
    );
  }

  final FeaturesIndexNavigator navigator;

  static const _userStoreSubscription = "userStoreSubscription";

  //TODO: remove hardcoded userId : https://picnic-app.atlassian.net/browse/PG-1794.
  static const _userid = "dcfad499-e897-46e8-a0fa-9a61a7bdaf2a";

  static const _testCircleId = '431a8bc3-221f-47a4-8a06-d9d0fab3b1a0';

  // ignore: unused_element
  FeaturesIndexPresentationModel get _model => state as FeaturesIndexPresentationModel;

  void onTapOnboarding() {
    navigator.openOnboarding(const OnboardingInitialParams());
  }

  void onTapPrivateProfile() => navigator.openPrivateProfile(const PrivateProfileInitialParams());

  void onTapDiscovery() => navigator.openDiscoverExplore(const DiscoverExploreInitialParams());

  void onTapPublicProfile() => navigator.openPublicProfile(
        PublicProfileInitialParams(
          userId: const Id.empty().copyWith(value: _userid),
        ),
      );

  void onTapPhotoEditor() => navigator.openPhotoEditor(const PhotoEditorInitialParams());

  // TODO: Pass this viewType dynamically after the backend implementation
  void onTapCircleSettings() => navigator.openCircleSettings(
        CircleSettingsInitialParams(
          circleRole: CircleRole.director,
          circle: const Circle.empty().copyWith(name: '#roblox'),
        ),
      );

  void onTapVideoEditor() => navigator.openVideoEditor(const VideoEditorInitialParams());

  void onTapInAppNotifications() => navigator.showInAppNotification(message: '@nico likes your post');

  void onTapSellSeeds() => navigator.openSellSeeds(SellSeedsInitialParams(onTransferSeedsCallback: doNothing()));

  void onTapNewSeeds() => navigator.openNewSeeds();

  void onTapCircleElection() =>
      navigator.openCircleGovernance(CircleGovernanceInitialParams(circle: const Circle.empty()));

  void onTapShowDialog() => navigator.openInfoSeeds();

  void onTapMain() => navigator.openMain(const MainInitialParams());

  void onTapGlitterbomb() => navigator
    ..showInAppNotification(message: '@nico glitterbombed you ✨')
    ..showFxEffect(LottieFxEffect.glitter())
    ..showFxEffect(
      ConfettiFxEffect.avatar(_model.user.profileImageUrl),
    );

  void onTapCircleDetails() => navigator.openCircleDetails(
        const CircleDetailsInitialParams(
          circleId: Id(_testCircleId),
        ),
      );

  //TODO open slice creation from circle https://picnic-app.atlassian.net/browse/GS-5261
  void onTapCreateSlice() => navigator.openCreateSlice(
        CreateSliceInitialParams(
          circle: const Circle.empty()
              .copyWith(id: const Id('c3f5f5bf-863a-422c-8e69-bf80fbeef8d1'), name: 'random circle'),
        ),
      );

  //TODO this can be removed once https://picnic-app.atlassian.net/browse/GS-5364 is done
  void onTapSliceDetails() => navigator.openSliceDetails(
        SliceDetailsInitialParams(
          circle: const Circle.empty()
              .copyWith(id: const Id('c3f5f5bf-863a-422c-8e69-bf80fbeef8d1'), name: 'random circle'),
          slice: const Slice.empty().copyWith(
            id: const Id('sliceId'),
            name: 'slice name',
            iJoined: true,
            iRequestedToJoin: false,
            private: true,
          ),
        ),
      );

  void onTapOnBoardingCirclesPicker() => navigator.openOnBoardingCirclesPickerPage(
        OnBoardingCirclesPickerInitialParams(
          // ignore: no-empty-block
          onCirclesSelected: (_) {},
          formData: const OnboardingFormData.empty(),
        ),
      );

  void onTapForceUpdate() => navigator.openForceUpdate(
        const ForceUpdateInitialParams(),
      );

  void onTapAboutElections() => navigator.openAboutElections(const AboutElectionsInitialParams());

  void onTapCircleRole() => navigator.openCircleRole(
        const CircleRoleInitialParams(
          circleId: Id(_testCircleId),
          formType: CircleRoleFormType.createCircleRole,
        ),
      );

  void onTapDiscordIntegration() => navigator.openLinkDiscord(const LinkDiscordInitialParams(circleId: Id.empty()));
}
