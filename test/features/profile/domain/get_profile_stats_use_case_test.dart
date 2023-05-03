import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/profile_stats.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_profile_stats_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetProfileStatsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(userId: Stubs.id);

      // THEN
      verify(
        () => Mocks.usersRepository.getProfileStats(userId: Stubs.id),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetProfileStatsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    when(
      () => Mocks.usersRepository.getProfileStats(
        userId: Stubs.id,
      ),
    ).thenAnswer((invocation) => successFuture(const ProfileStats.empty()));

    useCase = GetProfileStatsUseCase(Mocks.usersRepository);
  });
}
