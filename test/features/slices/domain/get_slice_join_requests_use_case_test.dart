import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/domain/use_cases/get_slice_join_requests_use_case.dart';

import '../../../mocks/stubs.dart';

void main() {
  late GetSliceJoinRequestsUseCase useCase;

  setUp(() {
    useCase = GetSliceJoinRequestsUseCase();
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(sliceId: Stubs.slice.id);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSliceJoinRequestsUseCase>();
    expect(useCase, isNotNull);
  });
}
