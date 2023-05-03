import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/update_current_user_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late UpdateCurrentUserUseCase useCase;

  setUp(() {
    useCase = UpdateCurrentUserUseCase(Mocks.localStoreRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.localStoreRepository.saveCurrentUser(user: Stubs.privateProfile),
      ).thenAnswer((invocation) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(Stubs.privateProfile);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateCurrentUserUseCase>();
    expect(useCase, isNotNull);
  });
}
