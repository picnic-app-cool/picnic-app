import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_reports_use_case.dart';
import 'package:picnic_app/features/circles/reports_list/models/circle_reports_filter_by.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late GetReportsUseCase useCase;

  setUp(() {
    useCase = GetReportsUseCase(CirclesMocks.circleReportsRepository);

    when(
      () => CirclesMocks.circleReportsRepository.getReports(
        circleId: Stubs.circle.id,
        nextPageCursor: const Cursor.empty(),
        filterBy: CircleReportsFilterBy.unresolved,
      ),
    ).thenAnswer(
      (invocation) => successFuture(PaginatedList.singlePage([Stubs.postReport])),
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        circleId: Stubs.circle.id,
        nextPageCursor: const Cursor.empty(),
        filterBy: CircleReportsFilterBy.unresolved,
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetReportsUseCase>();
    expect(useCase, isNotNull);
  });
}
