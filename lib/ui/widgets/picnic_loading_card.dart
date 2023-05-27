import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

/// {@template picnic_loading_card}
/// Picnic loading card to display on loadings scenarios.
///
/// [title] is the primary text displayed on the card.
///
/// [description] is a text description usually to show a long text.
///
/// If the [circleAvatarEmoji] and [circleName] is given the card will display
/// both on footer of the card.
/// {@endtemplate}
class PicnicLoadingCard extends StatelessWidget {
  /// {@macro picnic_loading_card}
  const PicnicLoadingCard({
    super.key,
    required this.title,
    required this.description,
    this.circleAvatarEmoji,
    this.circleName,
  });

  final String title;
  final String description;
  final PicnicImageSource? circleAvatarEmoji;
  final String? circleName;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final borderRadius = BorderRadius.circular(20);
    const avatarSizeCircle = 32.0;
    const paddingDialogContent = EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
    );

    return Container(
      padding: paddingDialogContent,
      decoration: BoxDecoration(
        color: theme.colors.darkBlue.shade100,
        borderRadius: borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.styles.subtitle40,
          ),
          const Gap(8),
          Text(
            description,
            style: theme.styles.caption20,
          ),
          if (circleAvatarEmoji != null && circleName != null) ...[
            const Gap(16),
            Row(
              children: [
                PicnicAvatar(
                  imageSource: circleAvatarEmoji!,
                  size: avatarSizeCircle,
                  borderColor: theme.colors.blackAndWhite.shade100,
                  backgroundColor: theme.colors.blue.shade200,
                ),
                const Gap(8),
                Text(circleName!, style: theme.styles.body30),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
