import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/circles/widgets/invite_user_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin InviteUsersRoute {
  Future<void> openInviteUsersBottomSheet({
    required VoidCallback onTapClose,
    required VoidCallback onTapCopyLink,
    required VoidCallback onTapInvite,
  }) =>
      showPicnicBottomSheet(
        InviteUserBottomSheet(
          onTapClose: onTapClose,
          onTapCopyLink: onTapCopyLink,
          onTapInvite: onTapInvite,
        ),
      );
}
