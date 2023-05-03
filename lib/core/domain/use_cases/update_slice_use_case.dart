import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/core/domain/model/update_slice_failure.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class UpdateSliceUseCase {
  const UpdateSliceUseCase(this._slicesRepository);

  final SlicesRepository _slicesRepository;

  Future<Either<UpdateSliceFailure, Slice>> execute({
    required Id sliceId,
    required SliceUpdateInput input,
  }) async {
    return _slicesRepository.updateSlice(
      sliceId: sliceId,
      input: input,
    );
  }
}
