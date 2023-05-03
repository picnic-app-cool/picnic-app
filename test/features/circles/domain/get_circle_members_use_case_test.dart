import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_members_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCircleMembersUseCase useCase;

  setUp(() {
    useCase = GetCircleMembersUseCase(Mocks.circlesRepository, Mocks.userStore);

    when(
      () => Mocks.circlesRepository.getCircleMembers(
        circleId: Stubs.id,
        cursor: const Cursor.firstPage(),
        searchQuery: '',
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(circleId: Stubs.id, cursor: const Cursor.firstPage());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleMembersUseCase>();
    expect(useCase, isNotNull);
  });
}
