import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/features/chat/domain/model/embed.dart';
import 'package:picnic_app/features/chat/widgets/chat_message/picnic_chat_style.dart';
import 'package:picnic_app/ui/widgets/picnic_image.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class ChatMessageContentLinkPreview extends StatelessWidget {
  const ChatMessageContentLinkPreview({
    required this.embed,
    required this.onTap,
    required this.chatStyle,
  });

  final Embed embed;
  final void Function(String url) onTap;
  final PicnicChatStyle chatStyle;

  static const _borderRadius = 16.0;
  static const _linkPreviewTextOpacity = .6;
  static const _maxLines = 2;
  static const _imageSize = 30.0;
  static const _imageBorderRadius = 6.0;

  static const _contentPadding = EdgeInsets.only(
    left: 8,
    right: 8,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final textStyleCaption10 = theme.styles.caption10;
    final textStyleBody10 = theme.styles.body10;

    final backgroundLeftColor = chatStyle.linkPreviewBackgroundLeftColor;
    final backgroundColor = colors.blackAndWhite.shade200;

    final link = embed.linkMetaData;

    return GestureDetector(
      onTap: () => onTap(link.url),
      child: Container(
        padding: const EdgeInsets.only(
          left: 2.5,
        ),
        decoration: BoxDecoration(
          color: backgroundLeftColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              _borderRadius,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                _borderRadius,
              ),
            ),
          ),
          child: Padding(
            padding: _contentPadding,
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(4),
                      Text(
                        link.title,
                        style: textStyleBody10.copyWith(
                          color: colors.blackAndWhite.shade800.withOpacity(_linkPreviewTextOpacity),
                        ),
                        maxLines: _maxLines,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (link.description.isNotEmpty) ...[
                        Text(
                          link.description,
                          style: textStyleCaption10,
                          maxLines: _maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Gap(4),
                      ],
                    ],
                  ),
                ),
                if (link.imageUrl.url.isNotEmpty) ...[
                  const Gap(4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(_imageBorderRadius),
                    child: PicnicImage(
                      source: PicnicImageSource.imageUrl(
                        link.imageUrl,
                        width: _imageSize,
                        height: _imageSize,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
