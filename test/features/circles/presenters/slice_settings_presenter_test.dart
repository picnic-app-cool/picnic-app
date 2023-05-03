import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_initial_params.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presenter.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/circles_mock_definitions.dart';

void main() {
  late SliceSettingsPresentationModel model;
  late SliceSettingsPresenter presenter;
  late MockSliceSettingsNavigator navigator;

  test(
    'on tap close should close the navigator',
    () async {
      //GIVEN
      when(
        () => navigator.close(),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapClose();

      //THEN
      verify(
        () => navigator.close(),
      );
    },
  );

  test(
    'on tap report should open report form',
    () async {
      //GIVEN
      when(
        () => navigator.openReportForm(any()),
      ).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapReport();

      //THEN
      verify(
        () => navigator.openReportForm(any()),
      );
    },
  );

  test(
    'on tap share should open share sheet',
    () async {
      //GIVEN
      when(
        () => navigator.close(),
      ).thenAnswer((_) => Future.value());

      when(
        () => navigator.shareText(text: any(named: "text")),
      ).thenAnswer((_) => Future.value());

      //WHEN
      presenter.onTapShare();

      //THEN
      verify(
        () => navigator.close(),
      );
      verify(
        () => navigator.shareText(text: Stubs.slice.shareLink),
      );
    },
  );

  test(
    'on tap leave slice should call open confirmation bottom sheet and on pressing the confirm button should call leave slice use case ',
    () async {
      fakeAsync(
        (async) {
          //GIVEN
          when(
            () => Mocks.leaveSliceUseCase.execute(
              sliceId: any(named: 'sliceId'),
            ),
          ).thenAnswer(
            (_) => successFuture(unit),
          );

          when(
            () => navigator.closeWithResult(SliceSettingsPageResult.didLeftSlice),
          ).thenAnswer((_) => unit);

          when(
            () => navigator.showConfirmationBottomSheet(
              title: any(named: "title"),
              message: any(named: "message"),
              primaryAction: any(named: "primaryAction"),
              secondaryAction: any(named: "secondaryAction"),
            ),
          ).thenAnswer((invocation) {
            final primaryAction = invocation.namedArguments[#primaryAction] as ConfirmationAction;
            primaryAction.action.call();
            return Future.value(true);
          });

          //WHEN
          presenter.onTapLeave();
          async.flushMicrotasks();

          //THEN
          verify(
            () => navigator.showConfirmationBottomSheet(
              title: any(named: "title"),
              message: any(named: "message"),
              primaryAction: any(named: "primaryAction"),
              secondaryAction: any(named: "secondaryAction"),
            ),
          );

          verify(
            () => navigator.close(),
          );

          verify(
            () => Mocks.leaveSliceUseCase.execute(
              sliceId: any(named: 'sliceId'),
            ),
          );
          verify(
            () => navigator.closeWithResult(
              SliceSettingsPageResult.didLeftSlice,
            ),
          );
        },
      );
    },
  );

  setUp(() {
    model = SliceSettingsPresentationModel.initial(
      SliceSettingsInitialParams(circle: Stubs.circle, slice: Stubs.slice),
    );
    when(
      () => Mocks.slicesRepository.joinSlice(sliceId: any(named: 'sliceId')),
    ).thenAnswer(
      (_) => successFuture(unit),
    );
    navigator = MockSliceSettingsNavigator();
    presenter = SliceSettingsPresenter(
      model,
      navigator,
      Mocks.joinSliceUseCase,
      Mocks.leaveSliceUseCase,
    );
  });
}
