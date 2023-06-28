import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/join_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';
import 'package:picnic_app/features/onboarding/domain/model/selectable_interest.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_circles_for_interests_use_case.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_onboarding_interests_use_case.dart';

class OnBoardingCirclesPickerPresenter extends Cubit<OnBoardingCirclesPickerViewModel> {
  OnBoardingCirclesPickerPresenter(
    OnBoardingCirclesPickerPresentationModel model,
    this.navigator,
    this._getInterestsUseCase,
    this._joinCirclesUseCase,
    this._logAnalyticsEventUseCase,
    this._setShouldShowCirclesSelectionUseCase,
    this._getCirclesForInterestsUseCase,
  ) : super(model);

  final OnBoardingCirclesPickerNavigator navigator;
  final GetOnBoardingInterestsUseCase _getInterestsUseCase;
  final JoinCirclesUseCase _joinCirclesUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final SetShouldShowCirclesSelectionUseCase _setShouldShowCirclesSelectionUseCase;
  final GetCirclesForInterestsUseCase _getCirclesForInterestsUseCase;

  // ignore: unused_element
  OnBoardingCirclesPickerPresentationModel get _model => state as OnBoardingCirclesPickerPresentationModel;

  Future<void> onInit() async {
    await _setShouldShowCirclesSelectionUseCase.execute(shouldShow: true);
    _getInterests();
  }

  Future<void> onTapContinue() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingCirclesConfirmButton),
    );

    final selectedInterests = _model.selectedInterests;
    await _getCirclesForInterestsUseCase.execute(selectedInterests).doOn(
          success: (circlesList) async =>
              _joinCirclesUseCase.execute(circleIds: circlesList).observeStatusChanges((result) {
            tryEmit(
              _model.copyWith(
                joinCirclesResult: result,
              ),
            );
            _model.onCirclesSelectedCallback!(circlesList);
          }),
        );
  }

  void onTapInterest(Selectable<Interest> interest) {
    tryEmit(_model.byTogglingInterest(interest));
  }

  void _getInterests() {
    _getInterestsUseCase
        .execute(_model.gender)
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(getInterestsResult: result)),
        )
        .doOn(
          success: (interests) => tryEmit(
            _model.copyWith(
              selectableInterests: interests.map((interest) => interest.toSelectableInterest()).toList(),
            ),
          ),
        );
  }
}
