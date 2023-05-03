import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/get_sounds_list_failure.dart';
import 'package:picnic_app/features/posts/domain/model/sound.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class GetSoundsListUseCase {
  const GetSoundsListUseCase(this._postsRepository);

  final PostsRepository _postsRepository;

  Future<Either<GetSoundsListFailure, PaginatedList<Sound>>> execute({
    required String searchQuery,
    required Cursor cursor,
  }) async {
    return _postsRepository
        .getSounds(
          searchQuery: searchQuery,
          cursor: cursor,
        )
        .mapFailure(GetSoundsListFailure.unknown);
  }
}
