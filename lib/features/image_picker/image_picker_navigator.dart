import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/image_picker/image_picker_initial_params.dart';
import 'package:picnic_app/features/image_picker/image_picker_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/close_route.dart';
import 'package:picnic_app/navigation/close_with_result_route.dart';
import 'package:picnic_app/navigation/error_bottom_sheet_route.dart';
import 'package:picnic_app/navigation/get_image_route.dart';

class ImagePickerNavigator with ErrorBottomSheetRoute, CloseWithResultRoute<Future<File?>>, GetImageRoute, CloseRoute {
  ImagePickerNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ImagePickerRoute {
  Future<File?> openImagePicker(ImagePickerInitialParams initialParams) async {
    return await showDialog<Future<File?>>(
      context: AppNavigator.currentContext,
      builder: (context) => getIt<ImagePickerPage>(param1: initialParams),
    );
  }

  AppNavigator get appNavigator;
}
