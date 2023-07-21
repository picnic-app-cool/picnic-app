import 'package:flutter/material.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_navigator.dart';
import 'package:picnic_app/features/image_picker/image_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_initial_params.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_page.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/navigation/transitions/sliding_page_transition.dart';

class ProfilePhotoFormNavigator with ImagePickerRoute, AvatarSelectionRoute {
  ProfilePhotoFormNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;
}

mixin ProfilePhotoFormRoute {
  Future<void> openProfilePhotoForm(
    ProfilePhotoFormInitialParams initialParams,
  ) async {
    return appNavigator.push(
      SlidingPageTransition(getIt<ProfilePhotoFormPage>(param1: initialParams)),
      context: context,
    );
  }

  AppNavigator get appNavigator;

  BuildContext? get context;
}
