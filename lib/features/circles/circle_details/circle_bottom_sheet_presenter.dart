import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/circle_stats.dart';
import 'package:picnic_app/core/domain/use_cases/get_circle_stats_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/join_circle_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/chat/circle_chat/circle_chat_initial_params.dart';
import 'package:picnic_app/features/chat/domain/use_cases/get_chat_use_case.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_details_initial_params.dart';
import 'package:picnic_app/features/circles/domain/use_cases/get_circle_details_use_case.dart';
import 'package:picnic_app/features/circles/domain/use_cases/view_circle_use_case.dart';
import 'package:picnic_app/features/posts/post_creation_index/post_creation_index_initial_params.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';

class CircleBottomSheetPresenter extends Cubit<CircleBottomSheetViewModel> {
  CircleBottomSheetPresenter(
    super.model,
    this.navigator,
    this._getChatUseCase,
    this._getCircleDetailsUseCase,
    this._getCircleStatsUseCase,
    this._viewCircleUseCase,
    this._joinCircleUseCase,
  );

  final CircleBottomSheetNavigator navigator;
  final GetChatUseCase _getChatUseCase;
  final GetCircleDetailsUseCase _getCircleDetailsUseCase;
  final GetCircleStatsUseCase _getCircleStatsUseCase;
  final ViewCircleUseCase _viewCircleUseCase;
  final JoinCircleUseCase _joinCircleUseCase;

  // ignore: unused_element
  CircleBottomSheetPresentationModel get _model => state as CircleBottomSheetPresentationModel;

  void onInit() {
    _getCirclesInfo();
  }

  Future<void> onTapChat() async {
    await _getChatUseCase
        .execute(
          chatId: _model.circle.chat.id,
        )
        .doOnSuccessWait(
          (chat) => navigator.openCircleChat(
            CircleChatInitialParams(
              chat: chat,
            ),
          ),
        );

    //on back navigation, update circle info
    _getCirclesInfo();
  }

  void onTapPost() {
    if (_model.circle.postingEnabled && _model.circle.hasPermissionToPost) {
      navigator.openPostCreation(
        PostCreationIndexInitialParams(
          circle: _model.circle,
        ),
      );
    } else {
      navigator.showDisabledBottomSheet(
        title: appLocalizations.postingIsDisabled,
        description: appLocalizations.postingDisabledLabel,
        onTapClose: () => navigator.close(),
      );
    }
  }

  void onTapJoin() => _joinCircleUseCase.execute(circle: _model.circle.toBasicCircle()).doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (e) {
          tryEmit(
            _model.copyWith(
              circleStats: _model.circleStats.copyWith(viewsCount: _model.circleStats.membersCount + 1),
            ),
          );
          tryEmit(
            _model.byUpdatingCircle(_model.circle.copyWith(iJoined: true)),
          );
        },
      );

  void onTapShare() {
    navigator.shareText(text: _model.circle.inviteCircleLink);
  }

  Future<void> onTapViewCircle() async {
    await navigator.openCircleDetails(CircleDetailsInitialParams(circleId: _model.circleId));
    _getCirclesInfo();
  }

  void _getCirclesInfo() {
    _getCircleStats();
    _getCircleDetails();
  }

  void _getCircleStats() => _getCircleStatsUseCase
      .execute(circleId: _model.circleId)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(circleStatsResult: result)),
      )
      .doOn(
        //intentionally not showing any error, since users cannot recover from it any way
        fail: (failure) => tryEmit(_model.copyWith(circleStats: const CircleStats.empty())),
        success: (circleStats) => tryEmit(_model.copyWith(circleStats: circleStats)),
      );

  Future<void> _getCircleDetails() async => _getCircleDetailsUseCase
      .execute(circleId: _model.circleId)
      .observeStatusChanges(
        (result) => tryEmit(_model.copyWith(circleDetailsResult: result)),
      )
      .doOn(
        fail: (failure) => navigator.showError(failure.displayableFailure()),
        success: (circle) {
          tryEmit(_model.copyWith(circle: circle));
          _increaseCircleViews();
        },
      );

  void _increaseCircleViews() {
    _viewCircleUseCase.execute(circleId: _model.circleId).doOn(
          success: (_) => tryEmit(
            _model.copyWith(
              circleStats: _model.circleStats.copyWith(viewsCount: _model.circleStats.viewsCount + 1),
            ),
          ),
        );
  }
}
