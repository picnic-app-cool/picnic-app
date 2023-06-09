import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/repositories/pods_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/pods/domain/model/enable_pod_in_circle_failure.dart';

class EnablePodInCircleUseCase {
  const EnablePodInCircleUseCase(this._podsRepository);

  final PodsRepository _podsRepository;

  Future<Either<EnablePodInCircleFailure, Unit>> execute({
    required Id podId,
    required Id circleId,
  }) async =>
      _podsRepository.enablePodInCircle(
        podId: podId,
        circleId: circleId,
      );
}
