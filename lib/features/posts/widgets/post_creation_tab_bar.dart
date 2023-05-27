import 'package:flutter/material.dart';
import 'package:picnic_app/features/posts/domain/post_creation_preview_type.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_text_button.dart';

class PostCreationTabBar extends StatelessWidget {
  const PostCreationTabBar({
    Key? key,
    required this.onTap,
    required this.selectedType,
    required this.types,
    this.brightness = Brightness.dark,
  }) : super(key: key);

  final Function(PostCreationPreviewType) onTap;
  final PostCreationPreviewType selectedType;
  final Brightness brightness;
  final List<PostCreationPreviewType> types;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;
    final normalStyle = theme.styles.body20.copyWith(
      color: (brightness == Brightness.light ? blackAndWhite.shade100 : blackAndWhite.shade900).withOpacity(0.6),
    );
    final selectedStyle = theme.styles.subtitle20.copyWith(
      color: brightness == Brightness.light ? blackAndWhite.shade100 : blackAndWhite.shade900,
    );
    return LayoutBuilder(
      builder: (context, constraints) => Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: types
                .map(
                  (type) => PicnicTextButton(
                    label: type.label,
                    labelStyle: selectedType == type ? selectedStyle : normalStyle,
                    onTap: () => onTap(type),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
