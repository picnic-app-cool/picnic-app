import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/helpers.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_desktop_app/ui/widgets/navigation_rail/picnic_nav_item.dart';
import 'package:picnic_desktop_app/ui/widgets/navigation_rail/picnic_navigation_rail_item.dart';

class PicnicNavigationRail extends StatelessWidget {
  const PicnicNavigationRail({
    super.key,
    required this.activeItem,
    required this.items,
    required this.recentItems,
    required this.onTap,
    this.bottom,
  });

  final PicnicNavItemId activeItem;
  final List<PicnicNavItemId> items;
  final List<PicnicNavItemId> recentItems;
  final Function(PicnicNavItemId) onTap;
  final Widget? bottom;

  static const _railWidth = 92.0;
  static const _dividerWidth = 17.0;
  static const _logoWidth = 36.0;
  static const _avatarSize = 32.0;
  static const _leftDistanceMenu = 76.0;
  static const _topDistanceMenu = -4.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    return Container(
      width: _railWidth,
      decoration: BoxDecoration(
        color: colors.blackAndWhite.shade100,
        border: Border(
          right: BorderSide(color: colors.blackAndWhite.shade300),
        ),
      ),
      child: Column(
        children: [
          const Gap(25),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: _leftDistanceMenu,
                top: _topDistanceMenu,
                child: InkResponse(
                  onTap: notImplemented,
                  child: SizedBox(
                    width: _avatarSize,
                    child: CircleAvatar(
                      backgroundColor: colors.green.shade500,
                      child: Assets.images.document.image(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Assets.images.picnicLogo.image(width: _logoWidth),
              ),
            ],
          ),
          const Spacer(),
          ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Gap(24),
            itemBuilder: (context, index) => PicnicNavigationRailItem(
              isActive: activeItem == items[index],
              item: items[index].picnicNavItem,
              onTap: onTap,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: _dividerWidth,
            height: 1,
            color: colors.blackAndWhite.shade400,
          ),
          ListView.separated(
            itemCount: recentItems.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Gap(24),
            itemBuilder: (context, index) => PicnicNavigationRailItem(
              isActive: activeItem == recentItems[index],
              item: recentItems[index].picnicNavItem,
              onTap: onTap,
              badgeCount: recentItems.length,
            ),
          ),
          const Spacer(),
          if (bottom != null) ...[
            bottom!,
            const Gap(22),
          ],
        ],
      ),
    );
  }
}
