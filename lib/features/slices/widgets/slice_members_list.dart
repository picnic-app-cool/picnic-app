import 'package:flutter/material.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/circles/domain/model/slice_member.dart';
import 'package:picnic_app/localization/app_localizations_utils.dart';
import 'package:picnic_app/ui/widgets/default_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_avatar.dart';
import 'package:picnic_app/ui/widgets/picnic_image_source.dart';
import 'package:picnic_app/ui/widgets/picnic_list_item.dart';
import 'package:picnic_ui_components/ui/theme/picnic_colors.dart';
import 'package:picnic_ui_components/ui/theme/picnic_theme.dart';
import 'package:picnic_ui_components/ui/widgets/picnic_button.dart';

//ignore_for_file: unused-code, unused-files
class SliceMembersList extends StatelessWidget {
  const SliceMembersList({
    Key? key,
    required this.sliceMembers,
    required this.onSliceMemberTap,
    required this.title,
    this.trailing,
    this.onTapFollow,
  }) : super(key: key);

  final PaginatedList<SliceMember> sliceMembers;
  final Function(SliceMember) onSliceMemberTap;
  final Function(SliceMember)? onTapFollow;
  final String title;
  final Widget? trailing;

  static const _avatarSize = 40.0;

  static const _primaryFilledButtonPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 8.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = PicnicTheme.of(context);
    final styles = theme.styles;
    final white = theme.colors.blackAndWhite.shade100;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < sliceMembers.items.length) {
            final sliceMember = sliceMembers.items[index];
            final sliceType = sliceMember.role;
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: PicnicListItem(
                height: null,
                title: sliceMember.user.username,
                titleStyle: styles.subtitle20,
                leading: PicnicAvatar(
                  size: _avatarSize,
                  boxFit: PicnicAvatarChildBoxFit.cover,
                  imageSource: PicnicImageSource.url(
                    sliceMember.user.profileImageUrl,
                    fit: BoxFit.cover,
                  ),
                  placeholder: () => DefaultAvatar.user(),
                ),
                trailing: onTapFollow != null
                    ? PicnicButton(
                        padding: _primaryFilledButtonPadding,
                        titleStyle: styles.subtitle20.copyWith(
                          color: white,
                        ),
                        title:
                            sliceMember.user.iFollow ? appLocalizations.followingAction : appLocalizations.followAction,
                        onTap: () => onTapFollow!(sliceMember),
                      )
                    : Text(
                        sliceType.valueToDisplay,
                        style: styles.subtitle40.copyWith(
                          color: PicnicColors.bluishCyan,
                        ),
                      ),
                onTap: () => onSliceMemberTap(sliceMember),
              ),
            );
          } else {
            return Container();
          }
        },
        childCount: sliceMembers.items.length,
      ),
    );
  }
}
