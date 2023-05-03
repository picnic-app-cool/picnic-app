import 'package:bloc/bloc.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_navigator.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presentation_model.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason.dart';

class DeleteAccountReasonsPresenter extends Cubit<DeleteAccountReasonsViewModel> {
  DeleteAccountReasonsPresenter(
    super.model,
    this.navigator,
  );

  final DeleteAccountReasonsNavigator navigator;

  void onTapSelectReason(DeleteAccountReason reason) {
    navigator.closeWithResult(reason);
  }
}
