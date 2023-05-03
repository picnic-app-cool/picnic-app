import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/block_user_failure.dart';
import 'package:picnic_app/core/domain/model/unblock_user_failure.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_initial_params.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presentation_model.dart';
import 'package:picnic_app/features/settings/blocked_list/blocked_list_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../mocks/settings_mock_definitions.dart';
import '../mocks/settings_mocks.dart';

void main() {
  late BlockedListPresentationModel model;
  late BlockedListPresenter presenter;
  late MockBlockedListNavigator navigator;

  final user = Stubs.publicProfile;

  setUp(() {
    model = BlockedListPresentationModel.initial(const BlockedListInitialParams());
    navigator = MockBlockedListNavigator();
    presenter = BlockedListPresenter(
      model,
      navigator,
      SettingsMocks.getBlockListUseCase,
      Mocks.blockUserUseCase,
      Mocks.unblockUserUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
    );
  });

  group('unblock user', () {
    test('on tap toggle block should unblock user success', () async {
      fakeAsync((async) {
        //GIVEN
        when(
          () => Mocks.unblockUserUseCase.execute(userId: any(named: "userId")),
        ).thenAnswer((_) => successFuture(unit));

        // WHEN
        presenter.onTapToggleBlock(user);

        // THEN
        verify(() => Mocks.unblockUserUseCase.execute(userId: user.id)).called(1);
      });
    });

    test('on tap toggle block should unblock user fail', () async {
      fakeAsync((async) {
        //GIVEN
        when(() => navigator.showError(any())).thenAnswer((_) => Future.value());
        when(
          () => Mocks.unblockUserUseCase.execute(userId: any(named: "userId")),
        ).thenAnswer((_) => failFuture(const UnblockUserFailure.unknown()));

        // WHEN
        presenter.onTapToggleBlock(user);

        // THEN
        verify(() => Mocks.unblockUserUseCase.execute(userId: user.id)).called(1);
      });
    });
  });

  group('block user', () {
    final userBlocked = user.copyWith(isBlocked: true);

    test('on tap toggle block should block user success', () async {
      fakeAsync((async) {
        //GIVEN
        when(
          () => Mocks.blockUserUseCase.execute(userId: any(named: "userId")),
        ).thenAnswer((_) => successFuture(unit));

        // WHEN
        presenter.onTapToggleBlock(userBlocked);

        // THEN
        verify(() => Mocks.blockUserUseCase.execute(userId: user.id)).called(1);
      });
    });

    test('on tap toggle block should block user fail', () async {
      fakeAsync((async) {
        //GIVEN
        when(() => navigator.showError(any())).thenAnswer((_) => Future.value());
        when(
          () => Mocks.blockUserUseCase.execute(userId: any(named: "userId")),
        ).thenAnswer((_) => failFuture(const BlockUserFailure.unknown()));

        // WHEN
        presenter.onTapToggleBlock(userBlocked);

        // THEN
        verify(() => Mocks.blockUserUseCase.execute(userId: user.id)).called(1);
      });
    });
  });
}
