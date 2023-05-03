import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/get_slice_members_failure.dart';
import 'package:picnic_app/core/domain/model/get_slices_failure.dart';
import 'package:picnic_app/core/domain/model/join_slice_failure.dart';
import 'package:picnic_app/core/domain/model/leave_slice_failure.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/domain/model/slice_role.dart';
import 'package:picnic_app/core/domain/model/slice_update_input.dart';
import 'package:picnic_app/core/domain/model/update_slice_failure.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/features/slices/domain/model/accept_request_input.dart';
import 'package:picnic_app/features/slices/domain/model/approve_join_request_failure.dart';

abstract class SlicesRepository {
  Future<Either<GetSlicesFailure, PaginatedList<Slice>>> getSlices({
    required Id circleId,
    required Cursor nextPageCursor,
  });

  Future<Either<ApproveJoinRequestFailure, Slice>> approveJoinRequest({
    required AcceptRequestInput requestInput,
  });

  Future<Either<GetSliceMembersFailure, PaginatedList<SliceMember>>> getSliceMembers({
    required Id sliceId,
    required Cursor cursor,
    required List<SliceRole> roles,
    String? searchQuery,
  });

  Future<Either<JoinSliceFailure, Unit>> joinSlice({
    required Id sliceId,
  });

  Future<Either<UpdateSliceFailure, Slice>> updateSlice({
    required Id sliceId,
    required SliceUpdateInput input,
  });

  Future<Either<LeaveSliceFailure, Unit>> leaveSlice({
    required Id sliceId,
  });
}
