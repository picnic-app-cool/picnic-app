import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/domain/use_cases/update_profile_image_use_case.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/test_utils.dart';

void main() {
  late UpdateProfileImageUseCase useCase;

  setUp(() {
    useCase = UpdateProfileImageUseCase(
      Mocks.privateProfileRepository,
      Mocks.userStore,
    );
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN
      when(
        () => Mocks.privateProfileRepository.updateProfileImage(filePath: ''),
      ).thenAnswer(
        (_) => successFuture(const ImageUrl.empty()),
      );

      when(() => Mocks.userStore.privateProfile).thenAnswer(
        (_) => const PrivateProfile.empty(),
      );

      // WHEN
      final result = await useCase.execute('');

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<UpdateProfileImageUseCase>();
    expect(useCase, isNotNull);
  });
}
