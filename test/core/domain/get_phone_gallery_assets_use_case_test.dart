import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/use_cases/get_phone_gallery_assets_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late GetPhoneGalleryAssetsUseCase useCase;

  setUp(() {
    when(() => Mocks.phoneGalleryRepository.getAssets(nextPageCursor: any(named: 'nextPageCursor')))
        .thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    useCase = GetPhoneGalleryAssetsUseCase(
      Mocks.phoneGalleryRepository,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.firstPage());

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetPhoneGalleryAssetsUseCase>();
    expect(useCase, isNotNull);
  });
}
