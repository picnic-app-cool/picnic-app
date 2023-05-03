import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/use_cases/assign_user_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_user_roles_in_circle_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/un_assign_user_role_use_case.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_navigator.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class UserRolesPresenter extends Cubit<UserRolesViewModel> {
  UserRolesPresenter(
    super.model,
    this.navigator,
    this.assignUserRoleUseCase,
    this.unAssignUserRoleUseCase,
    this.getUserRolesInCircleUseCase,
  );

  final UserRolesNavigator navigator;
  final AssignUserRoleUseCase assignUserRoleUseCase;
  final UnAssignUserRoleUseCase unAssignUserRoleUseCase;
  final GetUserRolesInCircleUseCase getUserRolesInCircleUseCase;

  // ignore: unused_element
  UserRolesPresentationModel get _model => state as UserRolesPresentationModel;

  Future<void> onInit() async {
    await getUserRoles();
  }

  //TODO(GS-6037): get user roles : https://picnic-app.atlassian.net/browse/GS-6037
  void search() => notImplemented();

  Future<void> getUserRoles() {
    return getUserRolesInCircleUseCase
        .execute(
          circleId: _model.circleId,
          userId: _model.publicProfile.id,
        )
        .doOn(
          success: (userRoles) {
            final allRolesList = [...userRoles.unassigned, ...userRoles.roles];
            final allRoles = PaginatedList(
              pageInfo: const PageInfo.singlePage(),
              items: allRolesList,
            );
            _model.assignedRoles.addAll(userRoles.roles);
            tryEmit(
              _model.copyWith(
                allRoles: allRoles,
              ),
            );
          },
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
        );
  }

  void onTapClose() => navigator.close();

  void onTapUnAssignRole(CircleCustomRole role) {
    if (role.meta.assignable) {
      unAssignUserRoleUseCase
          .execute(
            circleId: _model.circleId,
            userId: _model.publicProfile.id,
            roleId: role.id,
          )
          .doOn(
            success: (success) => tryEmit(
              _model.copyWith(
                assignedRoles: _model.assignedRoles..remove(role),
              ),
            ),
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
    } else {
      navigator.showDisabledBottomSheet(
        title: appLocalizations.actionRestrictedTitle,
        description: appLocalizations.roleCanNotBeUnassigned,
        onTapClose: onTapClose,
      );
    }
  }

  void onTapAssignRole(CircleCustomRole role) {
    if (role.meta.assignable) {
      assignUserRoleUseCase
          .execute(
            circleId: _model.circleId,
            userId: _model.publicProfile.id,
            roleId: role.id,
          )
          .doOn(
            success: (success) {
              tryEmit(
                _model.copyWith(
                  assignedRoles: _model.assignedRoles..add(role),
                ),
              );
            },
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
    } else {
      navigator.showDisabledBottomSheet(
        title: appLocalizations.actionRestrictedTitle,
        description: appLocalizations.roleCanNotBeAssigned,
        onTapClose: onTapClose,
      );
    }
  }

  void onTapRole(CircleCustomRole role) {
    _model.assignedRoles.contains(role) ? onTapUnAssignRole(role) : onTapAssignRole(role);
  }
}
