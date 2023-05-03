import 'package:equatable/equatable.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/basic_comment.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';

class CommentPreview with EquatableMixin implements BasicComment {
  const CommentPreview({
    required this.id,
    required this.author,
    required this.text,
    required this.isLiked,
    required this.likesCount,
    required this.repliesCount,
    required this.postId,
    required this.createdAtString,
  });

  const CommentPreview.empty()
      : id = const Id.empty(),
        isLiked = false,
        author = const User.empty(),
        text = '',
        likesCount = 0,
        repliesCount = 0,
        postId = const Id.empty(),
        createdAtString = '';

  @override
  final User author;
  @override
  final String text;

  final Id id;

  @override
  final bool isLiked;

  final int likesCount;
  final int repliesCount;
  final Id postId;
  final String createdAtString;

  DateTime? get createdAt => DateTime.tryParse(createdAtString)?.toLocal();

  @override
  List<Object?> get props => [
        id,
        author,
        text,
        isLiked,
        likesCount,
        repliesCount,
        postId,
        createdAtString,
      ];

  TreeComment toTreeComment() => const TreeComment.empty().copyWith(
        author: author,
        id: id,
        isLiked: isLiked,
        likesCount: likesCount,
        text: text,
        postId: postId,
        createdAtString: createdAtString,
      );

  CommentPreview copyWith({
    Id? id,
    User? author,
    String? text,
    bool? isLiked,
    int? likesCount,
    int? repliesCount,
    Id? postId,
    String? createdAtString,
  }) {
    return CommentPreview(
      id: id ?? this.id,
      author: author ?? this.author,
      text: text ?? this.text,
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      repliesCount: repliesCount ?? this.repliesCount,
      postId: postId ?? this.postId,
      createdAtString: createdAtString ?? this.createdAtString,
    );
  }

  CommentPreview byUpdatingLike({required bool isLiked}) => copyWith(
        isLiked: isLiked,
        likesCount: this.isLiked == isLiked ? null : likesCount + (isLiked ? 1 : -1),
      );
}
