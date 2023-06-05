import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/domain/model/circle.dart';
import 'package:picnic_app/core/domain/model/image_url.dart';
import 'package:picnic_app/core/utils/stat_extensions.dart';
import 'package:picnic_app/features/chat/domain/model/id.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_circle_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_container_icon_button.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_loading_indicator.dart';

class TrendingCircles extends StatelessWidget {
  const TrendingCircles({
    Key? key,
    required this.circles,
    required this.onTapJoin,
    required this.onTapCircleChat,
    required this.onTapShareCircle,
  }) : super(key: key);

  final List<Circle> circles;

  final Function(Id) onTapJoin;
  final Function(Circle) onTapCircleChat;
  final Function(Circle) onTapShareCircle;

  static const radius = 16.0;
  static const width = 280.0;
  static const height = 280.0;
  static const fontSize = 10.0;
  static const iconSize = 12.0;
  static const _buttonBorderWith = 2.0;

  static const double _avatarSize = 40;

  static const double _coverHeight = 80;

  static const double _emojiSize = 24;

  static const double _borderWidth = 0.5;

  static const double _bookMarkButtonRadius = 100;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final themeColors = theme.colors;

    final blackAndWhite = themeColors.blackAndWhite;
    return circles.isEmpty
        ? const PicnicLoadingIndicator()
        : SizedBox(
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final circle = circles[index];
                final body0 = theme.styles.body0.copyWith(color: themeColors.darkBlue.shade700);
                final pink = theme.colors.pink;
                final blue = theme.colors.blue.shade500;
                return GestureDetector(
                  onTap: () => onTapJoin(circle.id),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: blackAndWhite.shade100,
                            borderRadius: BorderRadius.circular(radius),
                            border: Border.all(
                              color: blackAndWhite.shade300,
                              width: _borderWidth,
                            ),
                          ),
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(radius),
                                ),
                                child: PicnicImage(
                                  source: circle.coverImage.isEmpty
                                      ? PicnicImageSource.url(
                                          const ImageUrl("https://picsum.photos/200/300"),
                                          width: _avatarSize,
                                          height: _coverHeight,
                                          fit: BoxFit.cover,
                                        )
                                      : PicnicImageSource.url(
                                          ImageUrl(circle.coverImage),
                                          width: _avatarSize,
                                          height: _coverHeight,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const Gap(8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Row(
                                  children: [
                                    PicnicCircleAvatar(
                                      emoji: circle.emoji,
                                      image: circle.imageFile,
                                      emojiSize: _emojiSize,
                                      avatarSize: _avatarSize,
                                      isVerified: circle.isVerified,
                                      bgColor: blackAndWhite.shade200,
                                    ),
                                    const Gap(8),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            circle.name,
                                            style: theme.styles.title30,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Gap(4),
                                          Row(
                                            children: [
                                              Assets.images.community
                                                  .image(width: iconSize, color: themeColors.darkBlue.shade700),
                                              const Gap(2),
                                              Text(
                                                circle.membersCount.formattingToStat(),
                                                style: body0.copyWith(fontSize: fontSize),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Text(
                                  circle.description,
                                  style: body0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Gap(12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(20),
                                  Expanded(
                                    child: PicnicButton(
                                      title: circle.iJoined
                                          ? appLocalizations.joinedButtonActionTitle
                                          : appLocalizations.joinAction,
                                      titleColor: circle.iJoined ? pink : blue,
                                      borderWidth: _buttonBorderWith,
                                      borderColor: circle.iJoined ? pink : blue,
                                      color: circle.iJoined ? Colors.white : blue,
                                      onTap: () => onTapJoin(circle.id),
                                      titleStyle: theme.styles.title10.copyWith(color: blackAndWhite.shade100),
                                      minWidth: double.infinity,
                                    ),
                                  ),
                                  const Gap(6),
                                  PicnicContainerIconButton(
                                    radius: _bookMarkButtonRadius,
                                    iconPath: Assets.images.chatOutlined.path,
                                    onTap: () => onTapCircleChat(circle),
                                    buttonColor: blackAndWhite.shade200,
                                  ),
                                  const Gap(6),
                                  PicnicContainerIconButton(
                                    radius: _bookMarkButtonRadius,
                                    iconPath: Assets.images.uploadOutlined.path,
                                    onTap: () => onTapShareCircle(circle),
                                    buttonColor: blackAndWhite.shade200,
                                  ),
                                  const Gap(20),
                                ],
                              ),
                              const Gap(20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
