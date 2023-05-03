import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_followers_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late GetFollowersUseCase useCase;
  const id = Id.empty();

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        userId: id,
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      );
      verify(
        () => Mocks.usersRepository.getFollowers(
          userId: id,
          searchQuery: '',
          nextPageCursor: const Cursor.firstPage(),
        ),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetFollowersUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetFollowersUseCase(Mocks.usersRepository);

    when(() {
      return Mocks.usersRepository.getFollowers(
        userId: id,
        searchQuery: '',
        nextPageCursor: any(named: "nextPageCursor"),
      );
    }).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: [Stubs.publicProfile],
          pageInfo: const PageInfo.empty(),
        ),
      ),
    );

    when(
      () => ProfileMocks.getFollowersUseCase.execute(
        userId: id,
        searchQuery: '',
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((_) {
      return successFuture(
        PaginatedList(
          items: [Stubs.publicProfile],
          pageInfo: const PageInfo.empty(),
        ),
      );
    });
  });
}
