import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_blacklisted_words_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late GetBlacklistedWordsUseCase useCase;

  setUp(() {
    useCase = GetBlacklistedWordsUseCase(CirclesMocks.circleModeratorActionsRepository);

    when(
      () => CirclesMocks.circleModeratorActionsRepository.getBlackListedWords(
        circleId: any(named: 'circleId'),
        cursor: any(named: 'cursor'),
        searchQuery: '',
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        const PaginatedList(
          pageInfo: PageInfo.empty(),
          items: ['fork', 'beach', 'dig'],
        ),
      ),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.id,
        cursor: const Cursor.firstPage(),
      );
      final success = result.getSuccess();

      // THEN
      expect(result.isSuccess, true);
      expect(success?.items[0], 'fork');
      expect(success?.items[1], 'beach');
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetBlacklistedWordsUseCase>();
    expect(useCase, isNotNull);
  });
}
