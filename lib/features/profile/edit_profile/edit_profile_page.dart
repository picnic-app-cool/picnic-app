import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presentation_model.dart';
import 'package:picnic_app/features/profile/edit_profile/edit_profile_presenter.dart';
import 'package:picnic_app/features/profile/edit_profile/widgets/upload_avatar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_delete_suffix.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_app/ui/widgets/status_bars/dark_status_bar.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class EditProfilePage extends StatefulWidget with HasPresenter<EditProfilePresenter> {
  const EditProfilePage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final EditProfilePresenter presenter;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with PresenterStateMixin<EditProfileViewModel, EditProfilePresenter, EditProfilePage> {
  late final TextEditingController usernameController;
  late final TextEditingController fullNameController;
  late final TextEditingController bioController;

  static const bioMaxLines = 4;
  static const bioMaxLength = 500;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController(text: state.username);
    usernameController.addListener(() => presenter.onChangedUsername(usernameController.text));

    fullNameController = TextEditingController(text: state.name);
    fullNameController.addListener(() => presenter.onChangedFullName(fullNameController.text));

    bioController = TextEditingController(text: state.bio);
    bioController.addListener(() => presenter.onChangedBio(bioController.text));
  }

  @override
  void dispose() {
    usernameController.dispose();
    fullNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;

    return DarkStatusBar(
      child: WillPopScope(
        onWillPop: () async => !state.profileInfoChanged,
        child: Scaffold(
          appBar: PicnicAppBar(
            onTapBack: presenter.onTapBack,
            backgroundColor: themeColors.blackAndWhite.shade100,
            titleText: appLocalizations.editProfileTitle,
            actions: [
              stateObserver(
                builder: (context, state) => PicnicContainerIconButton(
                  iconPath: Assets.images.save.path,
                  iconTintColor: state.saveEnabled ? null : themeColors.blackAndWhite.shade400,
                  onTap: state.saveEnabled ? presenter.onTapSave : null,
                ),
              ),
            ],
          ),
          body: stateObserver(
            builder: (context, state) {
              final blackWhiteShade200 = themeColors.blackAndWhite.shade200;
              final inputTextStyle = theme.styles.body20.copyWith(
                color: themeColors.blackAndWhite.shade700,
              );

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: presenter.onTapShowImagePicker,
                            child: UploadAvatar(
                              imageSource: state.userSelectedNewAvatar
                                  ? PicnicImageSource.file(
                                      File(state.avatar),
                                      fit: BoxFit.cover,
                                    )
                                  : PicnicImageSource.url(
                                      ImageUrl(state.avatar),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          const Gap(24),
                          PicnicTextInput(
                            inputFillColor: blackWhiteShade200,
                            isLoading: state.isLoadingUsernameCheck,
                            errorText: state.usernameErrorText,
                            hintText: appLocalizations.usernameHint,
                            autocorrect: false,
                            inputTextStyle: inputTextStyle,
                            textController: usernameController,
                            suffix: state.usernameErrorText.isNotEmpty || usernameController.text.isNotEmpty
                                ? PicnicDeleteSuffix(
                                    controller: usernameController,
                                  )
                                : null,
                          ),
                          PicnicTextInput(
                            inputFillColor: blackWhiteShade200,
                            hintText: appLocalizations.fullNameHint,
                            inputTextStyle: inputTextStyle,
                            textController: fullNameController,
                            errorText: state.fullNameErrorText,
                            suffix: state.fullNameErrorText.isNotEmpty || fullNameController.text.isNotEmpty
                                ? PicnicDeleteSuffix(
                                    controller: fullNameController,
                                  )
                                : null,
                          ),
                          PicnicTextInput(
                            maxLength: bioMaxLength,
                            maxLines: bioMaxLines,
                            inputFillColor: blackWhiteShade200,
                            hintText: appLocalizations.bioHint,
                            inputTextStyle: inputTextStyle,
                            textController: bioController,
                            suffix: bioController.text.isNotEmpty
                                ? PicnicDeleteSuffix(
                                    controller: bioController,
                                  )
                                : null,
                          ),
                        ],
                      ),
                      if (state.isLoadingEditProfile || state.isLoadingAvatarUpload)
                        const Positioned.fill(
                          child: Center(
                            child: PicnicLoadingIndicator(),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
