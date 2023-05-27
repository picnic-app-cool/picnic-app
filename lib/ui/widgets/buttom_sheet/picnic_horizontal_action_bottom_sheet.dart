import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/user.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/navigation/horizontal_action_bottom_sheet_route.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_action_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

//TODO: UI - Restrict number of items in PicnicHorizontalActionBottomSheet: https://picnic-app.atlassian.net/browse/GS-1803
class PicnicHorizontalActionBottomSheet extends StatelessWidget {
  const PicnicHorizontalActionBottomSheet({
    required this.onTapClose,
    required this.actions,
    this.title,
    this.user,
  });

  final List<ActionBottom> actions;
  final String? title;
  final VoidCallback onTapClose;
  final User? user;

  static const _titlePadding = EdgeInsets.only(left: 20.0);
  static const _listItemPadding = EdgeInsets.only(left: 8.0);
  static const _iconWidth = 20.0;
  static const _opacity = 0.4;
  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final divider = Divider(
      color: blackAndWhite.withOpacity(_opacity),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          const Gap(20),
          Padding(
            padding: _titlePadding,
            child: Text(
              title ?? '',
              style: theme.styles.subtitle40,
            ),
          ),
        ],
        if (user != null) ...[
          Padding(
            padding: _listItemPadding,
            child: PicnicListItem(
              title: user?.username ?? '',
              titleStyle: theme.styles.body30,
              leading: PicnicAvatar(
                size: _avatarSize,
                boxFit: PicnicAvatarChildBoxFit.cover,
                backgroundColor: theme.colors.lightBlue.shade200,
                imageSource: PicnicImageSource.url(
                  user?.profileImageUrl ?? const ImageUrl.empty(),
                  width: _avatarSize,
                  height: _avatarSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          divider,
        ],
        const Gap(22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: actions
              .where((element) => element.icon != null)
              .map(
                (e) => PicnicActionButton(
                  icon: Image.asset(
                    e.icon!,
                    width: _iconWidth,
                  ),
                  label: e.label,
                  onTap: e.action,
                ),
              )
              .toList(),
        ),
        Center(
          child: PicnicTextButton(
            label: appLocalizations.closeAction,
            onTap: onTapClose,
          ),
        ),
        const Gap(16),
      ],
    );
  }
}
