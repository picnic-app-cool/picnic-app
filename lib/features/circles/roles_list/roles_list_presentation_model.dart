import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/roles_list/roles_list_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class RolesListPresentationModel implements RolesListViewModel {
  /// Creates the initial state
  RolesListPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    RolesListInitialParams initialParams,
  )   : circleId = initialParams.circleId,
        hasPermissionToManageRoles = initialParams.hasPermissionToManageRoles,
        roles = const PaginatedList.empty();

  /// Used for the copyWith method
  RolesListPresentationModel._({
    required this.circleId,
    required this.roles,
    required this.hasPermissionToManageRoles,
  });

  final Id circleId;
  @override
  final PaginatedList<CircleCustomRole> roles;

  @override
  final bool hasPermissionToManageRoles;

  RolesListPresentationModel byRemovingRole(CircleCustomRole item) => copyWith(
        roles: roles.byRemoving(element: item),
      );

  RolesListPresentationModel copyWith({
    Id? circleId,
    PaginatedList<CircleCustomRole>? roles,
    bool? hasPermissionToManageRoles,
  }) {
    return RolesListPresentationModel._(
      circleId: circleId ?? this.circleId,
      roles: roles ?? this.roles,
      hasPermissionToManageRoles: hasPermissionToManageRoles ?? this.hasPermissionToManageRoles,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class RolesListViewModel {
  PaginatedList<CircleCustomRole> get roles;

  bool get hasPermissionToManageRoles;
}
