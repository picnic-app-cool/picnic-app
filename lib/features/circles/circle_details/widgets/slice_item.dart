import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/slice.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SliceItem extends StatelessWidget {
  const SliceItem({
    required this.slice,
    required this.onTapJoinSlice,
    required this.onTapSliceItem,
  });

  final VoidCallback onTapJoinSlice;
  final ValueChanged<Slice> onTapSliceItem;
  final Slice slice;

  static const _avatarSize = 48.0;

  static const _height = 70.0;
  static const _lockIconSize = 18.0;

  static const _peopleIconSize = 18.0;

  static const _notJoinedBorderWidth = 2.0;
  static const _joinedBorderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final colors = theme.colors;
    final iJoined = slice.iJoined;
    final isPrivate = slice.private;

    final _lockIcon = Image.asset(Assets.images.lock.path, width: _lockIconSize);
    final blackAndWhite = colors.blackAndWhite;
    final _peopleIcon = Image.asset(
      Assets.images.people.path,
      width: _peopleIconSize,
      color: blackAndWhite.shade400,
    );
    final _buttonTitle = iJoined
        ? appLocalizations.joinedButtonActionTitle
        : isPrivate
            ? appLocalizations.requestToJoinAction
            : appLocalizations.joinAction;
    final white = blackAndWhite.shade100;
    return SizedBox(
      width: double.infinity,
      height: _height,
      child: Row(
        children: [
          PicnicAvatar(
            onTap: () => onTapSliceItem(slice),
            backgroundColor: colors.pink.shade200,
            size: _avatarSize,
            imageSource: PicnicImageSource.asset(
              ImageUrl(Assets.images.watermelon2.path),
            ),
          ),
          const Gap(8),
          Expanded(
            child: InkWell(
              onTap: () => onTapSliceItem(slice),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        slice.name,
                        style: styles.title10.copyWith(color: colors.pink),
                      ),
                      const Gap(4),
                      if (isPrivate) _lockIcon,
                    ],
                  ),
                  Row(
                    children: [
                      _peopleIcon,
                      const Gap(4),
                      Text(
                        slice.membersCount.toString(),
                        style: styles.caption10.copyWith(color: blackAndWhite.shade600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          PicnicButton(
            title: _buttonTitle,
            borderRadius: const PicnicButtonRadius.semiRound(),
            color: iJoined ? white : colors.green,
            titleColor: iJoined ? colors.red : white,
            style: PicnicButtonStyle.outlined,
            borderWidth: iJoined ? _notJoinedBorderWidth : _joinedBorderWidth,
            onTap: onTapJoinSlice,
            borderColor: iJoined ? colors.red : white,
          ),
        ],
      ),
    );
  }
}
