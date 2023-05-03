import 'dart:io';

import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/create_circle/create_circle/widgets/avatar_edit_button.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class CircleCoverHeader extends StatelessWidget {
  const CircleCoverHeader({
    required this.emoji,
    required this.image,
    required this.coverImage,
    required this.userSelectedNewImage,
    required this.userSelectedNewCoverImage,
    required this.contentPadding,
    this.onTapAvatarEdit,
    this.trailingWidget,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTapAvatarEdit;
  final String emoji;
  final String image;
  final bool userSelectedNewImage;
  final String coverImage;
  final bool userSelectedNewCoverImage;
  final double contentPadding;
  final Widget? trailingWidget;

  static const _emojiSize = 32.0;
  static const _avatarSize = 72.0;
  static const _coverHeight = 204.0;
  static const _borderPercentage = 0.02;

  @override
  Widget build(BuildContext context) {
    final blackAndWhite = PicnicTheme.of(context).colors.blackAndWhite;
    final white = blackAndWhite.shade100;
    final coverColor = blackAndWhite.shade200;
    final coverIconPlaceholderColor = blackAndWhite.shade600.withOpacity(0.7);
    const halfAvatarSize = _avatarSize / 2;
    return SizedBox(
      width: double.infinity,
      height: _coverHeight + halfAvatarSize,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: _coverHeight,
            color: coverColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (coverImage.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: halfAvatarSize),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        Assets.images.roundedPlaceholderImage.path,
                        color: coverIconPlaceholderColor,
                      ),
                    ),
                  )
                else
                  PicnicImage(
                    source: userSelectedNewCoverImage
                        ? PicnicImageSource.file(
                            File(coverImage),
                            width: _avatarSize,
                            height: _avatarSize,
                            fit: BoxFit.cover,
                          )
                        : PicnicImageSource.url(
                            ImageUrl(coverImage),
                            width: _avatarSize,
                            height: _avatarSize,
                            fit: BoxFit.cover,
                          ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: _avatarSize,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                child: Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (userSelectedNewImage)
                          PicnicAvatar(
                            imageSource: PicnicImageSource.file(
                              File(image),
                              width: _avatarSize,
                              height: _avatarSize,
                              fit: BoxFit.cover,
                            ),
                            boxFit: PicnicAvatarChildBoxFit.cover,
                            size: _avatarSize,
                            borderColor: white,
                            borderPercentage: _borderPercentage,
                          )
                        else
                          PicnicCircleAvatar(
                            image: image,
                            emoji: emoji,
                            avatarSize: _avatarSize,
                            emojiSize: _emojiSize,
                            borderColor: white,
                            borderPercentage: _borderPercentage,
                          ),
                        if (onTapAvatarEdit != null)
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: AvatarEditButton(
                                onTap: onTapAvatarEdit,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const Spacer(),
                    if (trailingWidget != null) trailingWidget!,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
