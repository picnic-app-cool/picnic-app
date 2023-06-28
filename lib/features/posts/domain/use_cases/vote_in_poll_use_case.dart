import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_failure.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:picnic_app/features/posts/domain/use_cases/get_post_use_case.dart';

class VoteInPollUseCase {
  const VoteInPollUseCase(
    this._postsRepository,
    this._getPostUseCase,
  );

  final PostsRepository _postsRepository;
  final GetPostUseCase _getPostUseCase;

  Future<Either<VoteInPollFailure, Post>> execute(VoteInPollInput voteInPollInput) => _postsRepository
      .voteInPoll(voteInPollInput: voteInPollInput)
      .flatMap((_) => _getPostUseCase.execute(postId: voteInPollInput.postId).mapFailure(VoteInPollFailure.unknown));
}
