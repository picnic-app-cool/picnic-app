import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/get_link_metadata_failure.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_app/features/posts/domain/repositories/posts_repository.dart';

class GetLinkMetadataUseCase {
  const GetLinkMetadataUseCase(
    this._postsRepository,
  );

  final PostsRepository _postsRepository;

  Future<Either<GetLinkMetadataFailure, LinkMetadata>> execute({
    required String link,
  }) async {
    final uri = Uri.tryParse(link);
    if (link.trim().isEmpty || uri == null) {
      return failure(GetLinkMetadataFailure.invalidLink(uri));
    }
    return _postsRepository.getLinkMetadata(link: link);
  }
}
