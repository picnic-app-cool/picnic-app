import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_initial_params.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presentation_model.dart';
import 'package:picnic_app/features/circles/remove_reason/remove_reason_presenter.dart';

import '../mocks/circles_mock_definitions.dart';

void main() {
  late RemoveReasonPresentationModel model;
  late RemoveReasonPresenter presenter;
  late MockRemoveReasonNavigator navigator;

  test(
    'tapping on close should call the navigator to close the widget ',
    () {
      //WHEN
      presenter.navigator.close();

      //THEN
      verify(() => navigator.close());
    },
  );

  test(
    'removing the text should update the state to reflect the button is now disabled',
    () {
      //WHEN
      presenter.onTextChanged('');

      //THEN
      expect(presenter.state.isButtonEnabled, isFalse);
    },
  );

  test(
    'updating the text with a reason should update the state to reflect the button is now enabled',
    () {
      //WHEN
      presenter.onTextChanged('reason');

      //THEN
      expect(presenter.state.isButtonEnabled, isTrue);
    },
  );

  test(
    'filling in a reason and taping continue should call the navigator to close the widget returning the reason as well',
    () {
      //WHEN
      presenter.onTextChanged('reason');
      presenter.onTapContinue();

      //THEN
      verify(() => navigator.closeWithResult('reason'));
    },
  );

  setUp(() {
    model = RemoveReasonPresentationModel.initial(const RemoveReasonInitialParams());
    navigator = MockRemoveReasonNavigator();
    presenter = RemoveReasonPresenter(
      model,
      navigator,
    );
  });
}
