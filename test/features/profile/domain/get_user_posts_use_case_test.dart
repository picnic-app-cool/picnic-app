import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/basic_public_profile.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/post_contents/image_post_content.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/profile/domain/use_cases/get_user_posts_use_case.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late GetUserPostsUseCase useCase;

  setUp(() {
    when(
      () => ProfileMocks.getUserPostsRepository.getUserPosts(
        userId: const Id.empty(),
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.firstPage(),
          items: [
            const Post.empty().copyWith(
              viewsCount: 1,
              author: const BasicPublicProfile.empty(),
              content: const ImagePostContent(
                text: 'text',
                imageUrl: ImageUrl(
                  'https://firebasestorage.googleapis.com/v0/b/amber-app-supercool.appspot.com/o/mock-images%2Fpost_drink.webp?alt=media&token=',
                ),
              ),
            )
          ],
        ),
      ),
    );

    useCase = GetUserPostsUseCase(ProfileMocks.getUserPostsRepository);
  });

  test(
    'use case executes normally',
    () async {
      // GIVEN

      // WHEN
      final result = await useCase.execute(
        userId: const Id.empty(),
        nextPageCursor: const Cursor.firstPage(),
      );

      // THEN
      expect(result.isSuccess, true);
    },
  );

  test("getIt resolves successfully", () async {
    final useCase = getIt<GetUserPostsUseCase>();
    expect(useCase, isNotNull);
  });
}
