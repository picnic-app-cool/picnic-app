import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/check_username_availability_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/debouncer.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/profile/domain/use_cases/edit_profile_use_case.dart';
import 'package:picnic_app/features/profile/domain/use_cases/update_profile_image_use_case.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_navigator.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presentation_model.dart';

class EditProfilePresenter extends Cubit<EditProfileViewModel> {
  EditProfilePresenter(
    EditProfilePresentationModel model,
    this.navigator,
    this._editProfileUseCase,
    this._checkUsernameAvailabilityUseCase,
    this.debouncer,
    this._updateProfileImageUseCase,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final EditProfileNavigator navigator;
  final Debouncer debouncer;
  final EditProfileUseCase _editProfileUseCase;
  final CheckUsernameAvailabilityUseCase _checkUsernameAvailabilityUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  EditProfilePresentationModel get _model => state as EditProfilePresentationModel;

  void onTapBack() {
    if (_model.profileInfoChanged) {
      onTapShowConfirm();
    } else {
      navigator.closeWithResult(false);
    }
  }

  void onTapShowConfirm() => navigator.showDiscardProfileInfoChangesRoute(
        onTapSave: state.saveEnabled
            ? () {
                _logAnalyticsEventUseCase.execute(
                  AnalyticsEvent.tap(
                    target: AnalyticsTapTarget.editProfileSaveWithChangesButton,
                    targetValue: true.toString(),
                  ),
                );
                navigator.close();
                onTapSave();
              }
            : null,
        onTapDiscard: () {
          if (state.saveEnabled) {
            _logAnalyticsEventUseCase.execute(
              AnalyticsEvent.tap(
                target: AnalyticsTapTarget.editProfileSaveWithChangesButton,
                targetValue: false.toString(),
              ),
            );
          }
          navigator.close();
        },
      );

  Future<void> onTapSave() async {
    if (_model.userSelectedNewAvatar) {
      await _updateProfileImageUseCase.execute(_model.avatar).observeStatusChanges(
            (result) => tryEmit(_model.copyWith(avatarResult: result)),
          );
    }
    await _editProfileUseCase
        .execute(
          fullName: _model.fullNameChanged ? _model.fullName : null,
          bio: _model.bioChanged ? _model.bio : null,
          username: _model.userNameChanged ? _model.username : null,
        )
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(editProfileResult: result)),
        )
        .doOn(
          success: (success) => navigator.closeWithResult(true),
          fail: (fail) => navigator.showError(
            fail.displayableFailure(),
          ),
        );
  }

  void onChangedUsername(String value) {
    tryEmit(
      _model.copyWith(
        username: value,
      ),
    );
    debouncer.debounce(
      const LongDuration(),
      () => _checkUsername(value),
    );
  }

  void onChangedFullName(String value) {
    final newFullName = value.trim();
    tryEmit(
      _model.copyWith(
        fullName: newFullName,
      ),
    );
  }

  void onChangedBio(String value) {
    final newBio = value.trim();
    tryEmit(
      _model.copyWith(
        bio: newBio,
      ),
    );
  }

  Future<void> onTapShowImagePicker() async {
    _logAnalyticsEventUseCase.execute(
      AnalyticsEvent.tap(
        target: AnalyticsTapTarget.editProfileImageTap,
      ),
    );

    final image = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (image == null) {
      return;
    }
    final newPath = await navigator.showImageEditor(filePath: image.path, forceCrop: true);
    if (newPath == null) {
      return;
    }

    tryEmit(_model.copyWith(avatar: newPath, userSelectedNewAvatar: true));
  }

  Future<void> _checkUsername(
    String newUsername,
  ) =>
      _checkUsernameAvailabilityUseCase //
          .execute(username: _model.username)
          .observeStatusChanges(
            (result) => tryEmit(
              _model.copyWith(usernameCheckResult: result),
            ),
          );
}
