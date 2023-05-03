import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_navigator.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_page.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presentation_model.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presenter.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late SavePostToCollectionPage page;
  late SavePostToCollectionInitialParams initParams;
  late SavePostToCollectionPresentationModel model;
  late SavePostToCollectionPresenter presenter;
  late SavePostToCollectionNavigator navigator;
  late MockGetCollectionsUseCase getPostCollectionsUseCase;

  void initMvp() {
    initParams = SavePostToCollectionInitialParams(userId: Stubs.id, postId: Stubs.id);
    model = SavePostToCollectionPresentationModel.initial(
      initParams,
    );
    navigator = SavePostToCollectionNavigator(Mocks.appNavigator);
    getPostCollectionsUseCase = MockGetCollectionsUseCase();
    when(
      () => getPostCollectionsUseCase.execute(
        returnSavedPostsCollection: false,
        nextPageCursor: any(named: 'nextPageCursor'),
        userId: any(named: 'userId'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(Stubs.postCollections),
    );
    when(
      () => Mocks.addPostToCollectionUseCase.execute(
        postId: Stubs.id,
        collectionId: Stubs.id,
      ),
    ).thenAnswer(
      (invocation) => successFuture(unit),
    );
    presenter = SavePostToCollectionPresenter(
      model,
      navigator,
      getPostCollectionsUseCase,
      Mocks.addPostToCollectionUseCase,
    );
    page = SavePostToCollectionPage(presenter: presenter);
  }

  await screenshotTest(
    "save_post_to_collection_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<SavePostToCollectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
