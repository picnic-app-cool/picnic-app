import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/features/analytics/domain/model/analytics_event.dart';
import 'package:picnic_app/features/analytics/domain/model/tap/analytics_tap_target.dart';
import 'package:picnic_app/features/analytics/domain/use_cases/log_analytics_event_use_case.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_navigator.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';

class ProfilePhotoFormPresenter extends Cubit<ProfilePhotoFormViewModel> {
  ProfilePhotoFormPresenter(
    ProfilePhotoFormPresentationModel model,
    this.navigator,
    this._logAnalyticsEventUseCase,
  ) : super(model);

  final ProfilePhotoFormNavigator navigator;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  // ignore: unused_element
  ProfilePhotoFormPresentationModel get _model => state as ProfilePhotoFormPresentationModel;

  Future<void> onTapContinue() async {
    switch (_model.formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        _logAnalyticsEventUseCase.execute(
          AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingPhotoSkipButton),
        );
        break;
      case ProfilePhotoFormType.afterPhotoSelection:
        _logAnalyticsEventUseCase.execute(
          AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingPhotoContinueButton),
        );
        break;
    }

    tryEmit(_model.copyWith(isLoading: true));
    await _model.onTapContinueCallback(_model.photoPath);
    tryEmit(_model.copyWith(isLoading: false));
  }

  Future<void> onTapShowImagePicker() async {
    switch (_model.formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        _logAnalyticsEventUseCase.execute(
          AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingPhotoAddButton),
        );
        break;
      case ProfilePhotoFormType.afterPhotoSelection:
        _logAnalyticsEventUseCase.execute(
          AnalyticsEvent.tap(target: AnalyticsTapTarget.onboardingPhotoChangeButton),
        );
        break;
    }

    final image = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (image == null) {
      return onTapContinue();
    }

    final path = await _editPhoto(image.path);

    tryEmit(
      _model.copyWith(
        formType: ProfilePhotoFormType.afterPhotoSelection,
        photoPath: path ?? ' ',
      ),
    );
  }

  Future<String?> _editPhoto(String path) async {
    final newPath = await navigator.showImageEditor(filePath: path, forceCrop: true);

    return newPath;
  }
}
