import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/model/public_profile_action.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_action_use_case.dart';

void main() {
  late GetUserActionUseCase useCase;

  setUp(() {
    useCase = const GetUserActionUseCase();
  });

  test(
    'returns following state if the private user follows the given user',
    () async {
      // GIVEN
      final publicProfile = const PublicProfile.empty().copyWith(iFollow: true);

      // WHEN
      final result = useCase.execute(publicProfile);

      // THEN
      expect(result, PublicProfileAction.following);
    },
  );

  test(
    'returns blocked state if the private user blocked the given user',
    () async {
      // GIVEN
      final publicProfile = const PublicProfile.empty().copyWith(isBlocked: true);

      // WHEN
      final result = useCase.execute(publicProfile);

      // THEN
      expect(result, PublicProfileAction.blocked);
    },
  );

  test(
    'returns follow state if the private user is not blocking or following the given user',
    () async {
      // GIVEN
      const publicProfile = PublicProfile.empty();

      // WHEN
      final result = useCase.execute(publicProfile);

      // THEN
      expect(result, PublicProfileAction.follow);
    },
  );

  test(
    'returns glitterbomb state if both users follow each other',
    () async {
      // GIVEN
      final publicProfile = const PublicProfile.empty().copyWith(iFollow: true, followsMe: true);

      // WHEN
      final result = useCase.execute(publicProfile);

      // THEN
      expect(result, PublicProfileAction.glitterbomb);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserActionUseCase>();
    expect(useCase, isNotNull);
  });
}
