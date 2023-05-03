import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/domain/use_cases/change_feature_flags_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late ChangeFeatureFlagsUseCase useCase;

  setUp(() {
    useCase = ChangeFeatureFlagsUseCase(
      Mocks.environmentConfigProvider,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.environmentConfigProvider.changeFeatureFlags(Stubs.featureFlags))
          .thenAnswer((_) => successFuture(unit));

      // WHEN
      final result = await useCase.execute(Stubs.featureFlags);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ChangeFeatureFlagsUseCase>();
    expect(useCase, isNotNull);
  });
}
