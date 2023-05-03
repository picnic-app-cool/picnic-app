import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/model/posts/post.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_icon_button.dart';

class FullTextView extends StatelessWidget {
  const FullTextView({
    Key? key,
    required this.text,
    required this.post,
    required this.onTapCompress,
  }) : super(key: key);

  final String text;
  final Post post;
  final VoidCallback onTapCompress;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final colors = theme.colors;
    final blackAndWhite = colors.blackAndWhite;
    final blackColor = blackAndWhite.shade900;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                text,
                style: theme.styles.body30,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: PicnicIconButton(
            icon: Assets.images.compress.path,
            onTap: onTapCompress,
            iconColor: blackColor,
          ),
        ),
      ],
    );
  }
}
