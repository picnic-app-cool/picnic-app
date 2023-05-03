import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:picnic_app/features/circles/circle_details/models/posts_sorting_type.dart';
import 'package:picnic_app/features/circles/circle_details/widgets/sort_button.dart';
import 'package:picnic_app/features/posts/domain/model/post_overlay_theme.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/top_navigation/picnic_app_bar.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

const _appBarHeight = 72.0;

class SingleFeedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SingleFeedAppBar({
    super.key,
    required this.overlayTheme,
    required this.onTapMoreOptions,
    required this.showSortButton,
    required this.onTapSort,
    required this.selectedSortOption,
  });

  final PostOverlayTheme overlayTheme;
  final VoidCallback onTapMoreOptions;
  final bool showSortButton;
  final VoidCallback onTapSort;
  final PostsSortingType selectedSortOption;

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final whiteColor = colors.blackAndWhite.shade100;

    return PicnicAppBar(
      height: _appBarHeight,
      systemOverlayStyle: overlayTheme == PostOverlayTheme.dark
          ? SystemUiOverlayStyle.dark //
          : SystemUiOverlayStyle.light,
      backButtonIconColor: overlayTheme == PostOverlayTheme.light ? whiteColor : null,
      actions: [
        IconButton(
          onPressed: onTapMoreOptions,
          icon: overlayTheme == PostOverlayTheme.dark
              ? Assets.images.setting.image()
              : Assets.images.settingsWithShadow.image(),
        ),
      ],
      child: showSortButton
          ? SortButton(
              onTap: onTapSort,
              title: selectedSortOption.valueToDisplay,
              overlayTheme: overlayTheme,
              shouldBeCentered: true,
            )
          : null,
    );
  }
}
