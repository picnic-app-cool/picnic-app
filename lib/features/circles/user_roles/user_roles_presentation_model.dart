import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/features/circles/user_roles/user_roles_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class UserRolesPresentationModel implements UserRolesViewModel {
  /// Creates the initial state
  UserRolesPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    UserRolesInitialParams initialParams,
  )   : publicProfile = initialParams.user,
        circleId = initialParams.circleId,
        allRoles = const PaginatedList.empty(),
        assignedRoles = [];

  /// Used for the copyWith method
  UserRolesPresentationModel._({
    required this.publicProfile,
    required this.circleId,
    required this.allRoles,
    required this.assignedRoles,
  });

  @override
  final PublicProfile publicProfile;

  @override
  final Id circleId;

  @override
  final PaginatedList<CircleCustomRole> allRoles;

  @override
  final List<CircleCustomRole> assignedRoles;

  @override
  bool get isSearchEnabled => false;

  UserRolesPresentationModel copyWith({
    PublicProfile? publicProfile,
    Id? circleId,
    PaginatedList<CircleCustomRole>? allRoles,
    List<CircleCustomRole>? assignedRoles,
  }) {
    return UserRolesPresentationModel._(
      publicProfile: publicProfile ?? this.publicProfile,
      circleId: circleId ?? this.circleId,
      allRoles: allRoles ?? this.allRoles,
      assignedRoles: assignedRoles ?? this.assignedRoles,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class UserRolesViewModel {
  PaginatedList<CircleCustomRole> get allRoles;

  List<CircleCustomRole> get assignedRoles;

  PublicProfile get publicProfile;

  Id get circleId;

  bool get isSearchEnabled;
}
