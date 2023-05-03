import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/create_comment_failure.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class CreateCommentUseCase {
  const CreateCommentUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<CreateCommentFailure, TreeComment>> execute({
    required Id postId,
    required String text,
    Id parentCommentId = const Id.none(),
  }) async {
    return _commentsRepository.createComment(
      postId: postId,
      text: text,
      parentCommentId: parentCommentId,
    );
  }
}
