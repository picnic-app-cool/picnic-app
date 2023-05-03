import 'package:flutter/material.dart';
import 'package:picnic_app/features/circles/circle_member_settings/widgets/roles_tags.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/resources/assets.gen.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';

class RolesHorizontalContainer extends StatelessWidget {
  const RolesHorizontalContainer({
    Key? key,
    required this.roles,
    this.onTapRemoveRole,
    this.onTapShowMoreRoles,
  }) : super(key: key);

  final List<CircleCustomRole> roles;
  final ValueChanged<CircleCustomRole>? onTapRemoveRole;
  final VoidCallback? onTapShowMoreRoles;

  static const _defaultRadius = 16.0;

  static const _defaultContentPadding = EdgeInsets.only(
    top: 16.0,
    right: 12.0,
    bottom: 16.0,
    left: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);

    final blackAndWhite = theme.colors.blackAndWhite;

    final rolesTags = RolesTags(
      roles: roles,
      onTapRemoveRole: onTapRemoveRole,
    );

    final downArrowSuffix = GestureDetector(
      onTap: onTapShowMoreRoles,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Image.asset(
          Assets.images.arrowDown.path,
          color: blackAndWhite.shade600,
        ),
      ),
    );

    return GestureDetector(
      onTap: roles.isEmpty ? onTapShowMoreRoles : null,
      child: Container(
        decoration: BoxDecoration(
          color: blackAndWhite.shade200,
          borderRadius: BorderRadius.circular(_defaultRadius),
        ),
        child: Padding(
          padding: _defaultContentPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rolesTags,
              if (onTapShowMoreRoles != null) downArrowSuffix,
            ],
          ),
        ),
      ),
    );
  }
}
