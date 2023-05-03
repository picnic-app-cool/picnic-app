import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presentation_model.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/profile_photo_form_presenter.dart';
import 'package:picnic_app/features/onboarding/profile_photo_form/widgets/profile_photo_form_dialog_content.dart';
import 'package:picnic_app/features/onboarding/widgets/onboarding_page_container.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ProfilePhotoFormPage extends StatefulWidget with HasPresenter<ProfilePhotoFormPresenter> {
  const ProfilePhotoFormPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final ProfilePhotoFormPresenter presenter;

  @override
  State<ProfilePhotoFormPage> createState() => _ProfilePhotoFormPageState();
}

class _ProfilePhotoFormPageState extends State<ProfilePhotoFormPage>
    with PresenterStateMixin<ProfilePhotoFormViewModel, ProfilePhotoFormPresenter, ProfilePhotoFormPage> {
  static const _avatarRadius = 110.0;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          stateObserver(
            builder: (context, state) {
              const opacity = .6;
              return AnimatedSwitcher(
                key: ValueKey(state.photoPath),
                duration: const ShortDuration(),
                child: OnboardingPageContainer(
                  dialog: PicnicDialog(
                    image: PicnicAvatar(
                      size: _avatarRadius,
                      borderColor: Colors.transparent,
                      backgroundColor: state.formType == ProfilePhotoFormType.beforePhotoSelection
                          ? PicnicTheme.of(context).colors.lightBlue.shade200.withOpacity(opacity)
                          : Colors.transparent,
                      imageSource: _avatar(photoPath: state.photoPath),
                    ),
                    title: _dialogTitle(state),
                    description: _dialogDescription(state),
                    content: stateObserver(
                      builder: (context, state) => ProfilePhotoFormDialogContent(
                        onTapContinue: presenter.onTapContinue,
                        onTapOpenPhotoPicker: presenter.onTapShowImagePicker,
                        formType: state.formType,
                        isLoading: state.isLoading,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );

  String _dialogTitle(ProfilePhotoFormViewModel state) {
    switch (state.formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        return appLocalizations.profilePhotoFormBeforePhotoSelectionTitle;
      case ProfilePhotoFormType.afterPhotoSelection:
        return appLocalizations.profilePhotoFormAfterPhotoSelectionTitle;
    }
  }

  String _dialogDescription(ProfilePhotoFormViewModel state) {
    switch (state.formType) {
      case ProfilePhotoFormType.beforePhotoSelection:
        return appLocalizations.profilePhotoFormBeforePhotoSelectionDescription;
      case ProfilePhotoFormType.afterPhotoSelection:
        return appLocalizations.profilePhotoFormAfterPhotoSelectionDescription;
    }
  }

  PicnicImageSource _avatar({
    required String photoPath,
  }) =>
      photoPath.isEmpty
          ? PicnicImageSource.asset(
              ImageUrl(Assets.images.picnicLogo.path),
            )
          : PicnicImageSource.file(
              File(photoPath),
              borderRadius: _avatarRadius,
              width: _avatarRadius,
              height: _avatarRadius,
              fit: BoxFit.cover,
            );
}
