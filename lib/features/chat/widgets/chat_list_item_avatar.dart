import 'package:flutter/material.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/basic_circle.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/chat/domain/model/chat_type.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatListItemAvatar extends StatelessWidget {
  const ChatListItemAvatar({
    Key? key,
    required this.imageSource,
    required this.type,
  }) : super(key: key);

  factory ChatListItemAvatar.single({
    required ImageUrl imageUrl,
  }) {
    final imageSource = imageUrl.url.isEmpty
        ? PicnicImageSource.emoji(
            Constants.smileEmoji,
            style: const TextStyle(fontSize: 26.0),
          )
        : PicnicImageSource.imageUrl(
            imageUrl,
            fit: BoxFit.cover,
          );

    return ChatListItemAvatar(
      imageSource: imageSource,
      type: ChatType.single,
    );
  }

  factory ChatListItemAvatar.group() {
    final imageSource = PicnicImageSource.asset(
      ImageUrl(Assets.images.tusers.path),
      width: _iconSize,
    );

    return ChatListItemAvatar(
      imageSource: imageSource,
      type: ChatType.group,
    );
  }

  factory ChatListItemAvatar.circle({
    required BasicCircle? circle,
    required ImageUrl placeholder,
  }) {
    late PicnicImageSource imageSource;
    if (circle != null && circle.imageFile.isNotEmpty) {
      imageSource = PicnicImageSource.url(
        ImageUrl(circle.imageFile),
        width: _iconSize,
        height: _iconSize,
        fit: BoxFit.cover,
      );
    } else {
      final url = placeholder.url;
      final emoji = url.isEmpty ? Constants.smileEmoji : url;
      imageSource = PicnicImageSource.emoji(
        emoji,
        style: const TextStyle(fontSize: _iconSize),
      );
    }
    return ChatListItemAvatar(
      imageSource: imageSource,
      type: ChatType.circle,
    );
  }

  final PicnicImageSource imageSource;
  final ChatType type;

  static const _topAvatarSize = 48.0;
  static const _iconSize = 26.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;

    switch (type) {
      case ChatType.single:
        return PicnicAvatar(
          size: _topAvatarSize,
          backgroundColor: colors.blue.shade200,
          imageSource: imageSource,
          boxFit: PicnicAvatarChildBoxFit.cover,
        );
      case ChatType.circle:
        return PicnicAvatar(
          size: _topAvatarSize,
          backgroundColor: colors.blackAndWhite.shade200,
          imageSource: imageSource,
          boxFit: PicnicAvatarChildBoxFit.cover,
        );
      case ChatType.group:
        return PicnicAvatar(
          size: _topAvatarSize,
          backgroundColor: colors.purple.shade200,
          imageSource: imageSource,
          boxFit: PicnicAvatarChildBoxFit.cover,
        );
    }
  }
}
