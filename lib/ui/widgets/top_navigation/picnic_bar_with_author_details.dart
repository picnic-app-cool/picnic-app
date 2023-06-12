import 'package:flutter/material.dart';
import 'package:picnic_app/ui/widgets/picnic_dynamic_author.dart';

class PicnicBarWithAuthorDetails extends StatelessWidget {
  const PicnicBarWithAuthorDetails({
    Key? key,
    required this.avatar,
    required this.viewsCount,
    required this.postDetails,
    required this.circleName,
    required this.authorUsername,
    required this.iFollow,
    required this.onAuthorUsernameTap,
    required this.onCircleNameTap,
    this.date,
    this.authorVerifiedBadge,
    this.titleColor,
    this.subtitleColor,
    this.showShadowForLightColor = false,
    this.avatarPadding = const EdgeInsets.symmetric(horizontal: 8.0),
    this.titlePadding = EdgeInsets.zero,
    this.onTapFollow,
  }) : super(key: key);

  final Widget avatar;
  final Widget? postDetails;

  final String circleName;
  final String authorUsername;
  final String? date;
  final Widget? authorVerifiedBadge;
  final VoidCallback? onAuthorUsernameTap;
  final VoidCallback? onCircleNameTap;
  final EdgeInsets titlePadding;
  final VoidCallback? onTapFollow;
  final bool iFollow;

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
                authorUsername: authorUsername,
                circleName: circleName,
                date: date,
                authorVerifiedBadge: authorVerifiedBadge,
                usernamePadding: titlePadding,
                onAuthorUsernameTap: onAuthorUsernameTap,
                viewsCount: viewsCount,
                circleNameColor: titleColor,
                avatarPadding: avatarPadding,
                postDetails: postDetails,
                subtitleColor: subtitleColor,
                iFollow: iFollow,
                onTapFollow: onTapFollow,
                onCircleTap: onCircleNameTap,
              ),
            ),
          ],
        ),
      );
}
