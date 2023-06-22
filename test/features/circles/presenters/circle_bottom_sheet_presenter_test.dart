import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_initial_params.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presentation_model.dart';
import 'package:picnic_app/features/circles/circle_details/circle_bottom_sheet_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../chat/mocks/chat_mocks.dart';
import '../mocks/circles_mock_definitions.dart';
import '../mocks/circles_mocks.dart';

void main() {
  late CircleBottomSheetPresentationModel model;
  late CircleBottomSheetPresenter presenter;
  late MockCircleBottomSheetNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = CircleBottomSheetPresentationModel.initial(CircleBottomSheetInitialParams(circleId: Stubs.circle.id));
    navigator = MockCircleBottomSheetNavigator();
    presenter = CircleBottomSheetPresenter(
      model,
      navigator,
      ChatMocks.getChatUseCase,
      CirclesMocks.getCircleDetailsUseCase,
      Mocks.getCircleStatsUseCase,
      CirclesMocks.viewCircleUseCase,
      CirclesMocks.joinCircleUseCase,
    );
  });
}
