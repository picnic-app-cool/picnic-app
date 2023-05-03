import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_slice_members_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/repositories/slices_repository.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';

class GetSliceMembersByRoleUseCase {
  const GetSliceMembersByRoleUseCase(
    this._slicesRepository,
  );

  final SlicesRepository _slicesRepository;

  Future<Either<GetSliceMembersFailure, PaginatedList<SliceMember>>> execute({
    required Cursor nextPageCursor,
    required Id sliceId,
    required List<SliceRole> roles,
    String? searchQuery = '',
  }) =>
      _slicesRepository.getSliceMembers(
        sliceId: sliceId,
        cursor: nextPageCursor,
        searchQuery: searchQuery,
        roles: roles,
      );
}
