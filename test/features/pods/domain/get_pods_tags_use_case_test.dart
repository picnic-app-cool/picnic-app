import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/domain/use_cases/get_pods_tags_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetPodsTagsUseCase useCase;

  setUp(() {
    useCase = GetPodsTagsUseCase(
      Mocks.podsRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.podsRepository.getPodsTags(podsIdsList: any(named: 'podsIdsList')))
          .thenAnswer((_) => successFuture([]));

      // WHEN
      final result = await useCase.execute(podsIdsList: []);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPodsTagsUseCase>();
    expect(useCase, isNotNull);
  });
}
