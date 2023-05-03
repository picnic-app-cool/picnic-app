import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/use_cases/delete_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_roles_use_case.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_navigator.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_presentation_model.dart';

class RolesListPresenter extends Cubit<RolesListViewModel> {
  RolesListPresenter(
    super.model,
    this.navigator,
    this._getCircleRolesUseCase,
    this._deleteRoleUseCase,
  );

  final RolesListNavigator navigator;
  final GetCircleRolesUseCase _getCircleRolesUseCase;
  final DeleteRoleUseCase _deleteRoleUseCase;

  // ignore: unused_element
  RolesListPresentationModel get _model => state as RolesListPresentationModel;

  void onTapAddRole() => navigator.openCircleRole(
        CircleRoleInitialParams(
          circleId: _model.circleId,
          formType: CircleRoleFormType.createCircleRole,
          onEditLoadRoles: () => loadMoreRoles(fromScratch: true),
        ),
      );

  //TODO: (GS-5519): https://picnic-app.atlassian.net/browse/GS-5519
  void onTapEditRole(CircleCustomRole role) => navigator.openCircleRole(
        CircleRoleInitialParams(
          circleId: _model.circleId,
          formType: CircleRoleFormType.editCircleRole,
          circleCustomRole: role,
          onEditLoadRoles: () => loadMoreRoles(fromScratch: true),
        ),
      );

  void onTapDeleteRole(CircleCustomRole circleCustomRole) =>
      _deleteRoleUseCase.execute(roleId: circleCustomRole.id, circleId: _model.circleId).doOn(
            success: (success) => tryEmit(_model.byRemovingRole(circleCustomRole)),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );

  Future<void> loadMoreRoles({bool fromScratch = false}) async {
    await _getCircleRolesUseCase
        .execute(
          circleId: _model.circleId,
        )
        .doOn(
          success: (roles) {
            tryEmit(_model.copyWith(roles: roles));
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}
