import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/feed/domain/model/get_popular_feed_failure.dart';
import 'package:picnic_app/features/feed/domain/repositories/feed_repository.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';

class GetPopularFeedUseCase {
  const GetPopularFeedUseCase(this._feedRepository);

  final FeedRepository _feedRepository;

  Future<Either<GetPopularFeedFailure, PaginatedList<Post>>> execute() async {
    return _feedRepository.getPopularFeedPosts();
  }
}
