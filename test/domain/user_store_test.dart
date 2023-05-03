import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/stores/user_store.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

void main() {
  test("should have singleton instance of user store", () {
    final user = const PrivateProfile.empty().copyWith(user: const User.empty().copyWith(id: const Id("userId")));
    getIt<UserStore>().privateProfile = user;
    expect(getIt<UserStore>().privateProfile, user);
  });
}
