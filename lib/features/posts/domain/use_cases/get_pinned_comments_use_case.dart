import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/posts/domain/model/get_pinned_comments_failure.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/tree_comment.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class GetPinnedCommentsUseCase {
  const GetPinnedCommentsUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<GetPinnedCommentsFailure, List<TreeComment>>> execute({
    required Post post,
  }) async {
    return _commentsRepository.getPinnedComments(post: post);
  }
}
