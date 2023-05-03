// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_presentation_model.dart';
import 'package:picnic_app/features/app_init/features_index/features_index_presenter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class FeaturesIndexPage extends StatefulWidget with HasPresenter<FeaturesIndexPresenter> {
  const FeaturesIndexPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final FeaturesIndexPresenter presenter;

  @override
  State<FeaturesIndexPage> createState() => _FeaturesIndexPageState();
}

/// THIS PAGE SERVES ONLY DEMONSTRATION/DEVELOPMENT PURPOSES, IT EASES THE NAVIGATION BETWEEN PAGES
/// AND SHOULD BE EVENTUALLY REMOVED BEFORE RELEASE
class _FeaturesIndexPageState extends State<FeaturesIndexPage>
    with PresenterStateMixin<FeaturesIndexViewModel, FeaturesIndexPresenter, FeaturesIndexPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: stateObserver(
              builder: (context, state) => ListView(
                children: [
                  Text(
                    "Features index",
                    textAlign: TextAlign.center,
                    style: PicnicTheme.of(context).styles.title40,
                  ),
                  if (!state.user.user.isAnonymous)
                    Text(
                      "User:  ${state.user.username}\n",
                      textAlign: TextAlign.center,
                    ),
                  const Gap(8),
                  ElevatedButton(onPressed: presenter.onTapMain, child: const Text("Main Page")),
                  ElevatedButton(onPressed: presenter.onTapOnboarding, child: const Text("Onboarding")),
                  ElevatedButton(onPressed: presenter.onTapPrivateProfile, child: const Text("PrivateProfile")),
                  ElevatedButton(onPressed: presenter.onTapDiscovery, child: const Text("Discovery Explore")),
                  ElevatedButton(onPressed: presenter.onTapPublicProfile, child: const Text("Public Profile")),
                  ElevatedButton(onPressed: presenter.onTapPhotoEditor, child: const Text("Photo Editor")),
                  ElevatedButton(onPressed: presenter.onTapVideoEditor, child: const Text("Video Editor Sample")),
                  ElevatedButton(onPressed: presenter.onTapCircleSettings, child: const Text("Circle Settings")),
                  ElevatedButton(
                    onPressed: presenter.onTapInAppNotifications,
                    child: const Text("In-App Notifications"),
                  ),
                  ElevatedButton(onPressed: presenter.onTapSellSeeds, child: const Text("Sell seeds")),
                  ElevatedButton(onPressed: presenter.onTapCircleElection, child: const Text("Circle election")),
                  ElevatedButton(onPressed: presenter.onTapShowDialog, child: const Text("Show info seed dialog")),
                  ElevatedButton(
                    onPressed: presenter.onTapGlitterbomb,
                    child: const Text("Glitter bomb notification"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapCircleDetails,
                    child: const Text("Circle details"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapCreateSlice,
                    child: const Text("Create slice"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapSliceDetails,
                    child: const Text("Slice details"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapForceUpdate,
                    child: const Text("Force Update Popup"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapOnBoardingCirclesPicker,
                    child: const Text("OnBoarding Circles Selection"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapAboutElections,
                    child: const Text("About Elections"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapCircleRole,
                    child: const Text("Create circle role"),
                  ),
                  ElevatedButton(
                    onPressed: presenter.onTapDiscordIntegration,
                    child: const Text("Link Discord"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
