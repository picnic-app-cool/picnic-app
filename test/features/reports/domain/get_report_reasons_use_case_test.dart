import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/domain/use_cases/get_global_report_reasons_use_case.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/reports_mocks.dart';

void main() {
  late GetGlobalReportReasonsUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        reportEntityType: ReportEntityType.all,
      );

      // THEN
      verify(
        () => ReportsMocks.reportsRepository.getGlobalReportReasons(
          reportEntityType: ReportEntityType.all,
        ),
      );
      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetGlobalReportReasonsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetGlobalReportReasonsUseCase(ReportsMocks.reportsRepository);

    when(
      () => ReportsMocks.reportsRepository.getGlobalReportReasons(
        reportEntityType: ReportEntityType.all,
      ),
    ).thenAnswer((_) => successFuture(Stubs.reportReasons));
  });
}
