import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/log_out_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/onboarding/onboarding_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_navigator.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_delete_account_reasons_use_case.dart';
import 'package:picnic_app/features/settings/domain/use_cases/request_delete_account_use_case.dart';

class DeleteAccountPresenter extends Cubit<DeleteAccountViewModel> {
  DeleteAccountPresenter(
    DeleteAccountPresentationModel model,
    this.navigator,
    this._requestDeleteAccountUseCase,
    this._logOutUseCase,
    this._getDeleteAccountReasonsUseCase,
  ) : super(model);

  final DeleteAccountNavigator navigator;
  final RequestDeleteAccountUseCase _requestDeleteAccountUseCase;
  final LogOutUseCase _logOutUseCase;
  final GetDeleteAccountReasonsUseCase _getDeleteAccountReasonsUseCase;

  // ignore: unused_element
  DeleteAccountPresentationModel get _model => state as DeleteAccountPresentationModel;

  void onInit() {
    _getDeleteAccountReasons();
  }

  void onTabDeleteAccount() => _requestDeleteAccountUseCase
      .execute(deleteAccountReasonInput: _model.deleteAccountReasonInput)
      .doOn(
        success: (success) => _logOutUseCase.execute().doOn(
              success: (success) => navigator.replaceAllToOnboarding(const OnboardingInitialParams()),
            ),
      )
      .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));

  Future<void> onTapDisplayReasons() async {
    final selectedReason = await navigator.openDeleteAccountReasons(
      DeleteAccountReasonsInitialParams(
        reasons: _model.reasons,
      ),
    );

    if (selectedReason != null) {
      tryEmit(
        _model.copyWith(
          deleteAccountReasonInput: _model.deleteAccountReasonInput.copyWith(
            deleteAccountReason: selectedReason,
          ),
        ),
      );
    }
  }

  void onChangedDeleteChallenge(String value) => tryEmit(_model.copyWith(deleteChallengeText: value));

  void onChangedReason(DeleteAccountReason deleteAccountReason) => tryEmit(
        _model.copyWith(
          deleteAccountReasonInput: _model.deleteAccountReasonInput.copyWith(
            deleteAccountReason: deleteAccountReason,
          ),
        ),
      );

  void onChangedDescription(String description) => tryEmit(
        _model.copyWith(
          deleteAccountReasonInput: _model.deleteAccountReasonInput.copyWith(
            description: description,
          ),
        ),
      );

  void _getDeleteAccountReasons() => _getDeleteAccountReasonsUseCase
      .execute(
        documentEntityType: _model.documentEntityType,
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(reasonsResult: result)),
      );
}
