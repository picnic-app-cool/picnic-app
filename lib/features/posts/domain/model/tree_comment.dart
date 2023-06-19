import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/tree_node.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/domain/model/comment_tag.dart';
import 'package:picnic_app/features/posts/domain/model/like_dislike_reaction.dart';

//ignore_for_file:nullable_field_in_domain_entity
class TreeComment extends TreeNode<TreeComment> with EquatableMixin implements BasicComment {
  const TreeComment({
    required this.id,
    required this.author,
    required this.text,
    required this.isDeleted,
    required this.isPinned,
    required this.repliesCount,
    required TreeComment parent,
    required this.children,
    required this.postId,
    required this.createdAtString,
    required this.reactions,
    required this.myReaction,
    this.tag,
  }) : _parent = parent;

  const TreeComment.empty()
      : id = const Id.empty(),
        isDeleted = false,
        isPinned = false,
        author = const User.empty(),
        myReaction = LikeDislikeReaction.noReaction,
        text = '',
        repliesCount = 0,
        _parent = null,
        children = const PaginatedList.empty(),
        postId = const Id.empty(),
        createdAtString = '',
        tag = null,
        reactions = const <LikeDislikeReaction, int>{
          LikeDislikeReaction.like: 0,
          LikeDislikeReaction.dislike: 0,
        };

  const TreeComment.none() : this.empty();

  const TreeComment.root({
    required this.children,
  })  : id = const Id.empty(),
        myReaction = LikeDislikeReaction.noReaction,
        isDeleted = false,
        isPinned = false,
        author = const User.empty(),
        text = '',
        repliesCount = 0,
        _parent = null,
        postId = const Id.empty(),
        createdAtString = '',
        tag = null,
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

  final bool isDeleted;

  final bool isPinned;

  final int repliesCount;

  final Id postId;

  final String createdAtString;

  final CommentTag? tag;

  final Map<LikeDislikeReaction, int> reactions;

  @override
  final PaginatedList<TreeComment> children;

  // StackOverflow error will occur if _parent would be setted to `const TreeComment.none()` in constructor,
  // that's why the field is nullable here, but publicaly `parent` is always `TreeComment.none` when this field is null
  final TreeComment? _parent;

  @override
  TreeComment get parent => _parent ?? const TreeComment.none();

  @override
  bool get hasParent => parent != const TreeComment.none();

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  List<TreeComment> get parents => hasParent ? [parent, ...parent.parents] : [];

  int get parentsCount => parents.length;

  int get likes => reactions[LikeDislikeReaction.like] ?? 0;

  int get dislikes => reactions[LikeDislikeReaction.dislike] ?? 0;

  int get score => likes - dislikes;

  bool get iLiked => myReaction == LikeDislikeReaction.like;

  bool get iDisliked => myReaction == LikeDislikeReaction.dislike;

  @override
  List<Object?> get props => [
        id,
        author,
        text,
        isDeleted,
        isPinned,
        reactions,
        repliesCount,
        children,
        postId,
        createdAtString,
        myReaction,
        tag,
        _parent?.id, // we don't put whole [parent] here to avoid stackoverflow error when calculating hashCode
      ];

  TreeComment copyWith({
    Id? id,
    User? author,
    String? text,
    bool? isDeleted,
    bool? isPinned,
    int? repliesCount,
    TreeComment? parent,
    PaginatedList<TreeComment>? children,
    bool? hasMore,
    Id? postId,
    String? createdAtString,
    CommentTag? tag,
    Map<LikeDislikeReaction, int>? reactions,
    LikeDislikeReaction? myReaction,
  }) {
    return TreeComment(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      isDeleted: isDeleted ?? this.isDeleted,
      isPinned: isPinned ?? this.isPinned,
      reactions: reactions ?? this.reactions,
      repliesCount: repliesCount ?? this.repliesCount,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      postId: postId ?? this.postId,
      createdAtString: createdAtString ?? this.createdAtString,
      tag: tag ?? this.tag,
      myReaction: myReaction ?? this.myReaction,
    );
  }

  @override
  TreeComment copyWithParent(TreeComment parent) {
    return copyWith(parent: parent);
  }

  @override
  TreeComment copyWithChildren(List<TreeComment> children) {
    return children is PaginatedList<TreeComment>
        ? copyWith(children: children)
        : copyWith(
            children: this.children.copyWith(items: children),
          );
  }

  //ignore: maximum-nesting
  TreeComment byLikingComment() {
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
  TreeComment byDislikingComment() {
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

  TreeComment byUnReactingToComment() {
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
