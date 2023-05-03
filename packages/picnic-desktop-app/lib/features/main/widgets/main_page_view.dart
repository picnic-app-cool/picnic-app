import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/constants/constants.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/private_profile.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_desktop_app/ui/widgets/navigation_rail/picnic_nav_item.dart';
import 'package:picnic_desktop_app/ui/widgets/navigation_rail/picnic_navigation_rail.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.recentItems,
    required this.profile,
  });

  final PicnicNavItemId selectedItem;
  final List<PicnicNavItemId> items;
  final List<PicnicNavItemId> recentItems;
  final PrivateProfile profile;

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    const avatarSize = 48.0;
    const avatarFontSize = 20.0;
    final imageUrl = widget.profile.profileImageUrl.url;

    return Scaffold(
      body: Row(
        children: [
          PicnicNavigationRail(
            activeItem: widget.selectedItem,
            items: widget.items,
            recentItems: widget.recentItems,
            onTap: (item) => notImplemented(),
            bottom: Column(
              children: [
                PicnicAvatar(
                  size: avatarSize,
                  backgroundColor: colors.blue.shade100,
                  imageSource: imageUrl.isEmpty
                      ? PicnicImageSource.emoji(
                          Constants.smileEmoji,
                          style: theme.styles.title40.copyWith(
                            fontSize: avatarFontSize,
                          ),
                        )
                      : PicnicImageSource.url(
                          ImageUrl(imageUrl),
                          fit: BoxFit.cover,
                        ),
                ),
                const Gap(4),
                Text(
                  appLocalizations.profileTitle,
                  style: styles.caption10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
