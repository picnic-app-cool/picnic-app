import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/domain/model/user_mention.dart';
import 'package:picnic_app/core/utils/durations.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/suggestion_list/picnic_suggested_user_tap_component.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PollImage extends StatelessWidget {
  const PollImage({
    super.key,
    required this.onTap,
    required this.imagePath,
    required this.isMentionsPollPostCreationEnabled,
    this.suggestedUsersToMention,
    this.onChanged,
    this.onTapSuggestedMention,
    this.mentionedUser,
    this.offSet,
  });

  final VoidCallback onTap;
  final String imagePath;
  final PaginatedList<UserMention>? suggestedUsersToMention;
  final ValueChanged<String>? onChanged;
  final ValueChanged<UserMention>? onTapSuggestedMention;
  final UserMention? mentionedUser;
  final Offset? offSet;
  final bool isMentionsPollPostCreationEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWithe = theme.colors.blackAndWhite;
    final blue800 = theme.colors.blue.shade800;
    final styles = theme.styles;
    final borderRadius = BorderRadius.circular(24);
    const height = 280.0;
    const placeholderImageScale = 0.75;

    final emptyImageView = Center(
      child: Assets.images.image.image(
        scale: placeholderImageScale,
        opacity: const AlwaysStoppedAnimation(0.4),
      ),
    );
    final imageView = Image.file(
      File(imagePath),
      fit: BoxFit.cover,
    );

    final mentionedUserIsNone = mentionedUser == null || mentionedUser?.id.isNone == true;

    const avatarSize = 36.0;
    const avatarDistanceTop = 10.0;
    const avatarDistanceLeft = 12.0;

    return Material(
      color: blackAndWithe.shade200,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            children: [
              AnimatedSwitcher(
                layoutBuilder: _defaultLayoutBuilder,
                duration: const LongDuration(),
                child: ClipRRect(
                  key: ValueKey(imagePath),
                  borderRadius: borderRadius,
                  child: imagePath.isEmpty ? emptyImageView : imageView,
                ),
              ),
              if (isMentionsPollPostCreationEnabled)
                Positioned(
                  top: avatarDistanceTop,
                  left: avatarDistanceLeft,
                  child: PicnicSuggestedUserTapComponent(
                    offSet: offSet,
                    onTapSuggestedMention: onTapSuggestedMention,
                    onChanged: onChanged,
                    suggestedUsersToMention: suggestedUsersToMention,
                    compositedChild: Row(
                      children: [
                        PicnicAvatar(
                          boxFit: PicnicAvatarChildBoxFit.cover,
                          backgroundColor: !mentionedUserIsNone ? blue800 : blackAndWithe.shade300,
                          size: avatarSize,
                          imageSource: !mentionedUserIsNone
                              ? PicnicImageSource.url(
                                  ImageUrl(mentionedUser!.avatar),
                                  fit: BoxFit.cover,
                                )
                              : PicnicImageSource.asset(
                                  ImageUrl(
                                    Assets.images.profile.path,
                                  ),
                                  color: !mentionedUserIsNone ? blackAndWithe.shade100 : blue800,
                                ),
                        ),
                        if (!mentionedUserIsNone) ...[
                          const Gap(8),
                          Text(
                            mentionedUser!.name,
                            style: styles.body20.copyWith(color: blackAndWithe.shade600),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _defaultLayoutBuilder(
    Widget? currentChild,
    List<Widget> previousChildren,
  ) {
    return Stack(
      children: <Widget>[
        ...previousChildren.map((it) => Positioned.fill(child: it)),
        if (currentChild != null) Positioned.fill(child: currentChild),
      ],
    );
  }
}
