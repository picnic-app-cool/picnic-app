import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/leave_slice_failure.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class LeaveSliceUseCase {
  const LeaveSliceUseCase(
    this._slicesRepository,
  );

  final SlicesRepository _slicesRepository;

  Future<Either<LeaveSliceFailure, Unit>> execute({
    required Id sliceId,
  }) async {
    return _slicesRepository.leaveSlice(sliceId: sliceId);
  }
}
