import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/posts/post_share/post_share_initial_params.dart';
import 'package:picnic_app/features/posts/post_share/post_share_page.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late PostSharePage page;
  late PostShareInitialParams initParams;

  void initMvp() {
    initParams = PostShareInitialParams(
      post: Stubs.textPost,
    );
    page = PostSharePage(
      initialParams: initParams,
    );
  }

  await screenshotTest(
    "post_share_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
