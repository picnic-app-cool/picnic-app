import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/save_avatar_border_use_case.dart';

import '../test_utils/test_utils.dart';

void main() {
  late SaveAvatarBorderUseCase useCase;

  setUp(() {
    useCase = const SaveAvatarBorderUseCase();
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

    final useCase = getIt<SaveAvatarBorderUseCase>();
    expect(useCase, isNotNull);
  });
}
