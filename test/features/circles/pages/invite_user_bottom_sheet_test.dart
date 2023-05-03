import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/widgets/invite_user_bottom_sheet.dart';

import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late InviteUserBottomSheet page;
  void _initMvp() {
    page = InviteUserBottomSheet(
      onTapClose: () {},
      onTapCopyLink: () {},
      onTapInvite: () {},
    );
  }

  await screenshotTest(
    "invite_user_bottom_sheet",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );
}
