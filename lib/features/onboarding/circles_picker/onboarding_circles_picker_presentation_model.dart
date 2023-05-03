import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/circles/domain/model/get_onboarding_circles_failure.dart';
import 'package:picnic_app/features/onboarding/circles_picker/model/selectable_onboarding_circles_section.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
//ignore: max-length
class OnBoardingCirclesPickerPresentationModel implements OnBoardingCirclesPickerViewModel {
  /// Creates the initial state
  OnBoardingCirclesPickerPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    OnBoardingCirclesPickerInitialParams initialParams,
  )   : onCirclesSelectedCallback = initialParams.onCirclesSelected,
        selectableCirclesSectionResult = const FutureResult.empty(),
        joinCirclesResult = const FutureResult.empty();

  /// Used for the copyWith method
  OnBoardingCirclesPickerPresentationModel._({
    required this.onCirclesSelectedCallback,
    required this.selectableCirclesSectionResult,
    required this.joinCirclesResult,
  });

  final ValueChanged<List<BasicCircle>>? onCirclesSelectedCallback;
  final FutureResult<Either<GetOnBoardingCirclesFailure, List<SelectableOnBoardingCirclesSection>>>
      selectableCirclesSectionResult;

  final FutureResult<Either<JoinCircleFailure, Unit>> joinCirclesResult;

  @override
  List<SelectableOnBoardingCirclesSection> get selectableCirclesSectionsList =>
      selectableCirclesSectionResult.getSuccess() ?? [];

  @override
  bool get isLoading => selectableCirclesSectionResult.isPending() || joinCirclesResult.isPending();

  @override
  bool get anythingSelected => selectableCirclesSectionsList.anythingSelected;

  @override
  int get selectionsLeftCount =>
      (Circle.requiredNumberOfCirclesInOnBoarding - selectableCirclesSectionsList.selectionsCount)
          .clamp(0, Circle.requiredNumberOfCirclesInOnBoarding);

  @override
  bool get isAcceptButtonEnabled => selectionsLeftCount == 0 && !joinCirclesResult.isPending();

  List<BasicCircle> get selectedCircles => selectableCirclesSectionsList.selectedCircles;

  OnBoardingCirclesPickerPresentationModel byUpdatingCirclesGroup(
    List<SelectableOnBoardingCirclesSection> newCircleGroups,
  ) =>
      copyWith(
        selectableCirclesSectionResult: selectableCirclesSectionResult.mapSuccess((_) => newCircleGroups),
      );

  OnBoardingCirclesPickerPresentationModel copyWith({
    ValueChanged<List<BasicCircle>>? onCirclesSelectedCallback,
    FutureResult<Either<GetOnBoardingCirclesFailure, List<SelectableOnBoardingCirclesSection>>>?
        selectableCirclesSectionResult,
    FutureResult<Either<JoinCircleFailure, Unit>>? joinCirclesResult,
  }) {
    return OnBoardingCirclesPickerPresentationModel._(
      onCirclesSelectedCallback: onCirclesSelectedCallback ?? this.onCirclesSelectedCallback,
      selectableCirclesSectionResult: selectableCirclesSectionResult ?? this.selectableCirclesSectionResult,
      joinCirclesResult: joinCirclesResult ?? this.joinCirclesResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class OnBoardingCirclesPickerViewModel {
  List<SelectableOnBoardingCirclesSection> get selectableCirclesSectionsList;

  bool get isLoading;

  bool get anythingSelected;

  int get selectionsLeftCount;

  bool get isAcceptButtonEnabled;
}
