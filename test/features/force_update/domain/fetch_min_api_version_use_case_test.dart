import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/force_update/domain/use_case/fetch_min_app_version_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../../remote_config_repository/mocks/remote_config_repository_mocks.dart';

void main() {
  late FetchMinAppVersionUseCase useCase;

  setUp(() {
    useCase = FetchMinAppVersionUseCase(RemoteConfigRepositoryMocks.remoteConfigRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => RemoteConfigRepositoryMocks.remoteConfigRepository.fetchMinAppVersion())
          .thenAnswer((invocation) => successFuture(''));

      // WHEN
      final result = await useCase.execute();

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<FetchMinAppVersionUseCase>();
    expect(useCase, isNotNull);
  });
}
