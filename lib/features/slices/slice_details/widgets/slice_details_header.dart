import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class SliceDetailsHeader extends StatelessWidget {
  const SliceDetailsHeader({
    required this.iJoined,
    required this.iRequestedToJoin,
    required this.onTapChat,
    required this.onTapJoin,
    required this.canApproveRequests,
    required this.pendingRequestsCount,
    required this.isPrivate,
  });

  final bool iJoined;
  final bool iRequestedToJoin;
  final bool canApproveRequests;
  final bool isPrivate;
  final int pendingRequestsCount;
  final VoidCallback onTapChat;
  final VoidCallback onTapJoin;

  static const buttonBorderWidth = 2.0;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final Widget joinButton;

    if (iJoined) {
      // ignore: avoid-returning-widgets
      joinButton = isPrivate && canApproveRequests
          ? _PendingRequestsButton(
              onTapPendingRequests: onTapJoin,
              pendingRequestsCount: pendingRequestsCount,
            )
          : const _JoinedButton();
    } else if (iRequestedToJoin) {
      // ignore: avoid-returning-widgets
      joinButton = const _PendingButton();
    } else {
      // ignore: avoid-returning-widgets
      joinButton = _JoinButton(onTapJoin: onTapJoin);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: joinButton,
          ),
          const Gap(8),
          if (iJoined)
            Expanded(
              child: PicnicButton(
                icon: Assets.images.chat.path,
                title: appLocalizations.sliceChatLabel,
                titleColor: colors.blackAndWhite.shade100,
                borderRadius: const PicnicButtonRadius.round(),
                color: colors.purple.shade500,
                onTap: onTapChat,
              ),
            ),
        ],
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({required this.onTapJoin});

  final VoidCallback onTapJoin;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    return PicnicButton(
      icon: Assets.images.star.path,
      title: appLocalizations.joinButtonActionTitle,
      borderRadius: const PicnicButtonRadius.round(),
      titleColor: colors.blackAndWhite.shade100,
      color: colors.pink.shade500,
      onTap: onTapJoin,
    );
  }
}

class _PendingButton extends StatelessWidget {
  const _PendingButton();

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final pinkColor = colors.pink.shade500;
    return PicnicButton(
      icon: Assets.images.star.path,
      title: appLocalizations.slicePendingJoinRequestLabel,
      borderRadius: const PicnicButtonRadius.round(),
      style: PicnicButtonStyle.outlined,
      borderColor: pinkColor,
      borderWidth: SliceDetailsHeader.buttonBorderWidth,
      titleColor: pinkColor,
      color: Colors.transparent,
    );
  }
}

class _JoinedButton extends StatelessWidget {
  const _JoinedButton();

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    final pinkColor = colors.pink.shade500;
    return PicnicButton(
      icon: Assets.images.star.path,
      title: appLocalizations.joinedButtonActionTitle,
      borderRadius: const PicnicButtonRadius.round(),
      style: PicnicButtonStyle.outlined,
      borderColor: pinkColor,
      borderWidth: SliceDetailsHeader.buttonBorderWidth,
      titleColor: pinkColor,
      color: Colors.transparent,
    );
  }
}

class _PendingRequestsButton extends StatelessWidget {
  const _PendingRequestsButton({
    required this.onTapPendingRequests,
    required this.pendingRequestsCount,
  });

  final VoidCallback onTapPendingRequests;
  final int pendingRequestsCount;

  @override
  Widget build(BuildContext context) {
    final colors = PicnicTheme.of(context).colors;
    return PicnicButton(
      title: "($pendingRequestsCount) ${appLocalizations.joinRequestsSuffixLabel}",
      borderRadius: const PicnicButtonRadius.round(),
      titleColor: colors.blackAndWhite.shade100,
      color: colors.pink.shade500,
      onTap: onTapPendingRequests,
    );
  }
}
