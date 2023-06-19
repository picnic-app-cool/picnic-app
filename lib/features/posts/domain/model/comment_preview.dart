import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

class CommentPreview with EquatableMixin implements BasicComment {
  const CommentPreview({
    required this.id,
    required this.author,
    required this.text,
    required this.repliesCount,
    required this.postId,
    required this.createdAtString,
    required this.reactions,
    required this.myReaction,
  });

  const CommentPreview.empty()
      : id = const Id.empty(),
        myReaction = LikeDislikeReaction.noReaction,
        author = const User.empty(),
        text = '',
        repliesCount = 0,
        postId = const Id.empty(),
        createdAtString = '',
        reactions = const <LikeDislikeReaction, int>{
          LikeDislikeReaction.like: 0,
          LikeDislikeReaction.dislike: 0,
        };

  @override
  final User author;
  @override
  final String text;
  @override
  final LikeDislikeReaction myReaction;

  final Id id;

  final int repliesCount;
  final Id postId;
  final String createdAtString;

  final Map<LikeDislikeReaction, int> reactions;

  int get likes => reactions[LikeDislikeReaction.like] ?? 0;

  int get dislikes => reactions[LikeDislikeReaction.dislike] ?? 0;

  int get score => likes - dislikes;

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  bool get iLiked => myReaction == LikeDislikeReaction.like;

  bool get iDisliked => myReaction == LikeDislikeReaction.dislike;

  @override
  List<Object?> get props => [
        id,
        author,
        text,
        myReaction,
        repliesCount,
        postId,
        createdAtString,
        reactions,
      ];

  TreeComment toTreeComment() => const TreeComment.empty().copyWith(
        author: author,
        id: id,
        myReaction: myReaction,
        reactions: reactions,
        text: text,
        postId: postId,
        createdAtString: createdAtString,
      );

  CommentPreview copyWith({
    Id? id,
    User? author,
    String? text,
    bool? iReacted,
    int? repliesCount,
    Id? postId,
    String? createdAtString,
    Map<LikeDislikeReaction, int>? reactions,
    LikeDislikeReaction? myReaction,
  }) {
    return CommentPreview(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      myReaction: myReaction ?? this.myReaction,
      repliesCount: repliesCount ?? this.repliesCount,
      postId: postId ?? this.postId,
      createdAtString: createdAtString ?? this.createdAtString,
      reactions: reactions ?? this.reactions,
    );
  }

  //ignore: maximum-nesting
  CommentPreview byLikingComment() {
    if (iLiked) {
      return this;
    } else {
      var updatedReactions = Map.of(reactions);
      updatedReactions[LikeDislikeReaction.dislike] = _getUpdateDislikesCount();
      final likesCount = reactions[LikeDislikeReaction.like] ?? 0;
      updatedReactions[LikeDislikeReaction.like] = likesCount + 1;
      return copyWith(
        reactions: updatedReactions,
        myReaction: LikeDislikeReaction.like,
      );
    }
  }

  //ignore: maximum-nesting-level
  CommentPreview byDislikingComment() {
    if (iDisliked) {
      return this;
    } else {
      var updatedReactions = Map.of(reactions);
      updatedReactions[LikeDislikeReaction.like] = _getUpdateLikeCount();
      final dislikeCount = reactions[LikeDislikeReaction.dislike] ?? 0;
      updatedReactions[LikeDislikeReaction.dislike] = dislikeCount + 1;
      return copyWith(
        reactions: updatedReactions,
        myReaction: LikeDislikeReaction.dislike,
      );
    }
  }

  CommentPreview byUnReactingToComment() {
    final previouslyLiked = myReaction == LikeDislikeReaction.like;
    final previouslyDisliked = myReaction == LikeDislikeReaction.dislike;
    var updatedReactions = Map.of(reactions);
    if (previouslyLiked) {
      final likesCount = reactions[LikeDislikeReaction.like] ?? 0;
      if (likesCount != 0) {
        updatedReactions[LikeDislikeReaction.like] = likesCount - 1;
      }
    }
    if (previouslyDisliked) {
      final dislikeCount = reactions[LikeDislikeReaction.dislike] ?? 0;
      if (dislikeCount != 0) {
        updatedReactions[LikeDislikeReaction.dislike] = dislikeCount - 1;
      }
    }
    return copyWith(
      reactions: updatedReactions,
      myReaction: LikeDislikeReaction.noReaction,
    );
  }

  int _getUpdateDislikesCount() {
    final dislikeCount = reactions[LikeDislikeReaction.dislike] ?? 0;
    if (iDisliked && dislikeCount != 0) {
      return dislikeCount - 1;
    }
    return dislikeCount;
  }

  int _getUpdateLikeCount() {
    final likesCount = reactions[LikeDislikeReaction.like] ?? 0;
    if (iLiked && likesCount != 0) {
      return likesCount - 1;
    }
    return likesCount;
  }
}
