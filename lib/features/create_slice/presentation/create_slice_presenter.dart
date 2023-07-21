import 'package:bloc/bloc.dart';
import 'package:picnic_app/core/domain/use_cases/update_slice_use_case.dart';
import 'package:picnic_app/core/utils/bloc_extensions.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/create_slice/domain/usecases/create_slice_use_case.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_navigator.dart';
import 'package:picnic_app/features/create_slice/presentation/create_slice_presentation_model.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';

class CreateSlicePresenter extends Cubit<CreateSliceViewModel> {
  CreateSlicePresenter(
    CreateSlicePresentationModel model,
    this.navigator,
    this._createSliceUseCase,
    this._updateSliceUseCase,
  ) : super(model);

  final CreateSliceNavigator navigator;
  final CreateSliceUseCase _createSliceUseCase;
  final UpdateSliceUseCase _updateSliceUseCase;

  // ignore: unused_element
  CreateSlicePresentationModel get _model => state as CreateSlicePresentationModel;

  void onTapConfirmButton() {
    if (_model.isEditSlice) {
      _updateSlice();
    } else {
      _createSlice();
    }
  }

  Future<void> onTapAvatarEdit() async {
    final image = await navigator.openImagePicker(const ImagePickerInitialParams());
    if (image == null) {
      return;
    }
    tryEmit(_model.byUpdatingForm((form) => form.copyWith(imagePath: image.path)));
  }

  void onChangedName(String value) => tryEmit(
        _model.byUpdatingForm(
          (input) => input.copyWith(name: value),
        ),
      );

  void onChangedDescription(String value) => tryEmit(
        _model.byUpdatingForm(
          (form) => form.copyWith(description: value),
        ),
      );

  void onPrivateStatusChanged({required bool newValue}) {
    tryEmit(_model.byUpdatingForm((form) => form.copyWith(private: newValue)));
  }

  void onDiscoverableStatusChanged({required bool newValue}) {
    tryEmit(_model.byUpdatingForm((form) => form.copyWith(discoverable: newValue)));
  }

  void _createSlice() {
    _createSliceUseCase
        .execute(input: _model.createSliceInput)
        .observeStatusChanges(
          (result) => tryEmit(_model.copyWith(createSliceFutureResult: result)),
        )
        .doOn(
          success: (createdSlice) {
            navigator.closeWithResult(true);
            navigator.openSliceDetails(
              SliceDetailsInitialParams(slice: createdSlice, circle: state.circle),
            );
          },
          fail: (fail) => navigator.showError(fail.displayableFailure()),
        );
  }

  void _updateSlice() {
    if (_model.updateSliceInput != null && _model.sliceId != null) {
      _updateSliceUseCase
          .execute(
            input: _model.updateSliceInput!,
            sliceId: _model.sliceId!,
          )
          .observeStatusChanges(
            (result) => tryEmit(_model.copyWith(updateSliceFutureResult: result)),
          )
          .doOn(
            success: (updatedSlice) {
              navigator.closeWithResult(true);
              navigator.openSliceDetails(
                SliceDetailsInitialParams(slice: updatedSlice, circle: state.circle),
              );
            },
            fail: (fail) => navigator.showError(fail.displayableFailure()),
          );
    }
  }
}
