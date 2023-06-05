import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_by_name_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetCircleByNameUseCase useCase;

  setUp(() {
    useCase = GetCircleByNameUseCase(Mocks.circlesRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.circlesRepository.getCircleByName(name: any(named: 'name')),
      ).thenAnswer((_) => successFuture(Stubs.circle));

      // WHEN
      final result = await useCase.execute(name: '');

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleByNameUseCase>();
    expect(useCase, isNotNull);
  });
}
