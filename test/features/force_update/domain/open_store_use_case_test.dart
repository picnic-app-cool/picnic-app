import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/force_update/domain/use_case/open_store_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../../package_info/mocks/store_mocks.dart';

void main() {
  late OpenStoreUseCase useCase;

  setUp(() {
    useCase = OpenStoreUseCase(StoreMocks.appStoreRepository);
  });

  test(
    'use case executes normally',
    () async {
      const packageName = 'packageName';
      // GIVEN
      when(() => StoreMocks.appStoreRepository.openStore(packageName)).thenAnswer((invocation) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(packageName);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<OpenStoreUseCase>();
    expect(useCase, isNotNull);
  });
}
