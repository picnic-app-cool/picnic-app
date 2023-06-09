import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/use_cases/enable_pod_in_circle_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late EnablePodInCircleUseCase useCase;

  setUp(() {
    useCase = EnablePodInCircleUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.podsRepository.enablePodInCircle(podId: any(named: 'podId'), circleId: any(named: 'circleId')))
          .thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(podId: const Id('podId'), circleId: const Id('circleId'));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<EnablePodInCircleUseCase>();
    expect(useCase, isNotNull);
  });
}
