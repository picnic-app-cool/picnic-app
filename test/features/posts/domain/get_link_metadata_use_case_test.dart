import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_link_metadata_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/posts_mocks.dart';

void main() {
  late GetLinkMetadataUseCase useCase;

  setUp(() {
    useCase = GetLinkMetadataUseCase(
      PostsMocks.postsRepository,
    );
    when(() => PostsMocks.postsRepository.getLinkMetadata(link: any(named: "link"))).thenAnswer(
      (_) => successFuture(const LinkMetadata.empty()),
    );
  });

  test(
    'should return link metadata from repository',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(link: "google.com");

      // THEN
      expect(result.isSuccess, true);
      verify(() => PostsMocks.postsRepository.getLinkMetadata(link: any(named: "link")));
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetLinkMetadataUseCase>();
    expect(useCase, isNotNull);
  });
}
