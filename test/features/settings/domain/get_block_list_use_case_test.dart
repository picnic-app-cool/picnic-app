import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_block_list_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late GetBlockListUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(cursor: const Cursor.firstPage());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetBlockListUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetBlockListUseCase(Mocks.privateProfileRepository);

    when(() => Mocks.privateProfileRepository.getBlockList(cursor: any(named: 'cursor'))) //
        .thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: [Stubs.publicProfile],
          pageInfo: const PageInfo.empty(),
        ),
      ),
    );

    when(() => SettingsMocks.getBlockListUseCase.execute(cursor: const Cursor.firstPage())).thenAnswer(
      (_) => successFuture(
        PaginatedList(
          items: [Stubs.publicProfile],
          pageInfo: const PageInfo.empty(),
        ),
      ),
    );
  });
}
