import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_navigator.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_page.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presentation_model.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../profile/mocks/profile_mocks.dart';

Future<void> main() async {
  late CreateNewCollectionPage page;
  late CreateNewCollectionInitialParams initParams;
  late CreateNewCollectionPresentationModel model;
  late CreateNewCollectionPresenter presenter;
  late CreateNewCollectionNavigator navigator;

  void initMvp() {
    initParams = const CreateNewCollectionInitialParams();
    model = CreateNewCollectionPresentationModel.initial(
      initParams,
    );
    navigator = CreateNewCollectionNavigator(Mocks.appNavigator);
    presenter = CreateNewCollectionPresenter(
      model,
      navigator,
      ProfileMocks.createCollectionUseCase,
    );
    page = CreateNewCollectionPage(presenter: presenter);
  }

  await screenshotTest(
    "create_new_collection_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<CreateNewCollectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
