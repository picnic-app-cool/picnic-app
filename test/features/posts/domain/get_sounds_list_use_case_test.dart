import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_sounds_list_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GetSoundsListUseCase useCase;

  setUp(() {
    useCase = GetSoundsListUseCase(PostsMocks.postsRepository);
    when(
      () => PostsMocks.postsRepository.getSounds(
        searchQuery: 'searchQuery',
        cursor: const Cursor.empty(),
      ),
    ) //
        .thenAnswer((_) => successFuture(const PaginatedList.empty()));
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        searchQuery: 'searchQuery',
        cursor: const Cursor.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetSoundsListUseCase>();
    expect(useCase, isNotNull);
  });
}
