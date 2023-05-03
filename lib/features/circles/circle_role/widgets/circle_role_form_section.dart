import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:picnic_app/core/utils/text_color.dart';
import 'package:picnic_app/features/circles/circle_role/widgets/circle_role_permission_section.dart';
import 'package:picnic_app/features/circles/domain/model/circle_custom_role.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/picnic_text_input.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

class CircleRoleFormSection extends StatelessWidget {
  const CircleRoleFormSection({
    required this.onChangedName,
    required this.circleRole,
    required this.onPostContentPermissionChanged,
    required this.onSendMessagesPermissionChanged,
    required this.onEmbedLinksPermissionChanged,
    required this.onAttachFilesPermissionChanged,
    required this.onManageUsersPermissionChanged,
    required this.onManageRolesPermissionChanged,
    required this.onManageCirclePermissionChanged,
    required this.onManageMessagesPermissionChanged,
    required this.onManageReportsPermissionChanged,
    required this.onManageCommentsPermissionChanged,
    Key? key,
    required this.selectedColor,
    required this.onTapColorPicker,
    required this.textController,
    this.onTapConfirm,
  }) : super(key: key);

  final ValueChanged<String> onChangedName;
  final ValueChanged<bool> onPostContentPermissionChanged;
  final ValueChanged<bool> onSendMessagesPermissionChanged;
  final ValueChanged<bool> onEmbedLinksPermissionChanged;
  final ValueChanged<bool> onAttachFilesPermissionChanged;

  final ValueChanged<bool> onManageUsersPermissionChanged;
  final ValueChanged<bool> onManageRolesPermissionChanged;
  final ValueChanged<bool> onManageCirclePermissionChanged;
  final ValueChanged<bool> onManageMessagesPermissionChanged;
  final ValueChanged<bool> onManageReportsPermissionChanged;
  final ValueChanged<bool> onManageCommentsPermissionChanged;

  final CircleCustomRole circleRole;
  final VoidCallback onTapColorPicker;
  final TextColor selectedColor;
  final TextEditingController textController;
  final VoidCallback? onTapConfirm;

  static const _dividerThickness = 2.0;

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    const circleAvatarSize = 20.0;
    final body20 = theme.styles.body20;
    return Column(
      children: [
        PicnicTextInput(
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(
              14,
              16,
              6,
              16,
            ),
            child: SizedBox(
              width: circleAvatarSize,
              height: circleAvatarSize,
              child: CircleAvatar(
                backgroundColor: selectedColor.color,
              ),
            ),
          ),
          textController: textController,
          onTap: onTapColorPicker,
          readOnly: true,
        ),
        PicnicTextInput(
          initialValue: circleRole.name,
          hintText: appLocalizations.circle_role_name_label,
          onChanged: onChangedName,
        ),
        const Gap(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appLocalizations.generalPermissionsLabel,
                style: body20,
              ),
              const Gap(12),
              CircleRolePermissionSection(
                text: appLocalizations.permission_post_content,
                initialSwitchValue: circleRole.canPostContent,
                onSwitchChanged: onPostContentPermissionChanged,
                description: appLocalizations.permissionPostContentDescription,
              ),
              const Gap(12),
              CircleRolePermissionSection(
                text: appLocalizations.permission_send_messages,
                initialSwitchValue: circleRole.canSendMessages,
                onSwitchChanged: onSendMessagesPermissionChanged,
                description: appLocalizations.permissionSendMessagesDescription,
              ),
              const Gap(12),
              CircleRolePermissionSection(
                text: appLocalizations.permission_embed_links,
                initialSwitchValue: circleRole.canEmbedLinks,
                onSwitchChanged: onEmbedLinksPermissionChanged,
                description: appLocalizations.permissionEmbedLinksDescription,
              ),
              const Gap(12),
              CircleRolePermissionSection(
                text: appLocalizations.permission_attach_files,
                initialSwitchValue: circleRole.canAttachFiles,
                onSwitchChanged: onAttachFilesPermissionChanged,
                description: appLocalizations.permissionAttachFilesDescription,
              ),
              const Gap(12),
              Divider(
                color: theme.colors.blackAndWhite.shade200,
                thickness: _dividerThickness,
              ),
              const Gap(12),
              Text(
                appLocalizations.moderationPermissionsLabel,
                style: body20,
              ),
              const Gap(12),
              CircleRolePermissionSection(
                text: appLocalizations.permissionManageCircle,
                initialSwitchValue: circleRole.canManageCircle,
                onSwitchChanged: onManageCirclePermissionChanged,
                description: appLocalizations.permissionManageCircleDescription,
              ),
              CircleRolePermissionSection(
                text: appLocalizations.permissionManageUsers,
                initialSwitchValue: circleRole.canManageUsers,
                onSwitchChanged: onManageUsersPermissionChanged,
                description: appLocalizations.permissionManageUsersDescription,
              ),
              CircleRolePermissionSection(
                text: appLocalizations.permissionManageReports,
                initialSwitchValue: circleRole.canManageReports,
                onSwitchChanged: onManageReportsPermissionChanged,
                description: appLocalizations.permissionManageReportsDescription,
              ),
              CircleRolePermissionSection(
                text: appLocalizations.permissionManageMessages,
                initialSwitchValue: circleRole.canManageMessages,
                onSwitchChanged: onManageMessagesPermissionChanged,
                description: appLocalizations.permissionManageMessagesDescription,
              ),
              CircleRolePermissionSection(
                text: appLocalizations.permissionManageRoles,
                initialSwitchValue: circleRole.canManageRoles,
                onSwitchChanged: onManageRolesPermissionChanged,
                description: appLocalizations.permissionManageRolesDescription,
              ),
              const Gap(12),
              CircleRolePermissionSection(
                text: appLocalizations.permissionManageComments,
                initialSwitchValue: circleRole.canManageComments,
                onSwitchChanged: onManageCommentsPermissionChanged,
                description: appLocalizations.permissionManageCommentsDescription,
              ),
              const Gap(12),
              SizedBox(
                width: double.infinity,
                child: PicnicButton(
                  title: appLocalizations.confirmAction,
                  style: PicnicButtonStyle.outlined,
                  color: theme.colors.green,
                  onTap: onTapConfirm,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
