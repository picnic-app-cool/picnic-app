import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_melons_count_label.dart';
import 'package:picnic_app/utils/extensions/string_formatting.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class PicnicMessageOffer extends StatelessWidget {
  const PicnicMessageOffer({
    Key? key,
    required this.avatarImage,
    this.onTapPrimary,
    this.onTapSecondary,
    this.melonsCount = 0,
    this.seedsCount = 0,
    this.price = 0,
    this.circleName = 'circle',
    this.messageOfferState = PicnicMessageOfferState.sell,
  }) : super(key: key);

  final String avatarImage;
  final double melonsCount;
  final double seedsCount;
  final double price;
  final String circleName;
  final PicnicMessageOfferState messageOfferState;

  /// Called when the primary button is tapped.
  /// Has to be null if [melonsCount] is less than [price]
  /// or [messageOfferState] is [PicnicMessageOfferState.purchased]
  /// or [PicnicMessageOfferState.rejected]
  final VoidCallback? onTapPrimary;

  /// Called when the secondary button is tapped.
  final VoidCallback? onTapSecondary;

  static const EdgeInsets _defaultPadding = EdgeInsets.only(
    top: 24,
    bottom: 15,
    left: 30,
    right: 30,
  );
  static const double _defaultRadius = 25;
  static const double _defaultBlurRadius = 30;
  static const double _defaultShadowOpacity = 0.05;
  static const Offset _defaultShadowOffset = Offset(0, 20);

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final insufficientMelons = melonsCount < price;

    return Container(
      width: double.infinity,
      padding: _defaultPadding,
      decoration: BoxDecoration(
        color: colors.blackAndWhite.shade100,
        borderRadius: BorderRadius.circular(_defaultRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: _defaultBlurRadius,
            color: colors.blackAndWhite.shade900.withOpacity(_defaultShadowOpacity),
            offset: _defaultShadowOffset,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (messageOfferState == PicnicMessageOfferState.buy) ...[
            PicnicMelonsCountLabel(
              prefix: Image.asset(
                Assets.images.watermelonWhole.path,
              ),
              backgroundColor: insufficientMelons ? colors.pink.shade100 : colors.blackAndWhite.shade200,
              label: 'you have ${melonsCount.formattedPrice} melons',
            ),
            const Gap(10),
          ],
          _PicnicMessageOfferContent(
            price: price,
            avatarImage: avatarImage,
            seedsCount: seedsCount,
            circleName: circleName,
            messageOfferState: messageOfferState,
            onTapPrimary: onTapPrimary,
            onTapSecondary: onTapSecondary,
          ),
        ],
      ),
    );
  }
}

class _PicnicMessageOfferPrimaryButton extends StatelessWidget {
  const _PicnicMessageOfferPrimaryButton({
    Key? key,
    required this.messageOfferState,
    required this.price,
    this.onTap,
  }) : super(key: key);

  final PicnicMessageOfferState messageOfferState;
  final VoidCallback? onTap;
  final double price;

  static const double _borderWidth = 3.5;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final styles = theme.styles;
    final isPurchased = messageOfferState == PicnicMessageOfferState.purchased;
    final whiteColor = colors.blackAndWhite.shade100;

    return PicnicButton(
      style: PicnicButtonStyle.outlined,
      borderColor: colors.green,
      borderWidth: isPurchased ? _borderWidth : 0,
      color: _buttonColor(colors),
      titleColor: isPurchased ? colors.green : whiteColor,
      title: messageOfferState.getPrimaryLabel(price),
      size: PicnicButtonSize.large,
      onTap: onTap,
      suffix: messageOfferState != PicnicMessageOfferState.buy
          ? Expanded(
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    '${price.formattedPrice} melons',
                    style: styles.body10.copyWith(
                      color: isPurchased ? colors.green : whiteColor,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Color _buttonColor(PicnicColors colors) {
    switch (messageOfferState) {
      case PicnicMessageOfferState.rejected:
        return colors.pink;

      case PicnicMessageOfferState.purchased:
        return Colors.transparent;

      default:
        return colors.green;
    }
  }
}

class _PicnicMessageOfferContent extends StatelessWidget {
  const _PicnicMessageOfferContent({
    Key? key,
    required this.price,
    required this.avatarImage,
    required this.seedsCount,
    required this.circleName,
    required this.messageOfferState,
    required this.onTapPrimary,
    required this.onTapSecondary,
  }) : super(key: key);

  final double seedsCount;
  final String avatarImage;
  final double price;
  final String circleName;
  final VoidCallback? onTapPrimary;
  final VoidCallback? onTapSecondary;
  final PicnicMessageOfferState messageOfferState;

  static const double _defaultAvatarSize = 75;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    return Row(
      children: [
        PicnicAvatar(
          size: _defaultAvatarSize,
          backgroundColor: theme.colors.green.shade200,
          imageSource: PicnicImageSource.url(
            ImageUrl(avatarImage),
          ),
        ),
        const Gap(20),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${seedsCount.formattedPrice} $circleName seeds',
                style: theme.styles.title20,
              ),
              const Gap(10),
              _PicnicMessageOfferPrimaryButton(
                onTap: onTapPrimary,
                messageOfferState: messageOfferState,
                price: price,
              ),
              if (messageOfferState == PicnicMessageOfferState.sell || messageOfferState == PicnicMessageOfferState.buy)
                PicnicTextButton(
                  label: messageOfferState.getSecondaryLabel(),
                  onTap: onTapSecondary,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

enum PicnicMessageOfferState {
  sell,
  buy,
  rejected,
  purchased;

  String getPrimaryLabel(double price) {
    switch (this) {
      case PicnicMessageOfferState.sell:
        return appLocalizations.offerStateSellLabel;

      case PicnicMessageOfferState.buy:
        return appLocalizations.offerStateBuyLabel(price);

      case PicnicMessageOfferState.rejected:
        return appLocalizations.offerStateRejectedLabel;

      case PicnicMessageOfferState.purchased:
        return appLocalizations.offerStatePurchasedLabel;
    }
  }

  String getSecondaryLabel() {
    switch (this) {
      case PicnicMessageOfferState.sell:
        return appLocalizations.offerStateSellSecondaryLabel;

      case PicnicMessageOfferState.buy:
        return appLocalizations.offerStateBuySecondaryLabel;

      case PicnicMessageOfferState.purchased:
      case PicnicMessageOfferState.rejected:
        return '';
    }
  }
}
