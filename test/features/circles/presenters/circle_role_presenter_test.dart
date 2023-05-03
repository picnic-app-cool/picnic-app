import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presenter.dart';

import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleRolePresentationModel model;
  late CircleRolePresenter presenter;
  late MockCircleRoleNavigator navigator;

  test('changing role name should set roleInfoChanged as true', () {
    expect(presenter.state.roleInfoChanged, isFalse);
    presenter.onNameUpdated('Name');
    expect(presenter.state.roleInfoChanged, isTrue);
  });

  test('changing role name should enable action button', () {
    presenter.onNameUpdated('Role');
    expect(presenter.state.confirmButtonEnabled, isTrue);
  });

  test('changing role name with an empty string should disable action button', () {
    presenter.onNameUpdated('');
    expect(presenter.state.confirmButtonEnabled, isFalse);
  });

  setUp(() {
    model = CircleRolePresentationModel.initial(
      CircleRoleInitialParams(
        circleId: const Circle.empty().id,
        formType: CircleRoleFormType.createCircleRole,
      ),
    );
    navigator = MockCircleRoleNavigator();
    presenter = CircleRolePresenter(
      model,
      navigator,
      CirclesMocks.createCircleRoleUseCase,
      CirclesMocks.updateCircleRoleUseCase,
    );
  });
}
