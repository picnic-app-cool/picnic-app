import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/slices/domain/model/accept_request_input.dart';
import 'package:picnic_app/features/slices/domain/model/get_slice_join_requests_failure.dart';
import 'package:picnic_app/features/slices/domain/use_cases/approve_join_request_use_case.dart';
import 'package:picnic_app/features/slices/domain/use_cases/get_slice_join_requests_use_case.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_navigator.dart';
import 'package:picnic_app/features/slices/join_requests/join_requests_presentation_model.dart';

class JoinRequestsPresenter extends Cubit<JoinRequestsViewModel> {
  JoinRequestsPresenter(
    super.model,
    this.navigator,
    this._getJoinRequestsUseCase,
    this._approveJoinRequestUseCase,
  );

  final JoinRequestsNavigator navigator;
  final GetSliceJoinRequestsUseCase _getJoinRequestsUseCase;
  final ApproveJoinRequestUseCase _approveJoinRequestUseCase;

  // ignore: unused_element
  JoinRequestsPresentationModel get _model => state as JoinRequestsPresentationModel;

  Future<void> onTapApprove(PublicProfile userProfile) async => _approveJoinRequestUseCase
      .execute(
        acceptRequestInput: AcceptRequestInput(
          sliceId: _model.sliceId,
          userRequestedToJoinID: userProfile.id,
        ),
      )
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(approveRequestResult: result)),
      )
      .doOn(
        success: (joinRequests) => tryEmit(_model.byRemovingJoinRequestsList(userProfile)),
        fail: (fail) => navigator.showError(fail.displayableFailure()),
      );

  void onTapUser(Id userId) => notImplemented();

  void onJoinRequestsSearch(String searchQuery) => notImplemented();

  Future<Either<GetSliceJoinRequestsFailure, PaginatedList<PublicProfile>>> loadPendingRequests({
    bool fromScratch = false,
  }) {
    if (fromScratch) {
      tryEmit(_model.copyWith(joinRequests: const PaginatedList.empty()));
    }
    return _getJoinRequestsUseCase
        .execute(
          sliceId: _model.sliceId,
          searchQuery: _model.searchQuery,
        )
        .doOn(
          success: (joinRequests) {
            tryEmit(
              fromScratch
                  ? _model.copyWith(joinRequests: joinRequests)
                  : _model.byAppendingJoinRequestsList(newList: joinRequests),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }
}
