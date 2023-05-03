import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_slices_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';

class GetSlicesUseCase {
  const GetSlicesUseCase(
    this._slicesRepository,
  );

  final SlicesRepository _slicesRepository;
  Future<Either<GetSlicesFailure, PaginatedList<Slice>>> execute({
    required Cursor nextPageCursor,
    required Id circleId,
  }) =>
      _slicesRepository.getSlices(nextPageCursor: nextPageCursor, circleId: circleId);
}
