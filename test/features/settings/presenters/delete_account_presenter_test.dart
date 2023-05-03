import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account/delete_account_presenter.dart';
import 'package:picnic_app/features/settings/domain/model/delete_account_reason_input.dart';

import '../../../mocks/mocks.dart';
import '../mocks/settings_mock_definitions.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late DeleteAccountPresentationModel model;
  late DeleteAccountPresenter presenter;
  late MockDeleteAccountNavigator navigator;

  test(
    "on tap display reason opens report reason view and returns delete account reason",
    () async {
      //GIVEN
      const deleteAccountReasonInput = DeleteAccountReasonInput.empty();
      when(() => navigator.openDeleteAccountReasons(any())).thenAnswer(
        (invocation) => Future.value(deleteAccountReasonInput.deleteAccountReason),
      );

      // WHEN
      await presenter.onTapDisplayReasons();

      // THEN
      verify(() => navigator.openDeleteAccountReasons(any()));
      expect(presenter.state.deleteAccountReasonInput, deleteAccountReasonInput);
    },
  );

  setUp(() {
    model = DeleteAccountPresentationModel.initial(
      const DeleteAccountInitialParams(),
      Mocks.currentTimeProvider,
    );
    navigator = MockDeleteAccountNavigator();
    presenter = DeleteAccountPresenter(
      model,
      navigator,
      SettingsMocks.requestDeleteAccountUseCase,
      Mocks.logOutUseCase,
      SettingsMocks.getDeleteAccountReasonsUseCase,
    );
  });
}
