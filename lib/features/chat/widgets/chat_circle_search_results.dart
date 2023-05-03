//ignore_for_file: unused-code, unused-files
import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/utils/number_formatter.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatCircleSearchResults extends StatelessWidget {
  const ChatCircleSearchResults({
    Key? key,
    required this.circles,
    this.onTapSendInvite,
  }) : super(key: key);

  final List<Circle> circles;
  final VoidCallback? onTapSendInvite;

  static const _blurRadius = 40.0;
  static const _borderRadius = 30.0;

  static const _shadowOpacity = 0.14;
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

    final avatar = PicnicAvatar(
      size: _avatarSizeCircle,
      backgroundColor: theme.colors.green.shade200,
      imageSource: PicnicImageSource.emoji('😁'),
    );
    final blackAndWhite = theme.colors.blackAndWhite;
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
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: ListView.builder(
        padding: _padding,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: circles.length,
        itemBuilder: (BuildContext context, int index) {
          return PicnicListItem(
            height: _listItemHeight,
            title: circles[index].name,
            titleStyle: theme.styles.body20,
            leading: avatar,
            trailing: Text(
              formatNumber(circles[index].membersCount) + appLocalizations.membersLabel,
              style: theme.styles.caption10.copyWith(color: blackAndWhite.shade600),
            ),
          );
        },
      ),
    );
  }
}
