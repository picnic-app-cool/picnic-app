import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCircleDetailsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: Stubs.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleDetailsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetCircleDetailsUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.getCircleDetails(
        circleId: Stubs.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.circle),
    );
  });
}
