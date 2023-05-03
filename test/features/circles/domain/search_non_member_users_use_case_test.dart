import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/use_cases/search_non_member_users_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late SearchNonMemberUsersUseCase useCase;

  setUp(() {
    useCase = SearchNonMemberUsersUseCase(Mocks.usersRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      final itemList = PaginatedList<PublicProfile>(
        pageInfo: const PageInfo.empty().copyWith(
          previousPageId: const Id('0'),
          hasPreviousPage: true,
          hasNextPage: false,
        ),
        items: [
          Stubs.publicProfile,
          Stubs.publicProfile,
        ],
      );
      when(
        () => Mocks.usersRepository.searchNonMembershipUsers(
          searchQuery: 'John Doe',
          circleId: const Id('1'),
          nextPageCursor: any(named: 'nextPageCursor'),
        ),
      ).thenAnswer((_) => successFuture(itemList));

      // WHEN
      final result = await useCase.execute(
        searchQuery: 'John Doe',
        circleId: const Id('1'),
        cursor: const Cursor.firstPage(),
      );
      final success = result.getSuccess();

      // THEN
      expect(result.isSuccess, true);
      expect(success?.items[0], Stubs.publicProfile);
      expect(success?.items[1], Stubs.publicProfile);
    },
  );

  test('getIt resolves successfully', () async {
    final useCase = getIt<SearchNonMemberUsersUseCase>();
    expect(useCase, isNotNull);
  });
}
