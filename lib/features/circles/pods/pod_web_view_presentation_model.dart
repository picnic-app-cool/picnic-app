import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/features/circles/pods/pod_web_view_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class PodWebViewPresentationModel implements PodWebViewViewModel {
  /// Creates the initial state
  PodWebViewPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    PodWebViewInitialParams initialParams,
  ) : pod = initialParams.pod;

  /// Used for the copyWith method
  PodWebViewPresentationModel._({
    required this.pod,
  });

  @override
  final PodApp pod;

  PodWebViewPresentationModel copyWith({
    PodApp? pod,
  }) {
    return PodWebViewPresentationModel._(
      pod: pod ?? this.pod,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class PodWebViewViewModel {
  PodApp get pod;
}
