import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/phone_contacts/phone_contact.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';

class ContactAvatar extends StatelessWidget {
  const ContactAvatar({super.key, required this.phoneContact});

  final PhoneContact? phoneContact;

  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return PicnicAvatar(
      size: _avatarSize,
      boxFit: PicnicAvatarChildBoxFit.cover,
      imageSource: phoneContact?.avatar != null
          ? PicnicImageSource.memory(
              phoneContact!.avatar!,
              height: _avatarSize,
              width: _avatarSize,
              fit: BoxFit.cover,
            )
          : PicnicImageSource.asset(
              ImageUrl(Assets.images.contact.path),
              height: _avatarSize,
              width: _avatarSize,
            ),
    );
  }
}
