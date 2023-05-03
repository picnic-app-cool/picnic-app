import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/search_users_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SearchUsersUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // WHEN
      final result = await useCase.execute(
        query: "Jack Smith",
        nextPageCursor: const Cursor.firstPage(),
      );
      final success = result.getSuccess();

      // THEN
      expect(result.isSuccess, true);
      expect(success?.items[0], Stubs.publicProfile);
      expect(success?.items[1], Stubs.publicProfile2);
    },
  );

  test(
    'use case ignoreMyself executes normally',
    () async {
      // WHEN
      final result = await useCase.execute(
        query: "Jack Smith",
        nextPageCursor: const Cursor.firstPage(),
        ignoreMyself: true,
      );
      final success = result.getSuccess();

      // THEN
      expect(result.isSuccess, true);
      expect(success?.items.length, 1);
      expect(success?.items[0], Stubs.publicProfile2);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<SearchUsersUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = SearchUsersUseCase(
      Mocks.usersRepository,
      Mocks.userStore,
    );

    final itemList = PaginatedList.singlePage([
      Stubs.publicProfile,
      Stubs.publicProfile2,
    ]);

    when(() => Mocks.userStore.privateProfile).thenAnswer((_) => Stubs.privateProfile);

    when(
      () => Mocks.usersRepository.searchUser(searchQuery: "Jack Smith", nextPageCursor: any(named: "nextPageCursor")),
    ).thenAnswer((_) => successFuture(itemList));
  });
}
