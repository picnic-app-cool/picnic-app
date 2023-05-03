import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/utils/current_time_provider.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/permanent_banned_user_view.dart';
import 'package:picnic_app/features/circles/circle_settings/widgets/temporary_banned_user_view.dart';
import 'package:picnic_app/features/circles/domain/model/banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/permanent_banned_user.dart';
import 'package:picnic_app/features/circles/domain/model/temporary_banned_user.dart';

class BannedUserWidget extends StatelessWidget {
  const BannedUserWidget({
    Key? key,
    required this.user,
    required this.currentTimeProvider,
    required this.circle,
    required this.onTapUnban,
    required this.onTapBannedUser,
  }) : super(key: key);

  final BannedUser user;
  final CurrentTimeProvider currentTimeProvider;
  final Circle circle;
  final Function(BannedUser) onTapUnban;
  final Function(BannedUser) onTapBannedUser;

  @override
  Widget build(BuildContext context) {
    if (user is TemporaryBannedUser) {
      return TemporaryBannedUserView(
        currentTimeProvider: currentTimeProvider,
        user: user as TemporaryBannedUser,
        onTapUnban: (bannedUser) => onTapUnban(bannedUser),
        onBannedUserTap: onTapBannedUser,
      );
    } else if (user is PermanentBannedUser) {
      return PermanentBannedUserView(
        user: user,
        onTapUnban: (bannedUser) => onTapUnban(bannedUser),
        onBannedUserTap: onTapBannedUser,
      );
    }
    return const SizedBox.shrink();
  }
}
