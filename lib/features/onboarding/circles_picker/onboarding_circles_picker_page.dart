// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/circles_picker/widgets/interests_selection_section.dart';
import 'package:picnic_app/features/onboarding/circles_picker/widgets/more_interests_selection_widget.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
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
  static const _personIconSize = 40.0;
  static const _enabledButtonOpacity = 1.0;
  static const _disabledButtonOpacity = 0.5;

  @override
  void initState() {
    super.initState();
    presenter.onInit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite600 = colors.blackAndWhite.shade600;
    return Scaffold(
      appBar: const PicnicAppBar(),
      body: SafeArea(
        child: stateObserver(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Assets.images.multiplePersons.image(
                    width: _personIconSize,
                    height: _personIconSize,
                    fit: BoxFit.contain,
                  ),
                ),
                const Gap(8),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    appLocalizations.pickInterestsTitle,
                    style: theme.styles.title60,
                  ),
                ),
                const Gap(8),
                Center(
                  child: Text(
                    appLocalizations.pickInterestsDescription,
                    style: theme.styles.body30.copyWith(color: blackAndWhite600),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(24),
                AnimatedSwitcher(
                  duration: const ShortDuration(),
                  child: state.isLoading
                      ? const PicnicLoadingIndicator()
                      : InterestsSelectionSection(
                          selectableInterests: state.selectableInterests,
                          onTapInterest: presenter.onTapInterest,
                        ),
                ),
                const Gap(24),
                if (state.hasMoreInterests)
                  MoreInterestsSelectionWidget(
                    selectableInterests: state.moreInterests,
                    onTapInterest: presenter.onTapInterest,
                    onTapMore: presenter.onTapMore,
                    isExpanded: state.isMoreInterestsExpanded,
                  ),
                const Spacer(),
                stateObserver(
                  builder: (context, state) => SizedBox(
                    width: double.infinity,
                    child: PicnicButton(
                      opacity: state.isAcceptButtonEnabled ? _enabledButtonOpacity : _disabledButtonOpacity,
                      onTap: state.isAcceptButtonEnabled ? presenter.onTapContinue : null,
                      color: colors.blue,
                      title: state.isAcceptButtonEnabled
                          ? appLocalizations.continueAction
                          : appLocalizations.youSelectedSome(
                              state.currentSelectionsCount,
                              OnBoardingCirclesPickerPresentationModel.requiredNumberOfInterestsInOnBoarding,
                            ),
                    ),
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
