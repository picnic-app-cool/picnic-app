import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/domain/model/get_slice_join_requests_failure.dart';
import 'package:picnic_app/utils/extensions/future_retarder.dart';

class GetSliceJoinRequestsUseCase with FutureRetarder {
  GetSliceJoinRequestsUseCase();

  //TODO BE integration https://picnic-app.atlassian.net/browse/GS-5349
  Future<Either<GetSliceJoinRequestsFailure, PaginatedList<PublicProfile>>> execute({
    required Id sliceId,
    String searchQuery = '',
  }) async {
    await randomSleep();
    return success(
      const PaginatedList.singlePage(),
    );
  }
}
