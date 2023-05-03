import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:picnic_app/core/domain/model/get_runtime_permission_status_failure.dart';
import 'package:picnic_app/core/domain/model/runtime_permission_status.dart';
import 'package:picnic_app/core/domain/stores/app_info_store.dart';
import 'package:picnic_app/core/domain/use_cases/get_runtime_permission_status_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/open_native_app_settings_use_case.dart';
import 'package:picnic_app/core/domain/use_cases/request_runtime_permission_use_case.dart';
import 'package:picnic_app/core/utils/either_extensions.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/image_picker/image_picker_presentation_model.dart';
import 'package:picnic_app/features/image_picker/utils/image_source_type.dart';
import 'package:picnic_app/utils/image_type_to_permission.dart';

class ImagePickerPresenter extends Cubit<ImagePickerViewModel> {
  ImagePickerPresenter(
    ImagePickerPresentationModel model,
    this.navigator,
    this._requestRuntimePermissionUseCase,
    this._getPermissionStatusUseCase,
    this._openNativeAppSettingsUseCase,
    this._appInfoStore,
  ) : super(model);

  final ImagePickerNavigator navigator;
  final RequestRuntimePermissionUseCase _requestRuntimePermissionUseCase;
  final GetRuntimePermissionStatusUseCase _getPermissionStatusUseCase;
  final OpenNativeAppSettingsUseCase _openNativeAppSettingsUseCase;
  final AppInfoStore _appInfoStore;

  // ignore: unused_element
  ImagePickerPresentationModel get _model => state as ImagePickerPresentationModel;

  Future<void> onTapItem(ImageSourceType type) async {
    await _getPermissionStatus(type).doOn(
      fail: (fail) => navigator.showError(fail.displayableFailure()),
      success: (status) async {
        switch (status) {
          case RuntimePermissionStatus.permanentlyDenied:
            await _openAppSettings();
            break;
          case RuntimePermissionStatus.denied:
            await _requestPermission(type);
            break;
          case RuntimePermissionStatus.granted:
            _getImage(type);
            break;
          case RuntimePermissionStatus.limited:
            _getImage(type);
            break;
          default:
            break;
        }
      },
    );
  }

  Future<Either<GetRuntimePermissionStatusFailure, RuntimePermissionStatus>> _getPermissionStatus(
    ImageSourceType type,
  ) =>
      _getPermissionStatusUseCase.execute(
        permission: permissionByImageSourceType(
          type,
          info: _appInfoStore.appInfo.deviceInfo,
        ),
      );

  Future<void> _requestPermission(
    ImageSourceType type,
  ) =>
      _requestRuntimePermissionUseCase
          .execute(
            permission: permissionByImageSourceType(
              type,
              info: _appInfoStore.appInfo.deviceInfo,
            ),
          )
          .doOn(
            fail: (fail) => navigator.showError(fail.displayableFailure()),
            success: (status) async {
              switch (status) {
                case RuntimePermissionStatus.granted:
                  _getImage(type);
                  break;
                case RuntimePermissionStatus.limited:
                  _getImage(type);
                  break;
                default:
                  break;
              }
            },
          );

  Future<void> _openAppSettings() => _openNativeAppSettingsUseCase.execute();

  void _getImage(ImageSourceType type) {
    final imageFuture = navigator.getImage(type);
    navigator.closeWithResult(imageFuture);
  }
}
