import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/model/unread_notifications_count.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_unread_notifications_count_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetUnreadNotificationsCountUseCase useCase;

  setUp(() {
    useCase = GetUnreadNotificationsCountUseCase(Mocks.privateProfileRepository);

    when(() => Mocks.privateProfileRepository.getUnreadNotificationsCount())
        .thenAnswer((invocation) => successFuture(const UnreadNotificationsCount(count: 7)));
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
    final useCase = getIt<GetUnreadNotificationsCountUseCase>();
    expect(useCase, isNotNull);
  });
}
