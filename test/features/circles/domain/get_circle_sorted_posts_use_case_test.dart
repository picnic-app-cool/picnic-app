import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_sorted_posts_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetCircleSortedPostsUseCase useCase;

  setUp(() {
    useCase = GetCircleSortedPostsUseCase(Mocks.circlePostsRepository);

    when(
      () => Mocks.circlePostsRepository.getCircleSortedPosts(
        circleId: const Id.empty(),
        nextPageCursor: const Cursor.firstPage(),
        sortingType: PostsSortingType.popularAllTime,
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.posts),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: const Id.empty(),
        nextPageCursor: const Cursor.firstPage(),
        sortingType: PostsSortingType.popularAllTime,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetCircleSortedPostsUseCase>();
    expect(useCase, isNotNull);
  });
}
