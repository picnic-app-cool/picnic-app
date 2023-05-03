import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_popular_feed_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/feed_mocks.dart';

void main() {
  late GetPopularFeedUseCase useCase;

  setUp(() {
    useCase = GetPopularFeedUseCase(FeedMocks.feedRepository);
    when(() => FeedMocks.feedRepository.getPopularFeedPosts()).thenAnswer(
      (_) => successFuture(Stubs.posts),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPopularFeedUseCase>();
    expect(useCase, isNotNull);
  });
}
