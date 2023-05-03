import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/get_comment_by_id_failure.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class GetCommentByIdUseCase {
  const GetCommentByIdUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<GetCommentByIdFailure, TreeComment>> execute({
    required Id commentId,
  }) {
    return _commentsRepository.getCommentById(commentId: commentId);
  }
}
