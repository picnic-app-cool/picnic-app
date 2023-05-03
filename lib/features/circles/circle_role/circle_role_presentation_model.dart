import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_role/circle_role_initial_params.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_input.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role_update_input.dart';
import 'package:picnic_app/features/circles/domain/model/create_circle_role_failure.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class CircleRolePresentationModel implements CircleRoleViewModel {
  /// Creates the initial state
  CircleRolePresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    CircleRoleInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        circleRole = initialParams.circleCustomRole,
        onEditRoleCallback = initialParams.onEditLoadRoles,
        formType = initialParams.formType,
        roleInfoChanged = false,
        createCircleRoleFutureResult = const FutureResult.empty();

  /// Used for the copyWith method
  CircleRolePresentationModel._({
    required this.circleId,
    required this.circleRole,
    required this.formType,
    required this.roleInfoChanged,
    required this.createCircleRoleFutureResult,
    required this.onEditRoleCallback,
  });

  final FutureResult<Either<CreateCircleRoleFailure, Id>> createCircleRoleFutureResult;

  final VoidCallback? onEditRoleCallback;

  @override
  final CircleRoleFormType formType;

  @override
  final CircleCustomRole circleRole;

  final Id circleId;

  @override
  final bool roleInfoChanged;

  CircleCustomRoleInput get createCircleCustomRoleInput => circleRole.toCircleCustomRoleInput(circleId: circleId);

  CircleCustomRoleUpdateInput get updateCircleCustomRoleInput =>
      circleRole.toUpdateCircleCustomRoleInput(circleId: circleId);

  @override
  bool get isCircleRoleLoading => createCircleRoleFutureResult.isPending();

  @override
  bool get confirmButtonEnabled => circleRole.name.isNotEmpty && !isCircleRoleLoading;

  CircleRoleViewModel byUpdatingRole(
    CircleCustomRole Function(CircleCustomRole input) updater,
  ) {
    return copyWith(circleRole: updater(circleRole), roleInfoChanged: true);
  }

  CircleRolePresentationModel copyWith({
    Id? circleId,
    CircleCustomRole? circleRole,
    FutureResult<Either<CreateCircleRoleFailure, Id>>? createCircleRoleFutureResult,
    CircleRoleFormType? formType,
    VoidCallback? onEditRoleCallback,
    bool? roleInfoChanged,
  }) {
    return CircleRolePresentationModel._(
      circleId: circleId ?? this.circleId,
      circleRole: circleRole ?? this.circleRole,
      onEditRoleCallback: onEditRoleCallback ?? this.onEditRoleCallback,
      formType: formType ?? this.formType,
      roleInfoChanged: roleInfoChanged ?? this.roleInfoChanged,
      createCircleRoleFutureResult: createCircleRoleFutureResult ?? this.createCircleRoleFutureResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class CircleRoleViewModel {
  CircleCustomRole get circleRole;

  bool get isCircleRoleLoading;

  bool get roleInfoChanged;

  bool get confirmButtonEnabled;

  CircleRoleFormType get formType;
}

enum CircleRoleFormType {
  createCircleRole,
  editCircleRole,
}
