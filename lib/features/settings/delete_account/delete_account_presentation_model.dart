import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/profile/domain/model/document_entity_type.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason_input.dart';
import 'package:picnic_app/features/settings/domain/model/get_delete_account_reasons_failure.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class DeleteAccountPresentationModel implements DeleteAccountViewModel {
  /// Creates the initial state
  DeleteAccountPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    DeleteAccountInitialParams initialParams,
    this.currentTimeProvider,
  )   : deleteAccountReasonInput = const DeleteAccountReasonInput.empty(),
        deleteChallengeText = "",
        reasonsResult = const FutureResult.empty(),
        documentEntityType = initialParams.reportEntityType;

  /// Used for the copyWith method
  DeleteAccountPresentationModel._({
    required this.deleteAccountReasonInput,
    required this.deleteChallengeText,
    required this.currentTimeProvider,
    required this.reasonsResult,
    required this.documentEntityType,
  });

  @override
  final DeleteAccountReasonInput deleteAccountReasonInput;

  @override
  final CurrentTimeProvider currentTimeProvider;

  final String deleteChallengeText;

  final FutureResult<Either<GetDeleteAccountReasonsFailure, List<DeleteAccountReason>>> reasonsResult;

  final DocumentEntityType documentEntityType;

  //TODO This deadline should be provided by backend or give as a fixed value by business
  @override
  DateTime get deadline => currentTimeProvider.currentTime.add(const Duration(minutes: 20));

  @override
  bool get deleteAccountEnabled =>
      deleteAccountReasonInput.deleteAccountReason.title.isNotEmpty && deleteChallengeText == appLocalizations.delete;

  List<DeleteAccountReason> get reasons => reasonsResult.getSuccess() ?? const [];

  DeleteAccountPresentationModel copyWith({
    DeleteAccountReasonInput? deleteAccountReasonInput,
    CurrentTimeProvider? currentTimeProvider,
    String? deleteChallengeText,
    FutureResult<Either<GetDeleteAccountReasonsFailure, List<DeleteAccountReason>>>? reasonsResult,
    DocumentEntityType? documentEntityType,
  }) {
    return DeleteAccountPresentationModel._(
      deleteAccountReasonInput: deleteAccountReasonInput ?? this.deleteAccountReasonInput,
      currentTimeProvider: currentTimeProvider ?? this.currentTimeProvider,
      deleteChallengeText: deleteChallengeText ?? this.deleteChallengeText,
      reasonsResult: reasonsResult ?? this.reasonsResult,
      documentEntityType: documentEntityType ?? this.documentEntityType,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class DeleteAccountViewModel {
  DeleteAccountReasonInput get deleteAccountReasonInput;

  CurrentTimeProvider get currentTimeProvider;

  bool get deleteAccountEnabled;

  DateTime get deadline;
}
