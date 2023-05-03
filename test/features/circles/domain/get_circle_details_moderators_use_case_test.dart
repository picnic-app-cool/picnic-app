import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/circle_role.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_by_role_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCircleMembersByRoleUseCase useCase;

  setUp(() {
    useCase = GetCircleMembersByRoleUseCase(Mocks.circlesRepository);

    when(
      () => Mocks.circlesRepository.getCircleMembersByRole(
        searchQuery: '',
        circleId: Stubs.id,
        cursor: const Cursor.firstPage(),
        roles: [
          CircleRole.director,
          CircleRole.moderator,
        ],
      ),
    ).thenAnswer(
      (invocation) => successFuture(const PaginatedList.empty()),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.id,
        cursor: const Cursor.firstPage(),
        roles: [
          CircleRole.director,
          CircleRole.moderator,
        ],
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleMembersByRoleUseCase>();
    expect(useCase, isNotNull);
  });
}
