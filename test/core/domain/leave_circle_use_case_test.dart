import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';

import 'package:picnic_app/core/domain/use_cases/leave_circle_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late LeaveCircleUseCase useCase;

  setUp(() {
    useCase = LeaveCircleUseCase(Mocks.circlesRepository, Mocks.userCirclesStore);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      when(
        () => Mocks.circlesRepository.leaveCircle(circleId: any(named: 'circleId')),
      ).thenAnswer((_) => successFuture(unit));

      when(() => Mocks.userCirclesStore.userCircles).thenReturn(Stubs.basicCircles);

      // WHEN
      final result = await useCase.execute(circle: const BasicCircle.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<LeaveCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
