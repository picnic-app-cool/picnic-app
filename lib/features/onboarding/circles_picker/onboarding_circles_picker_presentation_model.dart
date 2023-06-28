import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/join_circle_failure.dart';
import 'package:picnic_app/core/presentation/model/selectable.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/domain/model/gender.dart';
import 'package:picnic_app/features/onboarding/domain/model/get_interests_failure.dart';
import 'package:picnic_app/features/onboarding/domain/model/interest.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
//ignore: max-length
class OnBoardingCirclesPickerPresentationModel implements OnBoardingCirclesPickerViewModel {
  /// Creates the initial state
  OnBoardingCirclesPickerPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    OnBoardingCirclesPickerInitialParams initialParams,
  )   : onCirclesSelectedCallback = initialParams.onCirclesSelected,
        gender = initialParams.formData.gender,
        selectableInterests = [],
        getInterestsResult = const FutureResult.empty(),
        joinCirclesResult = const FutureResult.empty();

  /// Used for the copyWith method
  OnBoardingCirclesPickerPresentationModel._({
    required this.onCirclesSelectedCallback,
    required this.getInterestsResult,
    required this.selectableInterests,
    required this.joinCirclesResult,
    required this.gender,
  });

  final ValueChanged<List<Id>>? onCirclesSelectedCallback;
  final FutureResult<Either<GetInterestsFailure, List<Interest>>> getInterestsResult;

  final FutureResult<Either<JoinCircleFailure, Unit>> joinCirclesResult;
  final Gender gender;

  /// states the number of circles that are required to be selected in onboarding
  static const requiredNumberOfInterestsInOnBoarding = 3;

  @override
  final List<Selectable<Interest>> selectableInterests;

  @override
  bool get isLoading => getInterestsResult.isPending() || joinCirclesResult.isPending();

  @override
  bool get anythingSelected => selectableInterests.any((selectableInterest) => selectableInterest.selected);

  @override
  int get currentSelectionsCount => selectableInterests.where((it) => it.selected).length;

  @override
  bool get isAcceptButtonEnabled => selectionsLeftCount == 0 && !joinCirclesResult.isPending();

  List<Id> get selectedInterests =>
      selectableInterests.where((interest) => interest.selected).map((interest) => interest.item.id).toList();

  int get selectionsLeftCount =>
      (requiredNumberOfInterestsInOnBoarding - currentSelectionsCount).clamp(0, requiredNumberOfInterestsInOnBoarding);

  OnBoardingCirclesPickerPresentationModel byTogglingInterest(Selectable<Interest> interest) => copyWith(
        selectableInterests: selectableInterests.map(
          (it) {
            return it.item.id == interest.item.id ? it.copyWith(selected: !it.selected) : it;
          },
        ).toList(),
      );

  OnBoardingCirclesPickerPresentationModel copyWith({
    ValueChanged<List<Id>>? onCirclesSelectedCallback,
    List<Selectable<Interest>>? selectableInterests,
    FutureResult<Either<JoinCircleFailure, Unit>>? joinCirclesResult,
    FutureResult<Either<GetInterestsFailure, List<Interest>>>? getInterestsResult,
    Gender? gender,
  }) {
    return OnBoardingCirclesPickerPresentationModel._(
      onCirclesSelectedCallback: onCirclesSelectedCallback ?? this.onCirclesSelectedCallback,
      selectableInterests: selectableInterests ?? this.selectableInterests,
      joinCirclesResult: joinCirclesResult ?? this.joinCirclesResult,
      getInterestsResult: getInterestsResult ?? this.getInterestsResult,
      gender: gender ?? this.gender,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class OnBoardingCirclesPickerViewModel {
  List<Selectable<Interest>> get selectableInterests;

  bool get isLoading;

  bool get anythingSelected;

  int get currentSelectionsCount;

  bool get isAcceptButtonEnabled;
}
