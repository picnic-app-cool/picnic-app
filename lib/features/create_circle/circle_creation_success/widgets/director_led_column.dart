import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/features/circles/widgets/decorated_sheet.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/widgets/director_led_success_view.dart';
import 'package:picnic_app/features/create_circle/circle_creation_success/widgets/picnic_app_link_bar.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/dialog/picnic_dialog.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class DirectorLedColumn extends StatelessWidget {
  const DirectorLedColumn({
    Key? key,
    required this.onTapLinkBar,
    required this.onTapAwesome,
    required this.circleName,
    required this.circleShareLink,
  }) : super(key: key);

  final VoidCallback onTapLinkBar;
  final VoidCallback onTapAwesome;
  final String circleName;
  final String circleShareLink;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          PicnicDialog(
            image: PicnicAvatar(
              backgroundColor: blackAndWhite.shade300,
              imageSource: PicnicImageSource.asset(
                ImageUrl(Assets.images.congrats.path),
              ),
            ),
            title: appLocalizations.congratsSuccessTitle,
            description: appLocalizations.congratsSuccessDescription,
            content: Column(
              children: [
                PicnicAppLinkBar(
                  text: circleShareLink,
                  onTap: onTapLinkBar,
                ),
                const Gap(12),
              ],
            ),
          ),
          DecoratedSheet(
            onTap: onTapAwesome,
            buttonTitle: appLocalizations.awesomeAction,
            child: ListView(
              children: [
                Text(
                  appLocalizations.circleSuccessTitle(circleName),
                  style: theme.styles.title30,
                ),
                const Gap(20),
                const DirectorLedSuccessView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
