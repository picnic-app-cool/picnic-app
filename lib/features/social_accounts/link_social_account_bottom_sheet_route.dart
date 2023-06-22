import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/social_accounts/domain/social_network_type.dart';
import 'package:picnic_app/features/social_accounts/widgets/link_social_account_success.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin LinkSocialAccountBottomSheetRoute {
  //ignore: long-parameter-list
  Future<void> showLinkSocialAccountSuccessBottomSheet({
    required SocialNetworkType socialNetworkType,
    required String picnicUserImageUrl,
    required String username,
    required String linkedDate,
    required VoidCallback onTapOpenExternalUrl,
  }) async {
    return showPicnicBottomSheet(
      LinkSocialAccountSuccess(
        username: username,
        picnicUserImageUrl: picnicUserImageUrl,
        onTapOpenExternalUrl: onTapOpenExternalUrl,
        linkedDate: linkedDate,
        socialNetworkType: socialNetworkType,
      ),
    );
  }

  AppNavigator get appNavigator;
}
