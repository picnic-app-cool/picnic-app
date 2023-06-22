import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_navigator.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_page.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/circles_mocks.dart';

Future<void> main() async {
  late CircleBottomSheetPage page;
  late CircleBottomSheetInitialParams initParams;
  late CircleBottomSheetPresentationModel model;
  late CircleBottomSheetPresenter presenter;
  late CircleBottomSheetNavigator navigator;

  void initMvp() {
    when(() => Mocks.getCircleStatsUseCase.execute(circleId: Stubs.circle.id)).thenSuccess((_) => Stubs.circleStats);
    when(() => CirclesMocks.getCircleDetailsUseCase.execute(circleId: Stubs.circle.id))
        .thenAnswer((_) => successFuture(Stubs.circle.copyWith(iJoined: true)));
    when(
      () => CirclesMocks.viewCircleUseCase.execute(
        circleId: any(named: 'circleId'),
      ),
    ).thenAnswer((_) => successFuture(unit));
    initParams = CircleBottomSheetInitialParams(circleId: Stubs.circle.id);
    model = CircleBottomSheetPresentationModel.initial(
      initParams,
    );
    navigator = CircleBottomSheetNavigator(Mocks.appNavigator);
    presenter = CircleBottomSheetPresenter(
      model,
      navigator,
      ChatMocks.getChatUseCase,
      CirclesMocks.getCircleDetailsUseCase,
      Mocks.getCircleStatsUseCase,
      CirclesMocks.viewCircleUseCase,
      CirclesMocks.joinCircleUseCase,
    );

    getIt.registerFactoryParam<CircleBottomSheetPresenter, CircleBottomSheetInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = CircleBottomSheetPage(presenter: presenter);
  }

  await screenshotTest(
    "circle_bottom_sheet_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
