import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/core/domain/use_cases/get_user_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetUserUseCase useCase;
  final user = const PublicProfile.empty().copyWith(user: const User.empty().copyWith(id: const Id("userId")));

  setUp(() {
    useCase = GetUserUseCase(Mocks.usersRepository);
    when(() => Mocks.usersRepository.getUser(userId: any(named: "userId"))).thenAnswer((_) => successFuture(user));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        userId: const Id('userId'),
      );

      // THEN
      expect(result.isSuccess, true);
      expect(result.getSuccess(), user);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserUseCase>();
    expect(useCase, isNotNull);
  });
}
