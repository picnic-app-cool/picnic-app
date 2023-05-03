import 'package:dartz/dartz.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/domain/model/get_last_used_sorting_option_failure.dart';
import 'package:picnic_app/features/circles/domain/repositories/circle_posts_repository.dart';

class GetLastUsedSortingOptionUseCase {
  const GetLastUsedSortingOptionUseCase(this._circlePostsRepository);

  final CirclePostsRepository _circlePostsRepository;

  Future<Either<GetLastUsedSortingOptionFailure, PostsSortingType>> execute({
    required Id circleId,
  }) async {
    return _circlePostsRepository.getLastUsedSortingOption(circleId: circleId);
  }
}
