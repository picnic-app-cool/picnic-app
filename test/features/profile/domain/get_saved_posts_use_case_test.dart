import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_saved_posts_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late GetSavedPostsUseCase useCase;

  setUp(() {
    when(
      () => ProfileMocks.savedPostsRepository.getSavedPosts(
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    useCase = GetSavedPostsUseCase(ProfileMocks.savedPostsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.firstPage());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSavedPostsUseCase>();
    expect(useCase, isNotNull);
  });
}
