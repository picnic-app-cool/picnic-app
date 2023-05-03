import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/set_language_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SetLanguageUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(languagesCodes: ['en']);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SetLanguageUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = SetLanguageUseCase(Mocks.privateProfileRepository);

    when(
      () => Mocks.privateProfileRepository.setLanguage(
        languagesCodes: ['en'],
      ),
    ).thenAnswer((invocation) => successFuture(unit));
  });
}
