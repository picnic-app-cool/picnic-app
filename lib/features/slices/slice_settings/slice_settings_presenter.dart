import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/join_slice_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/leave_slice_use_case.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_initial_params.dart';
import 'package:picnic_app/features/reports/domain/model/report_entity_type.dart';
import 'package:picnic_app/features/reports/report_form/report_form_initial_params.dart';
import 'package:picnic_app/features/slices/domain/model/slice_settings_page_result.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_navigator.dart';
import 'package:picnic_app/features/slices/slice_settings/slice_settings_presentation_model.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/confirmation_bottom_sheet_route.dart';

class SliceSettingsPresenter extends Cubit<SliceSettingsViewModel> {
  SliceSettingsPresenter(
    super.model,
    this.navigator,
    this._joinSliceUseCase,
    this._leaveSliceUseCase,
  );

  final SliceSettingsNavigator navigator;
  final JoinSliceUseCase _joinSliceUseCase;
  final LeaveSliceUseCase _leaveSliceUseCase;

  SliceSettingsPresentationModel get _model => state as SliceSettingsPresentationModel;

  void onTapShare() {
    navigator.close();
    navigator.shareText(text: _model.slice.shareLink);
  }

  Future<void> onTapReport() async {
    final reportSuccessful = await navigator.openReportForm(
          ReportFormInitialParams(
            entityId: _model.slice.id,
            reportEntityType: ReportEntityType.slice,
          ),
        ) ??
        false;

    if (reportSuccessful) {
      navigator.close();
    }
  }

  Future<void> onTapEdit() async {
    final sliceEdited = await navigator.openCreateSlice(
          CreateSliceInitialParams(
            circle: _model.circle,
            isEditSlice: true,
            slice: _model.slice,
          ),
        ) ??
        false;

    if (sliceEdited) {
      navigator.close();
    }
  }

  void onTapMute() {
    _updateIsMuted(true);
  }

  void onTapUnMute() {
    _updateIsMuted(false);
  }

  void onTapLeave() {
    navigator
      ..showConfirmationBottomSheet(
        title: appLocalizations.leaveSlice,
        message: appLocalizations.leaveSliceConfirmation,
        primaryAction: ConfirmationAction(
          roundedButton: true,
          title: appLocalizations.leaveSlice,
          action: () async {
            await _onTapLeave();
            //Calling close two times is needed because when tapping the leave button there is already the settings bottom sheet showing,
            // and when is tapped it will show another popup where the user is asked if he is sure that he wants to leave the slice.
            navigator.close();
            navigator.closeWithResult(SliceSettingsPageResult.didLeftSlice);
          },
        ),
        secondaryAction: ConfirmationAction.negative(
          action: () => navigator.close(),
        ),
      );
  }

  void onTapClose() => navigator.close();

  void onTapJoin() => _joinSliceUseCase
      .execute(
        sliceId: _model.slice.id,
      )
      .doOn(
        fail: (failure) => navigator.showError(
          failure.displayableFailure(),
        ),
        success: (_) {
          navigator.close();
          tryEmit(
            _model.byUpdatingSlice(
              _model.slice.copyWith(iJoined: true),
            ),
          );
        },
      );

  //TODO https://picnic-app.atlassian.net/browse/GS-5927
  Future<void> _onTapLeave() => _leaveSliceUseCase
      .execute(
        sliceId: _model.slice.id,
      )
      .doOn(
        fail: (failure) => navigator.showError(
          failure.displayableFailure(),
        ),
        success: (_) => navigator.close(),
      );

  void _updateIsMuted(bool isMuted) => notImplemented();
}
