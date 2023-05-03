import 'package:picnic_app/core/domain/model/user.dart';

class AddMembersListInitialParams {
  AddMembersListInitialParams({
    required this.onAddUser,
  });

  Future<bool> Function(User) onAddUser;
}
