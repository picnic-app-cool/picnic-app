import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/use_cases/get_slice_members_by_role_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetSliceMembersByRoleUseCase useCase;

  setUp(() {
    useCase = GetSliceMembersByRoleUseCase(Mocks.slicesRepository);

    when(
      () => Mocks.slicesRepository.getSliceMembers(
        cursor: const Cursor.firstPage(),
        sliceId: Stubs.id,
        roles: [
          SliceRole.owner,
        ],
        searchQuery: '',
      ),
    ).thenAnswer((_) => successFuture(const PaginatedList.singlePage()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        nextPageCursor: const Cursor.firstPage(),
        sliceId: Stubs.id,
        roles: [
          SliceRole.owner,
        ],
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSliceMembersByRoleUseCase>();
    expect(useCase, isNotNull);
  });
}
