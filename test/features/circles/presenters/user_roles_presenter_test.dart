import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presentation_model.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presenter.dart';

import '../../../mocks/stubs.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late UserRolesPresentationModel model;
  late UserRolesPresenter presenter;
  late MockUserRolesNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = UserRolesPresentationModel.initial(
      UserRolesInitialParams(
        user: Stubs.publicProfile,
        circleId: Stubs.circle.id,
      ),
    );
    navigator = MockUserRolesNavigator();
    presenter = UserRolesPresenter(
      model,
      navigator,
      CirclesMocks.assignUserRoleUseCase,
      CirclesMocks.unAssignUserRoleUseCase,
      CirclesMocks.getUserRolesInCircleUseCase,
    );
  });
}
