import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/notify_meta.dart';
import 'package:picnic_app/core/domain/use_cases/mention_user_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';

import '../../mocks/mocks.dart';

void main() {
  late MentionUserUseCase useCase;

  setUp(() {
    useCase = MentionUserUseCase(
      Mocks.contactsRepository,
    );
  });

  test(
    'use case not ignoring at sign executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        query: '@',
        notifyMeta: const NotifyMeta.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test(
    'use case ignoring at sign executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        query: '',
        ignoreAtSign: true,
        notifyMeta: const NotifyMeta.empty(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<MentionUserUseCase>();
    expect(useCase, isNotNull);
  });
}
