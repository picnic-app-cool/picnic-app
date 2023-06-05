import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PodBottomSheetPresentationModel implements PodBottomSheetViewModel {
  /// Creates the initial state
  PodBottomSheetPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PodBottomSheetInitialParams initialParams,
  ) : pod = initialParams.pod;

  /// Used for the copyWith method
  PodBottomSheetPresentationModel._({
    required this.pod,
  });

  @override
  final PodApp pod;

  PodBottomSheetPresentationModel byUpdatingPod({
    required PodApp pod,
  }) =>
      copyWith(pod: pod);

  PodBottomSheetPresentationModel copyWith({
    PodApp? pod,
  }) {
    return PodBottomSheetPresentationModel._(
      pod: pod ?? this.pod,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PodBottomSheetViewModel {
  PodApp get pod;
}
