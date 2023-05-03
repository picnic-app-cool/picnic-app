import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/discord/widgets/revoke_webhook_bottom_sheet.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin RevokeWebhookBottomSheetRoute {
  Future<void> showRevokeBottomSheet({
    required VoidCallback onTapRevoke,
    required VoidCallback onTapCancel,
  }) =>
      showPicnicBottomSheet(
        RevokeWebhookBottomSheet(
          onTapRevoke: onTapRevoke,
          onTapCancel: onTapCancel,
        ),
      );
}
