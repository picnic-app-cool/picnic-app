import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/tree_node.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/domain/model/comment_tag.dart';

//ignore_for_file:nullable_field_in_domain_entity
class TreeComment extends TreeNode<TreeComment> with EquatableMixin implements BasicComment {
  const TreeComment({
    required this.id,
    required this.author,
    required this.text,
    required this.isLiked,
    required this.isDeleted,
    required this.isPinned,
    required this.likesCount,
    required this.repliesCount,
    required TreeComment parent,
    required this.children,
    required this.postId,
    required this.createdAtString,
    this.tag,
  }) : _parent = parent;

  const TreeComment.empty()
      : id = const Id.empty(),
        isLiked = false,
        isDeleted = false,
        isPinned = false,
        author = const User.empty(),
        text = '',
        likesCount = 0,
        repliesCount = 0,
        _parent = null,
        children = const PaginatedList.empty(),
        postId = const Id.empty(),
        createdAtString = '',
        tag = null;

  const TreeComment.none() : this.empty();

  const TreeComment.root({
    required this.children,
  })  : id = const Id.empty(),
        isLiked = false,
        isDeleted = false,
        isPinned = false,
        author = const User.empty(),
        text = '',
        likesCount = 0,
        repliesCount = 0,
        _parent = null,
        postId = const Id.empty(),
        createdAtString = '',
        tag = null;

  @override
  final User author;
  @override
  final String text;

  final Id id;

  @override
  final bool isLiked;

  final bool isDeleted;

  final bool isPinned;

  final int likesCount;

  final int repliesCount;

  final Id postId;

  final String createdAtString;

  final CommentTag? tag;

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

  @override
  List<Object?> get props => [
        id,
        author,
        text,
        isLiked,
        isDeleted,
        isPinned,
        likesCount,
        repliesCount,
        children,
        postId,
        createdAtString,
        _parent?.id, // we don't put whole [parent] here to avoid stackoverflow error when calculating hashCode
      ];

  TreeComment copyWith({
    Id? id,
    User? author,
    String? text,
    bool? isLiked,
    bool? isDeleted,
    bool? isPinned,
    int? likesCount,
    int? repliesCount,
    TreeComment? parent,
    PaginatedList<TreeComment>? children,
    bool? hasMore,
    Id? postId,
    String? createdAtString,
    CommentTag? tag,
  }) {
    return TreeComment(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      isLiked: isLiked ?? this.isLiked,
      isDeleted: isDeleted ?? this.isDeleted,
      isPinned: isPinned ?? this.isPinned,
      likesCount: likesCount ?? this.likesCount,
      repliesCount: repliesCount ?? this.repliesCount,
      parent: parent ?? this.parent,
      children: children ?? this.children,
      postId: postId ?? this.postId,
      createdAtString: createdAtString ?? this.createdAtString,
      tag: tag ?? this.tag,
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
}
