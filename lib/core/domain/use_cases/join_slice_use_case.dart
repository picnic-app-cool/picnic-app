import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/join_slice_failure.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class JoinSliceUseCase {
  const JoinSliceUseCase(
    this._slicesRepository,
  );

  final SlicesRepository _slicesRepository;

  Future<Either<JoinSliceFailure, Unit>> execute({
    required Id sliceId,
  }) async {
    return _slicesRepository.joinSlice(sliceId: sliceId);
  }
}
