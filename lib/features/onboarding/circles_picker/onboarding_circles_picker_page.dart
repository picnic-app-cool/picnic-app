// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/circles_picker/widgets/circles_picker_top_section.dart';
import 'package:picnic_app/features/onboarding/circles_picker/widgets/group_of_selectable_circles.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class OnboardingCirclesPickerPage extends StatefulWidget with HasPresenter<OnBoardingCirclesPickerPresenter> {
  const OnboardingCirclesPickerPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final OnBoardingCirclesPickerPresenter presenter;

  @override
  State<OnboardingCirclesPickerPage> createState() => _OnboardingCirclesPickerPageState();
}

class _OnboardingCirclesPickerPageState extends State<OnboardingCirclesPickerPage>
    with
        PresenterStateMixin<OnBoardingCirclesPickerViewModel, OnBoardingCirclesPickerPresenter,
            OnboardingCirclesPickerPage> {
  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PicnicAppBar(
        showBackButton: false,
        actions: [
          stateObserver(
            builder: (context, state) => PicnicContainerIconButton(
              onTap: state.isAcceptButtonEnabled ? presenter.onTapAccept : null,
              iconPath: Assets.images.check.path,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: stateObserver(
            builder: (context, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CirclesPickerTopSection(
                  selectionsLeftCount: state.selectionsLeftCount,
                  anythingSelected: state.anythingSelected,
                ),
                AnimatedSwitcher(
                  duration: const ShortDuration(),
                  child: state.isLoading
                      ? const PicnicLoadingIndicator()
                      : ListView.separated(
                          padding: const EdgeInsets.all(24),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.selectableCirclesSectionsList.length,
                          separatorBuilder: (BuildContext context, int index) => const Gap(24),
                          itemBuilder: (BuildContext context, int index) {
                            final groupedCircles = state.selectableCirclesSectionsList[index];
                            return GroupOfSelectableCircles(
                              selectableGroupedCircles: groupedCircles,
                              onTapCircle: presenter.onTapCircle,
                              groupIndex: index,
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
