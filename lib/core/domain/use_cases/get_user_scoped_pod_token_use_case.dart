import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/generated_token.dart';
import 'package:picnic_app/core/domain/model/get_user_scoped_pod_token_failure.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetUserScopedPodTokenUseCase {
  const GetUserScopedPodTokenUseCase(
    this._podsRepository,
  );

  final PodsRepository _podsRepository;

  Future<Either<GetUserScopedPodTokenFailure, GeneratedToken>> execute({
    required Id podId,
  }) async {
    return _podsRepository.getGeneratedAppToken(podId: podId);
  }
}
