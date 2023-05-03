import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DeleteAccountReasonsPresentationModel implements DeleteAccountReasonsViewModel {
  /// Creates the initial state
  DeleteAccountReasonsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DeleteAccountReasonsInitialParams initialParams,
  ) : reasons = initialParams.reasons;

  /// Used for the copyWith method
  DeleteAccountReasonsPresentationModel._({
    required this.reasons,
  });

  @override
  final List<DeleteAccountReason> reasons;

  DeleteAccountReasonsPresentationModel copyWith({
    List<DeleteAccountReason>? reasons,
  }) {
    return DeleteAccountReasonsPresentationModel._(
      reasons: reasons ?? this.reasons,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DeleteAccountReasonsViewModel {
  List<DeleteAccountReason> get reasons;
}
