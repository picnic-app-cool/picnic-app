import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_feed_posts_list_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GetFeedPostsListUseCase useCase;

  setUp(() {
    useCase = GetFeedPostsListUseCase(PostsMocks.postsRepository);
    when(
      () => PostsMocks.postsRepository.getFeedPosts(
        feedId: const Id.empty(),
        searchQuery: 'searchQuery',
        cursor: const Cursor.empty(),
        cachePolicy: any(named: 'cachePolicy'),
      ),
    ) //
        .thenAnswer((_) => successCacheableResult(const PaginatedList.empty()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final cacheable = await useCase
          .execute(
            feedId: const Id.empty(),
            searchQuery: 'searchQuery',
            cursor: const Cursor.empty(),
          )
          .first;

      // THEN
      expect(cacheable.result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetFeedPostsListUseCase>();
    expect(useCase, isNotNull);
  });
}
