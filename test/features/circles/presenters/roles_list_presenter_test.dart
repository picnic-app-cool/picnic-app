import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/circles/domain/model/delete_role_failure.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presentation_model.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presenter.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late RolesListPresentationModel model;
  late RolesListPresenter presenter;
  late MockRolesListNavigator navigator;

  test(
    'tapping on add should open CircleRolePage',
    () {
      //GIVEN
      when(() => navigator.openCircleRole(any())).thenAnswer((_) {
        return Future.value();
      });
      // WHEN
      presenter.onTapAddRole();

      // THEN
      verify(
        () => navigator.openCircleRole(any()),
      );
    },
  );

  test('tapping delete role should successfuly remove the role', () {
    // GIVEN
    when(
      () => CirclesMocks.deleteRoleUseCase.execute(
        roleId: any(named: 'roleId'),
        circleId: any(named: 'circleId'),
      ),
    ).thenAnswer((_) => successFuture(unit));

    // WHEN
    presenter.onTapDeleteRole(Stubs.circleCustomRole);

    // THEN
    verify(
      () => CirclesMocks.deleteRoleUseCase.execute(
        roleId: any(named: 'roleId'),
        circleId: any(named: 'circleId'),
      ),
    ).called(1);
    verifyNever(() => navigator.showError(any()));
  });

  test('tapping delete role should return failure', () async {
    fakeAsync(
      (async) {
        // GIVEN
        when(
          () => CirclesMocks.deleteRoleUseCase.execute(
            roleId: any(named: 'roleId'),
            circleId: any(named: 'circleId'),
          ),
        ).thenAnswer((_) => failFuture(const DeleteRoleFailure.unknown()));
        when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

        // WHEN
        presenter.onTapDeleteRole(Stubs.circleCustomRole);
        async.flushMicrotasks();

        // THEN
        verify(
          () => CirclesMocks.deleteRoleUseCase.execute(
            roleId: any(named: 'roleId'),
            circleId: any(named: 'circleId'),
          ),
        ).called(1);
        verify(() => navigator.showError(any())).called(1);
      },
    );
  });

  setUp(() {
    model = RolesListPresentationModel.initial(
      RolesListInitialParams(circleId: Stubs.circle.id),
    );
    navigator = MockRolesListNavigator();
    presenter = RolesListPresenter(
      model,
      navigator,
      CirclesMocks.getCircleRoleUseCase,
      CirclesMocks.deleteRoleUseCase,
    );
  });
}
