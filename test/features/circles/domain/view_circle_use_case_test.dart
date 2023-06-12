import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/view_circle_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late ViewCircleUseCase useCase;

  setUp(() {
    useCase = ViewCircleUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.viewCircle(
        circleId: Stubs.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(unit),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.id,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ViewCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
