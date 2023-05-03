import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/domain/model/approve_join_request_failure.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_initial_params.dart';

/// Model used by presenter, contains fields that are relevant to presenters and implements ViewModel to expose data to view (page)
class JoinRequestsPresentationModel implements JoinRequestsViewModel {
  /// Creates the initial state
  JoinRequestsPresentationModel.initial(
    // ignore: avoid_unused_constructor_parameters
    JoinRequestsInitialParams initialParams,
  )   : joinRequests = const PaginatedList.empty(),
        approveRequestResult = const FutureResult.empty(),
        sliceId = initialParams.sliceId,
        searchQuery = '';

  /// Used for the copyWith method
  JoinRequestsPresentationModel._({
    required this.joinRequests,
    required this.sliceId,
    required this.searchQuery,
    required this.approveRequestResult,
  });

  final FutureResult<Either<ApproveJoinRequestFailure, Slice>> approveRequestResult;

  final Id sliceId;

  @override
  final PaginatedList<PublicProfile> joinRequests;

  @override
  final String searchQuery;

  Cursor get cursor => joinRequests.nextPageCursor();

  JoinRequestsPresentationModel byAppendingJoinRequestsList({
    required PaginatedList<PublicProfile> newList,
  }) =>
      copyWith(
        joinRequests: joinRequests + newList,
      );

  JoinRequestsPresentationModel byRemovingJoinRequestsList(PublicProfile profile) => copyWith(
        joinRequests: joinRequests.byRemoving(element: profile),
      );

  JoinRequestsPresentationModel copyWith({
    PaginatedList<PublicProfile>? joinRequests,
    Id? sliceId,
    String? searchQuery,
    FutureResult<Either<ApproveJoinRequestFailure, Slice>>? approveRequestResult,
  }) {
    return JoinRequestsPresentationModel._(
      joinRequests: joinRequests ?? this.joinRequests,
      sliceId: sliceId ?? this.sliceId,
      searchQuery: searchQuery ?? this.searchQuery,
      approveRequestResult: approveRequestResult ?? this.approveRequestResult,
    );
  }
}

/// Interface to expose fields used by the view (page).
abstract class JoinRequestsViewModel {
  PaginatedList<PublicProfile> get joinRequests;

  String get searchQuery;
}
