// ignore: unused_import
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/utils/mvp_extensions.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presentation_model.dart';
import 'package:picnic_app/features/avatar_selection/avatar_selection_presenter.dart';
import 'package:picnic_app/features/avatar_selection/widgets/picnic_emoji_picker.dart';
import 'package:picnic_app/features/main/widgets/bottom_navigation_size_query.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class AvatarSelectionPage extends StatefulWidget with HasPresenter<AvatarSelectionPresenter> {
  const AvatarSelectionPage({
    required this.presenter,
    Key? key,
  }) : super(key: key);

  @override
  final AvatarSelectionPresenter presenter;

  @override
  State<AvatarSelectionPage> createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage>
    with PresenterStateMixin<AvatarSelectionViewModel, AvatarSelectionPresenter, AvatarSelectionPage> {
  static const _emojiSize = 50.0;
  static const _pickerHeightRatio = 3.5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    return Scaffold(
      appBar: PicnicAppBar(
        showBackButton: false,
        actions: [
          PicnicContainerIconButton(
            iconPath: Assets.images.check.path,
            onTap: presenter.onTapConfirm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: BottomNavigationSizeQuery.of(context).height),
        child: Column(
          children: [
            Expanded(
              child: stateObserver(
                builder: (context, state) {
                  return PicnicAvatar(
                    backgroundColor: colors.blue.shade200,
                    imageSource: PicnicImageSource.emoji(
                      state.selectedEmoji,
                      style: theme.styles.title40.copyWith(
                        fontSize: _emojiSize,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / _pickerHeightRatio,
              child: PicnicEmojiPicker(
                onEmojiSelected: presenter.onEmojiSelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
