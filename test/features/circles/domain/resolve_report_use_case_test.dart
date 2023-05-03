import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/resolve_report_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late ResolveReportUseCase useCase;

  setUp(() {
    useCase = ResolveReportUseCase(CirclesMocks.circleReportsRepository);

    when(
      () => CirclesMocks.circleReportsRepository.resolveReport(
        circleId: Stubs.circle.id,
        reportId: Stubs.textPost.id,
        resolve: true,
      ),
    ).thenAnswer(
      (invocation) => successFuture(unit),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.circle.id,
        reportId: Stubs.textPost.id,
        fullFill: true,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<ResolveReportUseCase>();
    expect(useCase, isNotNull);
  });
}
