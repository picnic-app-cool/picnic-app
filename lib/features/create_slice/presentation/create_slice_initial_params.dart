import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/slice.dart';

class CreateSliceInitialParams {
  const CreateSliceInitialParams({
    required this.circle,
    this.isEditSlice = false,
    this.slice,
  });

  final Circle circle;
  final Slice? slice;
  final bool isEditSlice;
}
