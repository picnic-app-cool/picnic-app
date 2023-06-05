import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/core/domain/model/pod_app.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_page.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/pods/pod_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/pods_mocks.dart';

Future<void> main() async {
  late PodBottomSheetPage page;
  late PodBottomSheetInitialParams initParams;
  late PodBottomSheetPresentationModel model;
  late PodBottomSheetPresenter presenter;
  late PodBottomSheetNavigator navigator;

  void initMvp() {
    initParams = const PodBottomSheetInitialParams(pod: PodApp.empty());
    model = PodBottomSheetPresentationModel.initial(
      initParams,
    );
    navigator = PodBottomSheetNavigator(Mocks.appNavigator);
    presenter = PodBottomSheetPresenter(
      model,
      navigator,
      CirclesMocks.votePodsUseCase,
      PodsMocks.savePodUseCase,
      CirclesMocks.unVotePodsUseCase,
    );

    getIt.registerFactoryParam<PodBottomSheetPresenter, PodBottomSheetInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = PodBottomSheetPage(presenter: presenter);
  }

  await screenshotTest(
    "pod_bottom_sheet_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
