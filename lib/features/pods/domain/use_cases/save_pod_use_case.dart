import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/model/save_pod_failure.dart';

class SavePodUseCase {
  const SavePodUseCase(this._podsRepository);

  final PodsRepository _podsRepository;

  Future<Either<SavePodFailure, Unit>> execute({required Id podId}) async => _podsRepository.savePod(podId: podId);
}
