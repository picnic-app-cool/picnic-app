//ignore_for_file: unused-code, unused-files
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

//TODO: Add giphy : https://picnic-app.atlassian.net/browse/PG-1680
class ChatExtraItems extends StatelessWidget {
  const ChatExtraItems({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  static const _blurRadius = 30.0;
  static const _borderRadius = 16.0;

  static const _shadowOpacity = 0.07;
  static const _avatarSizeCircle = 28.0;

  static const _padding = EdgeInsets.all(
    2.0,
  );

  static const _listItemHeight = 60.0;

  static const _margin = EdgeInsets.only(
    left: 24,
    right: 24.0,
    bottom: 84.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final blackAndWhite = theme.colors.blackAndWhite;
    final body20 = theme.styles.body20;
    return Container(
      width: double.infinity,
      margin: _margin,
      padding: _padding,
      decoration: BoxDecoration(
        color: blackAndWhite.shade100,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: _blurRadius,
            color: blackAndWhite.shade900.withOpacity(
              _shadowOpacity,
            ),
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: PicnicListItem(
        onTap: onTap,
        height: _listItemHeight,
        title: appLocalizations.sellSeeds,
        titleStyle: body20,
        leading: PicnicAvatar(
          size: _avatarSizeCircle,
          backgroundColor: theme.colors.green.shade200,
          imageSource: PicnicImageSource.asset(ImageUrl(Assets.images.acorn.path)),
        ),
      ),
    );
  }
}
