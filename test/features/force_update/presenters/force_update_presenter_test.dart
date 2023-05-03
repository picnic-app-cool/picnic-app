import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/force_update/force_update_initial_params.dart';
import 'package:picnic_app/features/force_update/force_update_presentation_model.dart';
import 'package:picnic_app/features/force_update/force_update_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/force_update_mock_definitions.dart';
import '../mocks/force_update_mocks.dart';

void main() {
  late ForceUpdatePresentationModel model;
  late ForceUpdatePresenter presenter;
  late MockForceUpdateNavigator navigator;

  test(
    'should call usecase when tapping update',
    () async {
      // GIVEN
      when(() => ForceUpdateMocks.openStoreUseCase.execute(any())).thenAnswer((_) => successFuture(unit));

      // WHEN
      await presenter.onTapUpdate();

      //then
      verify(() => ForceUpdateMocks.openStoreUseCase.execute(any()));
    },
  );

  setUp(() {
    when(() => Mocks.appInfoStore.appInfo).thenReturn(Stubs.appInfo);

    model = ForceUpdatePresentationModel.initial(
      const ForceUpdateInitialParams(),
      Mocks.appInfoStore,
    );
    navigator = MockForceUpdateNavigator();
    presenter = ForceUpdatePresenter(model, navigator, ForceUpdateMocks.openStoreUseCase);
  });
}
