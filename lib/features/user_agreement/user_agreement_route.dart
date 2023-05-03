import 'package:flutter/material.dart';
import 'package:picnic_app/features/user_agreement/widgets/user_agreement_blocker.dart';
import 'package:picnic_app/navigation/app_navigator.dart';
import 'package:picnic_app/ui/widgets/picnic_bottom_sheet.dart';

mixin UserAgreementRoute {
  AppNavigator get appNavigator;

  Future<void> openUserAgreementBottomSheet({
    required VoidCallback onTapTerms,
    required VoidCallback onTapPolicies,
    required VoidCallback onTapAccept,
  }) =>
      showPicnicBottomSheet(
        UserAgreementBlocker(
          onTapTerms: onTapTerms,
          onTapPolicies: onTapPolicies,
          onTapAccept: onTapAccept,
        ),
        isDismissible: false,
        enableDrag: false,
      );
}
