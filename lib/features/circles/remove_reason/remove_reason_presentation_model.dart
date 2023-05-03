import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class RemoveReasonPresentationModel implements RemoveReasonViewModel {
  /// Creates the initial state
  RemoveReasonPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    RemoveReasonInitialParams initialParams,
  ) : reason = '';

  /// Used for the copyWith method
  RemoveReasonPresentationModel._({
    required this.reason,
  });

  @override
  final String reason;

  @override
  bool get isButtonEnabled => reason.isNotEmpty;

  RemoveReasonPresentationModel copyWith({String? reason}) {
    return RemoveReasonPresentationModel._(
      reason: reason ?? this.reason,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class RemoveReasonViewModel {
  String get reason;

  bool get isButtonEnabled;
}
