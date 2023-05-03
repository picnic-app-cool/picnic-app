import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/use_cases/set_app_info_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';
import '../../mocks/stubs.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late SetAppInfoUseCase useCase;

  setUp(() {
    useCase = SetAppInfoUseCase(Mocks.appInfoRepository, Mocks.appInfoStore);
    when(() => Mocks.appInfoRepository.getAppInfo()).thenAnswer((_) => successFuture(Stubs.appInfo));
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
    final useCase = getIt<SetAppInfoUseCase>();
    expect(useCase, isNotNull);
  });
}
