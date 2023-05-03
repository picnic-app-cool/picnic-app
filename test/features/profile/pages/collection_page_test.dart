import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/page_info.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/collection/collection_navigator.dart';
import 'package:picnic_app/features/profile/collection/collection_page.dart';
import 'package:picnic_app/features/profile/collection/collection_presentation_model.dart';
import 'package:picnic_app/features/profile/collection/collection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mocks.dart';

Future<void> main() async {
  late CollectionPage page;
  late CollectionInitialParams initParams;
  late CollectionPresentationModel model;
  late CollectionPresenter presenter;
  late CollectionNavigator navigator;

  void _initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    initParams = const CollectionInitialParams(
      collection: Collection.empty(),
    );
    model = CollectionPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    when(
      () => ProfileMocks.getPostsInCollectionUseCase.execute(
        nextPageCursor: any(named: 'nextPageCursor'),
        collectionId: any(named: 'collectionId'),
      ),
    ).thenAnswer(
      (invocation) => successFuture(
        PaginatedList(
          pageInfo: const PageInfo.firstPage(),
          items: [
            Stubs.imagePost,
            Stubs.imagePost,
            Stubs.imagePost,
            Stubs.imagePost,
          ],
        ),
      ),
    );

    navigator = CollectionNavigator(Mocks.appNavigator);
    presenter = CollectionPresenter(
      model,
      navigator,
      ProfileMocks.getPostsInCollectionUseCase,
      ProfileMocks.deleteCollectionUseCase,
      ProfileMocks.removeCollectionPostsUseCase,
    );
    page = CollectionPage(presenter: presenter);
  }

  await screenshotTest(
    "collection_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<CollectionPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
