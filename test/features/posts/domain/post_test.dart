import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

import '../../../mocks/stubs.dart';

void main() {
  late Post post;

  test(
    'byUpdatingShareStatus should increment share count',
    () {
      final afterShare = post.byIncrementingShareCount();
      expect(afterShare.sharesCount, 1);
    },
  );
  test(
    'byUpdatingLikeStatus should increment likes count',
    () {
      final afterLiking = post.byUpdatingLikeStatus(iReacted: true);
      expect(afterLiking.likesCount, 1);
      expect(afterLiking.iReacted, true);
    },
  );
  test(
    'byUpdatingLikeStatus should decrement likes count',
    () {
      post = post.copyWith(iReacted: true, likesCount: 10);
      final afterUnliking = post.byUpdatingLikeStatus(iReacted: false);
      expect(afterUnliking.likesCount, 9);
      expect(afterUnliking.iReacted, false);
    },
  );

  test(
    'byUpdatingLikeStatus should do nothing if post already liked',
    () {
      post = post.copyWith(iReacted: true, likesCount: 10);
      final afterUnliking = post.byUpdatingLikeStatus(iReacted: true);
      expect(afterUnliking.likesCount, 10);
      expect(afterUnliking.iReacted, true);
    },
  );

  test(
    'byUpdatingLikeStatus should do nothing if post already unliked',
    () {
      post = post.copyWith(iReacted: false, likesCount: 10);
      final afterUnliking = post.byUpdatingLikeStatus(iReacted: false);
      expect(afterUnliking.likesCount, 10);
      expect(afterUnliking.iReacted, false);
    },
  );

  setUp(
    () => post = Stubs.imagePost.copyWith(likesCount: 0, iReacted: false),
  );
}
