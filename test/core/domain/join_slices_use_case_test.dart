import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/join_slice_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late JoinSliceUseCase useCase;

  setUp(() {
    useCase = JoinSliceUseCase(Mocks.slicesRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.slicesRepository.joinSlice(sliceId: any(named: 'sliceId')),
      ).thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(sliceId: const Id.none());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<JoinSliceUseCase>();
    expect(useCase, isNotNull);
  });
}
