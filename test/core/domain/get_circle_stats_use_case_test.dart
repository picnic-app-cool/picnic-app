import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_stats_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetCircleStatsUseCase useCase;

  setUp(() {
    useCase = GetCircleStatsUseCase(
      Mocks.circlesRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.circlesRepository.getCircleStats(circleId: Stubs.circle.id))
          .thenSuccess((_) => Stubs.circleStats);

      // WHEN
      final result = await useCase.execute(circleId: Stubs.circle.id);

      // THEN
      expect(result.isSuccess, true);
      expect(result.getSuccess(), Stubs.circleStats);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleStatsUseCase>();
    expect(useCase, isNotNull);
  });
}
