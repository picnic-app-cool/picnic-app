import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/domain/model/list_groups_input.dart';
import 'package:picnic_app/features/onboarding/domain/use_cases/get_groups_with_circles_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetGroupsWithCirclesUseCase useCase;

  setUp(() {
    useCase = GetGroupsWithCirclesUseCase(Mocks.circlesRepository);
    registerFallbackValue(ListGroupsInput);

    when(
      () => Mocks.circlesRepository.getGroupsOfCircles(listGroupsInput: any(named: 'listGroupsInput')),
    ).thenAnswer((_) {
      return successFuture([
        Stubs.groupWithCircles,
        Stubs.groupWithCircles2,
      ]);
    });
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(listGroupsInput: Stubs.listGroupsInput);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetGroupsWithCirclesUseCase>();
    expect(useCase, isNotNull);
  });
}
