import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_input.dart';
import 'package:picnic_app/core/domain/model/update_circle_input.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_initial_params.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presentation_model.dart';
import 'package:picnic_app/features/circles/edit_circle/edit_circle_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late EditCirclePresentationModel model;
  late EditCirclePresenter presenter;
  late MockEditCircleNavigator navigator;

  final formInputWithExpectedValidation = <UpdateCircleInput, bool>{
    // saveEnabled is enabled
    UpdateCircleInput(
      circleId: Stubs.id,
      circleUpdate: const CircleInput.empty().copyWith(
        description: "description",
        name: "name",
        emoji: "😬",
      ),
    ): true,
    // if name is empty then saveEnabled is not enabled
    UpdateCircleInput(
      circleId: Stubs.id,
      circleUpdate: const CircleInput.empty().copyWith(
        description: "hello",
        name: "",
        emoji: "😬",
      ),
    ): false,
    // if emoji is empty then saveEnabled is not enabled
    UpdateCircleInput(
      circleId: Stubs.id,
      circleUpdate: const CircleInput.empty().copyWith(
        description: "hello",
        name: "name",
        emoji: "",
      ),
    ): false,
    // if description is empty then saveEnabled is not enabled
    UpdateCircleInput(
      circleId: Stubs.id,
      circleUpdate: const CircleInput.empty().copyWith(
        description: "",
        name: "name",
        emoji: "😬",
      ),
    ): false,
    // if description and name is empty then saveEnabled is not enabled
    UpdateCircleInput(
      circleId: Stubs.id,
      circleUpdate: const CircleInput.empty().copyWith(
        description: "",
        name: "",
        emoji: "😬",
      ),
    ): false,
  };

  formInputWithExpectedValidation.forEach(
    (circleInput, expectedValid) {
      test(
        'expect that based input form the expected valid state is present',
        () {
          presenter.emit(
            model.copyWith(updateCircleInput: circleInput),
          );
          expect(presenter.state.saveEnabled, expectedValid);
        },
      );
    },
  );

  setUp(() {
    when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);
    model = EditCirclePresentationModel.initial(
      EditCircleInitialParams(circle: Stubs.circle),
      Mocks.featureFlagsStore,
    );

    navigator = MockEditCircleNavigator();
    presenter = EditCirclePresenter(
      model,
      navigator,
      Mocks.updateCircleUseCase,
    );
  });
}
