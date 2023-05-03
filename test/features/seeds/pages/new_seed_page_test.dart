import 'package:picnic_app/features/seeds/new_seeds/new_seed_page.dart';

import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late NewSeedPage page;

  void _initMvp() {
    page = const NewSeedPage();
  }

  await screenshotTest(
    "new_seed_page",
    setUp: () async => _initMvp(),
    pageBuilder: () => page,
  );
}
