import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_last_used_sorting_option_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetLastUsedSortingOptionUseCase useCase;

  setUp(() {
    useCase = GetLastUsedSortingOptionUseCase(Mocks.circlePostsRepository);

    when(
      () => Mocks.circlePostsRepository.getLastUsedSortingOption(
        circleId: Stubs.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.trendingThisWeekPostsSortingType),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: const Id.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetLastUsedSortingOptionUseCase>();
    expect(useCase, isNotNull);
  });
}
