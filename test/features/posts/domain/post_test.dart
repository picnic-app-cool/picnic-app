import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

import '../../../mocks/stubs.dart';

void main() {
  late Post post;

  test(
    'byUpdatingShareStatus should increment share count',
    () {
      final afterShare = post.byIncrementingShareCount();
      expect(afterShare.contentStats.shares, 1);
    },
  );
  test(
    'byUpdatingLikeStatus should increment likes count',
    () {
      post = post.copyWith(context: post.context.copyWith(reaction: LikeDislikeReaction.noReaction));
      expect(post.iLiked, false);
      final afterLiking = post.byLikingPost();
      expect(afterLiking.contentStats.likes, 1);
      expect(afterLiking.iLiked, true);
    },
  );

  test(
    'byUnReactingToPost should decrement likes count',
    () {
      var updatedReactions = Map.of(post.contentStats.reactions);
      updatedReactions[LikeDislikeReaction.like] = 10;
      post = post.copyWith(
        context: post.context.copyWith(reaction: LikeDislikeReaction.like),
        contentStats: post.contentStats.copyWith(reactions: updatedReactions),
      );
      expect(post.iLiked, true);
      expect(post.contentStats.reactions[LikeDislikeReaction.like], 10);
      final afterRemovingLike = post.byUnReactingToPost();
      expect(afterRemovingLike.contentStats.reactions[LikeDislikeReaction.like], 9);
      expect(afterRemovingLike.iLiked, false);
    },
  );

  test(
    'byUpdatingLikeStatus should do nothing if post already liked',
    () {
      var updatedReactions = Map.of(post.contentStats.reactions);
      updatedReactions[LikeDislikeReaction.like] = 20;
      post = post.copyWith(
        context: post.context.copyWith(reaction: LikeDislikeReaction.like),
        contentStats: post.contentStats.copyWith(reactions: updatedReactions),
      );
      expect(post.contentStats.reactions[LikeDislikeReaction.like], 20);
      expect(post.iLiked, true);
      final afterLikingAgain = post.byLikingPost();
      expect(afterLikingAgain.contentStats.reactions[LikeDislikeReaction.like], 20);
      expect(afterLikingAgain.iLiked, true);
    },
  );

  test(
    'byUpdatingDislikeStatus should increment dislikes count',
    () {
      post = post.copyWith(context: post.context.copyWith(reaction: LikeDislikeReaction.noReaction));
      expect(post.iDisliked, false);
      final afterDislike = post.byDislikingPost();
      expect(afterDislike.contentStats.dislikes, 1);
      expect(afterDislike.iDisliked, true);
    },
  );

  test(
    'byUnReactingToPost should decrement dislikes count',
    () {
      var updatedReactions = Map.of(post.contentStats.reactions);
      updatedReactions[LikeDislikeReaction.dislike] = 10;
      post = post.copyWith(
        context: post.context.copyWith(reaction: LikeDislikeReaction.dislike),
        contentStats: post.contentStats.copyWith(reactions: updatedReactions),
      );
      expect(post.iDisliked, true);
      final afterRemovingDislike = post.byUnReactingToPost();
      expect(afterRemovingDislike.contentStats.reactions[LikeDislikeReaction.dislike], 9);
      expect(afterRemovingDislike.iDisliked, false);
    },
  );

  test(
    'byUpdatingDislikeStatus should do nothing if post already disliked',
    () {
      var updatedReactions = Map.of(post.contentStats.reactions);
      updatedReactions[LikeDislikeReaction.dislike] = 20;
      post = post.copyWith(
        context: post.context.copyWith(reaction: LikeDislikeReaction.dislike),
        contentStats: post.contentStats.copyWith(reactions: updatedReactions),
      );
      expect(post.contentStats.reactions[LikeDislikeReaction.dislike], 20);
      expect(post.iDisliked, true);
      final afterDislikingAgain = post.byDislikingPost();
      expect(afterDislikingAgain.contentStats.reactions[LikeDislikeReaction.dislike], 20);
      expect(afterDislikingAgain.iDisliked, true);
    },
  );

  test(
    'byUpdatingUnReactingToPost should do nothing if post has no reaction from me',
    () {
      var updatedReactions = Map.of(post.contentStats.reactions);
      updatedReactions[LikeDislikeReaction.like] = 20;
      post = post.copyWith(
        context: post.context.copyWith(reaction: LikeDislikeReaction.noReaction),
        contentStats: post.contentStats.copyWith(reactions: updatedReactions),
      );
      expect(post.contentStats.reactions[LikeDislikeReaction.like], 20);
      expect(post.iLiked, false);
      expect(post.iDisliked, false);
      final afterUnReacting = post.byUnReactingToPost();
      expect(afterUnReacting.contentStats.reactions[LikeDislikeReaction.like], 20);
      expect(afterUnReacting.iLiked, false);
      expect(afterUnReacting.iLiked, false);
    },
  );

  setUp(
    () => post = Stubs.imagePost.copyWith(contentStats: Stubs.imagePost.contentStats),
  );
}
