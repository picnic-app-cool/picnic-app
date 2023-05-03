import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_should_show_circles_selection_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetShouldShowCirclesSelectionUseCase useCase;

  setUp(() {
    useCase = GetShouldShowCirclesSelectionUseCase(Mocks.userPreferencesRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.userPreferencesRepository.shouldShowCirclesSelection()).thenSuccess((_) => true);

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetShouldShowCirclesSelectionUseCase>();
    expect(useCase, isNotNull);
  });
}
