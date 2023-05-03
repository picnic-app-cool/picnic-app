import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/load_avatar_borders_use_case.dart';

import '../test_utils/test_utils.dart';

void main() {
  late LoadAvatarBordersUseCase useCase;

  setUp(() {
    useCase = const LoadAvatarBordersUseCase();
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isLeft(), true);
    },
  );

  test("getIt resolves successfully", () async {
    await configureDependenciesForTests();

    final useCase = getIt<LoadAvatarBordersUseCase>();
    expect(useCase, isNotNull);
  });
}
