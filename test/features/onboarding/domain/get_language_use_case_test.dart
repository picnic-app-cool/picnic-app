import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_languages_list_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../main/mocks/main_mocks.dart';

void main() {
  late GetLanguagesListUseCase useCase;

  setUp(() {
    useCase = GetLanguagesListUseCase(MainMocks.languageRepository);
    when(
      () => MainMocks.languageRepository.getLanguages(),
    ).thenAnswer((_) {
      return successFuture(Stubs.languages);
    });
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetLanguagesListUseCase>();
    expect(useCase, isNotNull);
  });
}
