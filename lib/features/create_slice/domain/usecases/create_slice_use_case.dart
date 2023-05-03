import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/features/create_slice/domain/model/create_slice_failure.dart';
import 'package:picnic_app/features/create_slice/domain/model/slice_input.dart';
import 'package:picnic_app/features/create_slice/domain/repositories/slice_creation_repository.dart';

class CreateSliceUseCase {
  const CreateSliceUseCase(this._sliceCreationRepository);

  final SliceCreationRepository _sliceCreationRepository;

  Future<Either<CreateSliceFailure, Slice>> execute({
    required SliceInput input,
  }) async {
    return _sliceCreationRepository.createSlice(input: input);
  }
}
