import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/temporary_banned_user.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/countdown_timer_builder.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class TemporaryBannedUserView extends StatelessWidget {
  const TemporaryBannedUserView({
    required this.currentTimeProvider,
    required this.onTapUnban,
    required this.user,
    required this.onBannedUserTap,
  });

  final CurrentTimeProvider currentTimeProvider;
  final Function(BannedUser) onTapUnban;
  final Function(BannedUser) onBannedUserTap;
  final TemporaryBannedUser user;

  static const _avatarSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    return PicnicListItem(
      height: null,
      title: user.userName,
      titleStyle: theme.styles.subtitle20,
      leading: PicnicAvatar(
        size: _avatarSize,
        boxFit: PicnicAvatarChildBoxFit.cover,
        imageSource: PicnicImageSource.url(
          ImageUrl(user.userAvatar),
          fit: BoxFit.cover,
        ),
        placeholder: () => DefaultAvatar.user(),
        onTap: () => onBannedUserTap(user),
      ),
      trailing: Row(
        children: [
          Image.asset(Assets.images.banIcon.path),
          const Gap(4),
          CountdownTimerBuilder(
            currentTimeProvider: currentTimeProvider,
            deadline: user.unbanTimeStamp,
            builder: (context, timeRemaining) => Text(
              appLocalizations.remainingTimeLabel(
                (timeRemaining.isNegative ? Duration.zero : timeRemaining).formattedHH,
              ),
              style: theme.styles.body20,
            ),
            timerCompleteBuilder: (context) => const SizedBox(),
          ),
        ],
      ),
    );
  }
}
