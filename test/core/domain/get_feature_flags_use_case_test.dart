import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_feature_flags_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetFeatureFlagsUseCase useCase;

  setUp(() {
    useCase = GetFeatureFlagsUseCase(
      Mocks.featureFlagsRepository,
      Mocks.featureFlagsStore,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.featureFlagsRepository.getFeatureFlags())
          .thenAnswer((invocation) => successFuture(Stubs.featureFlags));
      when(() => Mocks.featureFlagsStore.featureFlags).thenAnswer((_) => Stubs.featureFlags);

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
      verify(
        () => Mocks.featureFlagsStore.featureFlags = Stubs.featureFlags,
      );
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetFeatureFlagsUseCase>();
    expect(useCase, isNotNull);
  });
}
