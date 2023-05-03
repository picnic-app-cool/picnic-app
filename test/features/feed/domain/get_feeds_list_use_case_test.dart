import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/feed/domain/use_cases/get_feeds_list_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/feed_mocks.dart';

void main() {
  late GetFeedsListUseCase useCase;

  setUp(() {
    useCase = GetFeedsListUseCase(FeedMocks.feedRepository);
    when(() => FeedMocks.feedRepository.getFeeds(nextPageCursor: any(named: "nextPageCursor")))
        .thenAnswer((_) => successCacheableResult(const PaginatedList.empty()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final cacheable = await useCase.execute(nextPageCursor: const Cursor.empty()).first;

      // THEN
      expect(cacheable.result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetFeedsListUseCase>();
    expect(useCase, isNotNull);
  });
}
