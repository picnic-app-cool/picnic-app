import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/core/domain/use_cases/update_slice_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late UpdateSliceUseCase useCase;

  setUp(() {
    useCase = UpdateSliceUseCase(Mocks.slicesRepository);

    when(
      () => Mocks.slicesRepository.updateSlice(
        sliceId: Stubs.slice.id,
        input: const SliceUpdateInput.empty(),
      ),
    ).thenAnswer((_) => successFuture(Stubs.slice));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        sliceId: Stubs.slice.id,
        input: const SliceUpdateInput.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateSliceUseCase>();
    expect(useCase, isNotNull);
  });
}
