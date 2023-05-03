import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/profile/domain/model/profile_notifications/profile_notification_glitterbomb.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_notifications_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late GetNotificationsUseCase useCase;

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

  test(
    'use case executes normally with refresh side effect',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(nextPageCursor: const Cursor.firstPage(), refresh: true);

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetNotificationsUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = GetNotificationsUseCase(Mocks.privateProfileRepository);

    when(() {
      return Mocks.privateProfileRepository.getNotificationList(cursor: any(named: 'cursor'));
    }).thenAnswer(
      (_) => successFuture(
        const PaginatedList(
          items: [
            ProfileNotificationGlitterbomb(
              id: Id.empty(),
              userId: Id.empty(),
              userAvatar: "",
              name: "",
            )
          ],
          pageInfo: PageInfo.empty(),
        ),
      ),
    );
    when(() => Mocks.privateProfileRepository.markAllNotificationsAsRead()).thenAnswer(
      (_) => successFuture(unit),
    );
  });
}
