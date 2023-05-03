import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/public_profile.dart';
import 'package:picnic_app/core/domain/use_cases/block_user_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/unblock_user_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_navigator.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presentation_model.dart';
import 'package:picnic_app/features/settings/domain/use_cases/get_block_list_use_case.dart';

class BlockedListPresenter extends Cubit<BlockedListViewModel> {
  BlockedListPresenter(
    BlockedListPresentationModel model,
    this.navigator,
    this._blockListUseCase,
    this._blockUserUseCase,
    this._unblockUserUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final BlockedListNavigator navigator;
  final GetBlockListUseCase _blockListUseCase;
  final BlockUserUseCase _blockUserUseCase;
  final UnblockUserUseCase _unblockUserUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  BlockedListPresentationModel get _model => state as BlockedListPresentationModel;

  Future<void> onTapViewUserProfile(Id id) async {
    final profileUpdated = await navigator.openProfile(userId: id) ?? false;
    if (profileUpdated) {
      await loadBlockedList(fromScratch: true);
    }
  }

  void onTapToggleBlock(PublicProfile user) {
    if (user.isBlocked) {
      _blockUserUseCase
          .execute(userId: user.id) //
          .doOn(success: (userResult) => _handleBlockEvent(user))
          .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
    } else {
      _unblockUserUseCase
          .execute(userId: user.id) //
          .doOn(success: (userResult) => _handleBlockEvent(user))
          .doOn(fail: (fail) => navigator.showError(fail.displayableFailure()));
    }
  }

  Future<void> loadBlockedList({bool fromScratch = false}) {
    return _blockListUseCase
        .execute(cursor: fromScratch ? const Cursor.firstPage() : _model.cursor) //

        .doOn(
          success: (list) {
            tryEmit(
              fromScratch
                  ? _model.copyWith(users: list)
                  : _model.byAppendingBlockedList(
                      newList: list,
                    ),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void _handleBlockEvent(PublicProfile user) {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.settingsBlockedListBlockedStatusOf,
        targetValue: user.id.value,
        secondaryTargetValue: user.isBlocked.toString(),
      ),
    );
    final users = _model.users.items;
    final index = users.indexWhere((element) => element.id == user.id);
    final blockedUsers = users.toList();
    tryEmit(_model.byUpdateBlockAction(blockedUsers[index]));
  }
}
