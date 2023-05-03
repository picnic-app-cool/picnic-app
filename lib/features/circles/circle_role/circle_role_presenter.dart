import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_initial_params.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_navigator.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_presentation_model.dart';
import 'package:picnic_app/features/circles/domain/use_cases/create_circle_role_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/update_circle_role_use_case.dart';

class CircleRolePresenter extends Cubit<CircleRoleViewModel> {
  CircleRolePresenter(
    super.model,
    this.navigator,
    this._createCircleRoleUseCase,
    this._updateCircleRoleUseCase,
  );

  final CircleRoleNavigator navigator;
  final CreateCircleRoleUseCase _createCircleRoleUseCase;
  final UpdateCircleRoleUseCase _updateCircleRoleUseCase;

  // ignore: unused_element
  CircleRolePresentationModel get _model => state as CircleRolePresentationModel;

  Future<void> onTapEditEmoji() async {
    final emoji = await navigator.openAvatarSelection(
      AvatarSelectionInitialParams(emoji: _model.circleRole.emoji),
    );
    if (emoji != null) {
      tryEmit(_model.byUpdatingRole((role) => role.copyWith(emoji: emoji)));
    }
  }

  Future<void> onTapConfirm() async {
    switch (_model.formType) {
      case CircleRoleFormType.createCircleRole:
        onTapCreateRole();
        break;
      case CircleRoleFormType.editCircleRole:
        onTapEditRole();
        break;
    }
  }

  void onTapCreateRole() => _createCircleRoleUseCase
      .execute(circleCustomRoleInput: _model.createCircleCustomRoleInput)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(createCircleRoleFutureResult: result)),
      )
      .doOn(
        fail: (fail) => navigator.showError(fail.displayableFailure()),
        success: (_) {
          _model.onEditRoleCallback?.call();

          navigator.close();
        },
      );

  void onTapEditRole() =>
      _updateCircleRoleUseCase.execute(circleCustomRoleUpdateInput: _model.updateCircleCustomRoleInput).doOn(
            fail: (fail) => navigator.showError(fail.displayableFailure()),
            success: (_) {
              _model.onEditRoleCallback?.call();
              navigator.close();
            },
          );

  void onTapBack() {
    if (_model.roleInfoChanged) {
      onTapShowConfirm();
    } else {
      navigator.close();
    }
  }

  void onTapShowConfirm() => navigator.showDiscardCircleInfoChangesRoute(
        onTapSave: state.confirmButtonEnabled
            ? () {
                navigator.close();
                onTapCreateRole();
              }
            : null,
      );

  void onNameUpdated(String newValue) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(name: newValue),
        ),
      );

  void onTapColorPicker() => navigator.showColorBottomSheet(
        selectedTextColor: _model.circleRole.color,
        onTextColorSelected: (color) => tryEmit(
          _model.byUpdatingRole(
            (role) => role.copyWith(color: color),
          ),
        ),
      );

  void onPostContentPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canPostContent: newValue),
        ),
      );

  void onSendMessagesPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canSendMessages: newValue),
        ),
      );

  void onManageMessagesPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canManageMessages: newValue),
        ),
      );

  void onEmbedLinksPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canEmbedLinks: newValue),
        ),
      );

  void onAttachFilesPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canAttachFiles: newValue),
        ),
      );

  void onManageUsersPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canManageUsers: newValue),
        ),
      );

  void onManageRolesPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canManageRoles: newValue),
        ),
      );

  void onManageCirclePermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canManageCircle: newValue),
        ),
      );

  void onManageReportsPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canManageReports: newValue),
        ),
      );

  void onManageCommentsPermissionChanged({required bool newValue}) => tryEmit(
        _model.byUpdatingRole(
          (role) => role.copyWith(canManageComments: newValue),
        ),
      );
}
