import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/edit_profile_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late EditProfileUseCase useCase;

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(() => Mocks.userStore.privateProfile).thenAnswer(
        (_) => const PrivateProfile.empty(),
      );

      // WHEN
      final result = await useCase.execute(username: '');
      verify(() => Mocks.privateProfileRepository.editPrivateProfile(username: ''));

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<EditProfileUseCase>();
    expect(useCase, isNotNull);
  });

  setUp(() {
    useCase = EditProfileUseCase(
      Mocks.privateProfileRepository,
      Mocks.userStore,
    );

    when(() => Mocks.privateProfileRepository.editPrivateProfile(username: '')).thenAnswer((_) => successFuture(unit));

    when(() => ProfileMocks.editProfileUseCase.execute(username: '')).thenAnswer((_) {
      return successFuture(unit);
    });
  });
}
