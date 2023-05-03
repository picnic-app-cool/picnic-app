import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_royalty_use_case.dart';

void main() {
  late GetRoyaltyUseCase useCase;

  setUp(() {
    useCase = const GetRoyaltyUseCase();
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
    final useCase = getIt<GetRoyaltyUseCase>();
    expect(useCase, isNotNull);
  });
}
