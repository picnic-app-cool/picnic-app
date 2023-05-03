import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_roles_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCircleRolesUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.circle.id,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleRolesUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetCircleRolesUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.getCircleRoles(
        circleId: Stubs.circle.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(PaginatedList.singlePage([Stubs.circleCustomRole])),
    );
  });
}
