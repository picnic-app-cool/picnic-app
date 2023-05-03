import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_failure.dart';
import 'package:picnic_app/features/posts/domain/model/vote_in_poll_input.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class VoteInPollUseCase {
  const VoteInPollUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<VoteInPollFailure, Post>> execute(VoteInPollInput voteInPollInput) => _postsRepository
      .voteInPoll(voteInPollInput: voteInPollInput)
      .flatMap((_) => _postsRepository.getPostById(id: voteInPollInput.postId).mapFailure(VoteInPollFailure.unknown));
}
