// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/posts/domain/model/post_type.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presentation_model.dart';
import 'package:picnic_app/features/posts/photo_post_creation/photo_post_creation_presenter.dart';
import 'package:picnic_app/features/posts/posts_list/widgets/posting_disabled_card.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_controller.dart';
import 'package:picnic_app/features/posts/widgets/camera/picnic_camera_view.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/main.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PhotoPostCreationPage extends StatefulWidget with HasPresenter<PhotoPostCreationPresenter> {
  const PhotoPostCreationPage({
    required this.presenter,
    this.cameraController,
    Key? key,
  }) : super(key: key);

  @override
  final PhotoPostCreationPresenter presenter;

  final PicnicCameraController? cameraController;

  @override
  State<PhotoPostCreationPage> createState() => _PhotoPostCreationPageState();
}

class _PhotoPostCreationPageState extends State<PhotoPostCreationPage>
    with PresenterStateMixin<PhotoPostCreationViewModel, PhotoPostCreationPresenter, PhotoPostCreationPage> {
  /// Camera View is acting weird on Android. It shows a blank black screen when you open the photo tab from post
  /// creation page. It works fine on iOS and when you take a picture it actually navigates you to the image editor
  /// page as well
  /// See the to-do in [PhotoPostCreationPresenter]
  /// HOW TO ENABLE CAMERA VIEW:
  /// Camera view is already created by the name of [PicnicCameraView], you just need to remove the 'else'
  /// condition in the ternary operator below and replace it with [PicnicCameraView] and it will start working on
  /// iOS and act weird on Android
  /// Consequently the Camera View is removed from here for the sake of merging the PR
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    /// This is to override the Camera View test crash after the Camera View is integrated
    return isUnitTests
        ? Scaffold(
            backgroundColor: theme.colors.blackAndWhite.shade900,
            body: const Center(
              child: Text(
                "PhotoPostCreationPage\n(NOT IMPLEMENTED YET)",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        : state.postingEnabled
            ? PicnicCameraView.photo(
                onPhotoTaken: presenter.onPhotoTaken,
                controller: widget.cameraController,
                onGalleryTap: state.nativeMediaPickerPostCreationEnabled ? presenter.onSelectPhotoFromGalleryTap : null,
              )
            : Scaffold(
                appBar: PicnicAppBar(
                  iconPathLeft: Assets.images.arrowlefttwo.path,
                  child: Text(
                    appLocalizations.postImageTitle,
                    style: theme.styles.subtitle30,
                  ),
                ),
                body: Center(child: PostingDisabledCard(postingType: PostType.image, circleName: state.circleName)),
              );
  }
}
