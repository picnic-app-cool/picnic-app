import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_initial_params.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_navigator.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_page.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presentation_model.dart';
import 'package:picnic_app/features/settings/community_guidelines/community_guidelines_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';

Future<void> main() async {
  late CommunityGuidelinesPage page;
  late CommunityGuidelinesInitialParams initParams;
  late CommunityGuidelinesPresentationModel model;
  late CommunityGuidelinesPresenter presenter;
  late CommunityGuidelinesNavigator navigator;

  void _initMvp() {
    initParams = const CommunityGuidelinesInitialParams();
    model = CommunityGuidelinesPresentationModel.initial(
      initParams,
    );
    navigator = CommunityGuidelinesNavigator(Mocks.appNavigator);
    presenter = CommunityGuidelinesPresenter(
      model,
      navigator,
    );
    page = CommunityGuidelinesPage(presenter: presenter);
  }

  await screenshotTest(
    "community_guidelines_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CommunityGuidelinesPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
