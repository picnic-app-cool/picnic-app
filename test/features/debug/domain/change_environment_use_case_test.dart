import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/environment_config/environment_config_slug.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/debug/domain/use_cases/change_environment_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/debug_mocks.dart';

void main() {
  late ChangeEnvironmentUseCase useCase;

  setUp(() {
    useCase = ChangeEnvironmentUseCase(
      Mocks.logOutUseCase,
      DebugMocks.restartAppUseCase,
      Mocks.environmentConfigProvider,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.logOutUseCase.execute()).thenSuccess((_) => unit);
      when(() => DebugMocks.restartAppUseCase.execute()).thenSuccess((_) => unit);
      when(() => Mocks.environmentConfigProvider.changeEnvironment(EnvironmentConfigSlug.production))
          .thenSuccess((_) => unit);
      // WHEN
      final result = await useCase.execute(slug: EnvironmentConfigSlug.production);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ChangeEnvironmentUseCase>();
    expect(useCase, isNotNull);
  });
}
