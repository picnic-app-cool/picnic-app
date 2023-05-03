import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/use_cases/follow_unfollow_user_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late FollowUnfollowUserUseCase useCase;
  final user = const User.empty().copyWith(id: const Id("userId"));

  test(
    'use case executes normally',
    () async {
      // GIVEN

      when(() => Mocks.usersRepository.followUnFollowUser(userId: user.id, follow: false))
          .thenAnswer((invocation) => successFuture(unit));
      // WHEN
      final result = await useCase.execute(userId: user.id, follow: false);
      verify(() => Mocks.usersRepository.followUnFollowUser(userId: user.id, follow: false));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<FollowUnfollowUserUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = FollowUnfollowUserUseCase(Mocks.usersRepository);

    when(() {
      return Mocks.usersRepository.followUnFollowUser(userId: user.id, follow: false);
    }).thenAnswer((_) => successFuture(unit));

    when(() => Mocks.followUserUseCase.execute(userId: user.id, follow: false)).thenAnswer((_) {
      return successFuture(unit);
    });
  });
}
