import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/model/delete_role_failure.dart';
import 'package:picnic_app/features/circles/domain/use_cases/delete_role_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late DeleteRoleUseCase useCase;

  setUp(() {
    useCase = DeleteRoleUseCase(Mocks.circlesRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.circlesRepository.deleteCircleRole(
          roleId: Stubs.id,
          circleId: Stubs.id,
        ),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      final result = await useCase.execute(
        roleId: Stubs.id,
        circleId: Stubs.id,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test('use case should return failure from repository', () async {
    // GIVEN
    when(
      () => Mocks.circlesRepository.deleteCircleRole(
        roleId: Stubs.id,
        circleId: Stubs.id,
      ),
    ).thenAnswer(
      (_) => failFuture(const DeleteRoleFailure.unknown()),
    );

    // WHEN
    final result = await useCase.execute(
      roleId: Stubs.id,
      circleId: Stubs.id,
    );

    // THEN
    expect(result.isFailure, true);
  });

  test("getIt resolves successfully", () async {
    final useCase = getIt<DeleteRoleUseCase>();
    expect(useCase, isNotNull);
  });
}
