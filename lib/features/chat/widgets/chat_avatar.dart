import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class ChatAvatar extends StatelessWidget {
  const ChatAvatar({
    required this.imageSource,
    required this.backgroundColor,
  });

  final PicnicImageSource imageSource;
  final Color backgroundColor;

  static const avatarSize = 38.0;

  @override
  Widget build(BuildContext context) => PicnicAvatar(
        boxFit: PicnicAvatarChildBoxFit.cover,
        imageSource: imageSource,
        size: avatarSize,
        backgroundColor: backgroundColor,
      );
}
