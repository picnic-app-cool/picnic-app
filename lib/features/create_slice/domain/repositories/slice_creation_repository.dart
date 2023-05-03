import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/features/create_slice/domain/model/create_slice_failure.dart';
import 'package:picnic_app/features/create_slice/domain/model/slice_input.dart';

abstract class SliceCreationRepository {
  Future<Either<CreateSliceFailure, Slice>> createSlice({
    required SliceInput input,
  });
}
