import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/link_metadata.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class PicnicVerticalLinkPost extends StatelessWidget {
  const PicnicVerticalLinkPost({
    Key? key,
    required this.metadata,
  }) : super(key: key);

  final LinkMetadata metadata;

  static const _textMaxLines = 5;
  static const _linkMaxLines = 2;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final whiteColor = theme.colors.blackAndWhite.shade100;
    final whiteWithOpacity = whiteColor.withOpacity(0.7);
    final textColor = whiteColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            metadata.title,
            overflow: TextOverflow.ellipsis,
            maxLines: _textMaxLines,
            style: theme.styles.subtitle30.copyWith(
              color: textColor,
            ),
          ),
        ),
        Text(
          metadata.host,
          overflow: TextOverflow.ellipsis,
          maxLines: _linkMaxLines,
          style: theme.styles.caption10.copyWith(
            color: whiteWithOpacity,
          ),
        ),
      ],
    );
  }
}
