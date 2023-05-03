import 'package:flutter/material.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_app/ui/widgets/picnic_tag.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RolesTags extends StatelessWidget {
  const RolesTags({
    Key? key,
    required this.roles,
    this.onTapRemoveRole,
  }) : super(key: key);

  final List<CircleCustomRole> roles;
  final Function(CircleCustomRole)? onTapRemoveRole;
  static const _tagBorderRadius = 10.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final blackAndWhite = theme.colors.blackAndWhite;

    final picnicTags = roles.map(
      (role) {
        final removeTagButton = GestureDetector(
          onTap: onTapRemoveRole != null ? () => onTapRemoveRole!(role) : null,
          child: Image.asset(
            Assets.images.close.path,
            color: blackAndWhite.shade100,
          ),
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: PicnicTag(
            title: role.name,
            suffixIcon: onTapRemoveRole != null ? removeTagButton : null,
            backgroundColor: role.formattedColor.color,
            blurRadius: null,
            titleTextStyle: theme.styles.body20.copyWith(color: blackAndWhite.shade100),
            borderRadius: _tagBorderRadius,
          ),
        );
      },
    ).toList();

    return Flexible(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 110),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...picnicTags,
            ],
          ),
        ),
      ),
    );
  }
}
