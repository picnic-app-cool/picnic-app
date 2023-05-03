import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discover/domain/model/circle_group.dart';
import 'package:picnic_app/features/discover/domain/use_cases/discover_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/discover_mocks.dart';

void main() {
  late DiscoverUseCase useCase;

  setUp(() {
    useCase = DiscoverUseCase(DiscoverMocks.discoverRepository);
    when(() => DiscoverMocks.discoverRepository.getGroups()).thenAnswer((_) => successFuture(<CircleGroup>[]));
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
    final useCase = getIt<DiscoverUseCase>();
    expect(useCase, isNotNull);
  });
}
