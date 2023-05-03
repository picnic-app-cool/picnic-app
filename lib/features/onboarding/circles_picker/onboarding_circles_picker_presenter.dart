import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/use_cases/join_circles_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/set_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/onboarding/circles_picker/model/selectable_onboarding_circles_section.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_onboarding_circles_use_case.dart';

class OnBoardingCirclesPickerPresenter extends Cubit<OnBoardingCirclesPickerViewModel> {
  OnBoardingCirclesPickerPresenter(
    OnBoardingCirclesPickerPresentationModel model,
    this.navigator,
    this._getGroupedCirclesUseCase,
    this._joinCirclesUseCase,
    this._logAnalyticsEventUseCase,
    this._setShouldShowCirclesSelectionUseCase,
  ) : super(model);

  final OnBoardingCirclesPickerNavigator navigator;
  final GetOnBoardingCirclesUseCase _getGroupedCirclesUseCase;
  final JoinCirclesUseCase _joinCirclesUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final SetShouldShowCirclesSelectionUseCase _setShouldShowCirclesSelectionUseCase;

  // ignore: unused_element
  OnBoardingCirclesPickerPresentationModel get _model => state as OnBoardingCirclesPickerPresentationModel;

  Future<void> onInit() async {
    await _setShouldShowCirclesSelectionUseCase.execute(shouldShow: true);
    _getGroupings();
  }

  Future<void> onTapAccept() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingCirclesConfirmButton),
    );

    final selectedCircles = _model.selectedCircles;
    await _joinCirclesUseCase
        .execute(circleIds: selectedCircles.map((circles) => circles.id).toList())
        .observeStatusChanges(
          (result) => tryEmit(
            _model.copyWith(
              joinCirclesResult: result,
            ),
          ),
        );
    await _setShouldShowCirclesSelectionUseCase.execute(shouldShow: false);
    _model.onCirclesSelectedCallback!(selectedCircles);
  }

  void onTapCircle(Selectable<BasicCircle> circle) {
    final newCircleGroups = _model.selectableCirclesSectionsList.byTogglingCircleSelection(circle.item);
    tryEmit(_model.byUpdatingCirclesGroup(newCircleGroups));
  }

  void _getGroupings() => _getGroupedCirclesUseCase.execute().observeStatusChanges(
        (result) => tryEmit(
          _model.copyWith(
            selectableCirclesSectionResult: result.mapSuccess(
              (success) => success.toSelectableCirclesSection(),
            ),
          ),
        ),
      );
}
