import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_dynamic_author.dart';

class PicnicBarWithAuthorDetails extends StatelessWidget {
  const PicnicBarWithAuthorDetails({
    Key? key,
    required this.avatar,
    required this.viewsCount,
    required this.postDetails,
    required this.title,
    this.date,
    this.titleBadge,
    required this.onTitleTap,
    this.titleColor,
    this.subtitleColor,
    this.showShadowForLightColor = false,
    this.avatarPadding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.titlePadding = EdgeInsets.zero,
  }) : super(key: key);

  final PicnicAvatar avatar;
  final Widget? postDetails;

  final String title;
  final String? date;
  final Widget? titleBadge;
  final VoidCallback? onTitleTap;
  final EdgeInsets titlePadding;

  /// whether to show shadow behind text for light color fonts
  final bool showShadowForLightColor;

  final int viewsCount;
  final Color? subtitleColor;
  final Color? titleColor;
  final EdgeInsets avatarPadding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PicnicDynamicAuthor(
                avatar: avatar,
                username: title,
                date: date,
                usernameBadge: titleBadge,
                usernamePadding: titlePadding,
                onUsernameTap: onTitleTap,
                viewsCount: viewsCount,
                titleColor: titleColor,
                avatarPadding: avatarPadding,
                postDetails: postDetails,
                subtitleColor: subtitleColor,
              ),
            ),
          ],
        ),
      );
}
