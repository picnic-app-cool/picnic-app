import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_initial_params.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presentation_model.dart';
import 'package:picnic_app/features/settings/delete_account_reasons/delete_account_reasons_presenter.dart';

import '../mocks/settings_mock_definitions.dart';

void main() {
  late DeleteAccountReasonsPresentationModel model;
  late DeleteAccountReasonsPresenter presenter;
  late MockDeleteAccountReasonsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = DeleteAccountReasonsPresentationModel.initial(const DeleteAccountReasonsInitialParams(reasons: []));
    navigator = MockDeleteAccountReasonsNavigator();
    presenter = DeleteAccountReasonsPresenter(
      model,
      navigator,
    );
  });
}
