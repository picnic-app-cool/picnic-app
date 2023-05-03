import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/domain/model/create_report_input.dart';
import 'package:picnic_app/features/reports/domain/use_cases/create_global_report_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/reports_mocks.dart';

void main() {
  late CreateGlobalReportUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        report: const CreateReportInput.empty(),
      );

      // THEN
      verify(
        () => ReportsMocks.reportsRepository.createGlobalReport(
          report: const CreateReportInput.empty(),
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<CreateGlobalReportUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = CreateGlobalReportUseCase(ReportsMocks.reportsRepository);

    when(
      () => ReportsMocks.reportsRepository.createGlobalReport(
        report: const CreateReportInput.empty(),
      ),
    ).thenAnswer((_) => successFuture(unit));
  });
}
