import 'package:dartz/dartz.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/posts/domain/model/comment_preview.dart';
import 'package:picnic_app/features/posts/domain/model/get_comments_preview_failure.dart';
import 'package:picnic_app/features/posts/domain/repositories/comments_repository.dart';

class GetCommentsPreviewUseCase {
  const GetCommentsPreviewUseCase(this._commentsRepository);

  final CommentsRepository _commentsRepository;

  Future<Either<GetCommentsPreviewFailure, List<CommentPreview>>> execute({
    required Id postId,
    int count = Constants.defaultCommentsPreviewCount,
  }) async {
    return _commentsRepository.getCommentsPreview(
      postId: postId,
      count: count,
    );
  }
}
