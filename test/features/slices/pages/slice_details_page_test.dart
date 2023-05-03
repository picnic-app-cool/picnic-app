import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_initial_params.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_navigator.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_page.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presentation_model.dart';
import 'package:picnic_app/features/slices/slice_details/slice_details_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';

Future<void> main() async {
  //ignore: unused_local_variable
  late SliceDetailsPage page;
  late SliceDetailsInitialParams initParams;
  late SliceDetailsPresentationModel model;
  late SliceDetailsPresenter presenter;
  late SliceDetailsNavigator navigator;

  void _initMvp() {
    initParams = SliceDetailsInitialParams(
      circle: Stubs.circle,
      slice: Stubs.slice,
    );
    model = SliceDetailsPresentationModel.initial(
      initParams,
    );
    navigator = SliceDetailsNavigator(Mocks.appNavigator, Mocks.userStore);
    presenter = SliceDetailsPresenter(
      model,
      Mocks.getSliceMemberByRoleUseCase,
      navigator,
      Mocks.clipboardManager,
      Mocks.debouncer,
    );

    page = SliceDetailsPage(presenter: presenter);
  }

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<SliceDetailsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
