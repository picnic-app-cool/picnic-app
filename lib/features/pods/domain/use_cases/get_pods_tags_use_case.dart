import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/app_tag.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/model/get_pods_tags_failure.dart';

class GetPodsTagsUseCase {
  const GetPodsTagsUseCase(this._podsRepository);

  final PodsRepository _podsRepository;

  Future<Either<GetPodsTagsFailure, List<AppTag>>> execute({
    required List<Id> podsIdsList,
  }) async =>
      _podsRepository.getPodsTags(podsIdsList: podsIdsList);
}
