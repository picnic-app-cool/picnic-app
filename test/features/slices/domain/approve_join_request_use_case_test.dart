import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/domain/model/accept_request_input.dart';
import 'package:picnic_app/features/slices/domain/use_cases/approve_join_request_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late ApproveJoinRequestUseCase useCase;

  setUp(() {
    useCase = ApproveJoinRequestUseCase(Mocks.slicesRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.slicesRepository.approveJoinRequest(requestInput: const AcceptRequestInput.empty()))
          .thenAnswer((_) => successFuture(Stubs.slice));

      // WHEN
      final result = await useCase.execute(acceptRequestInput: const AcceptRequestInput.empty());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ApproveJoinRequestUseCase>();
    expect(useCase, isNotNull);
  });
}
