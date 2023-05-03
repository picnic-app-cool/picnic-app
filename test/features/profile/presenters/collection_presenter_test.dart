import 'package:dartz/dartz.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/core/utils/utils.dart';
import 'package:picnic_app/features/profile/collection/collection_initial_params.dart';
import 'package:picnic_app/features/profile/collection/collection_presentation_model.dart';
import 'package:picnic_app/features/profile/collection/collection_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late CollectionPresentationModel model;
  late CollectionPresenter presenter;
  late MockCollectionNavigator navigator;
  late MockGetPostsInCollectionUseCase getPostsInCollectionUseCase;
  late MockDeleteCollectionUseCase deleteCollectionUseCase;

  test(
    'tapping on an action should navigate to the collection settings',
    () async {
      fakeAsync(
        (async) {
          // GIVEN
          when(
            () => navigator.showCollectionSettings(
              onDelete: any(named: 'onDelete'),
            ),
          ).thenAnswer(
            (invocation) {
              final onDelete = invocation.namedArguments[#onDelete] as VoidCallback;
              return onDelete.call();
            },
          );

          // WHEN
          presenter.onTapActions();
          async.flushMicrotasks();

          // THEN
          verify(
            () => navigator.showCollectionSettings(
              onDelete: any(named: 'onDelete'),
            ),
          );
        },
      );
    },
  );

  test(
    'tapping on post should open SingleFeedPage',
    () {
      // GIVEN
      when(
        () => navigator.openSingleFeed(any()),
      ).thenAnswer(
        (_) => successFuture(unit),
      );

      // WHEN
      presenter.onTapViewPost(Stubs.linkPost);

      // THEN
      verify(
        () => navigator.openSingleFeed(any()),
      );
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    when(
      () => ProfileMocks.getPostsInCollectionUseCase.execute(
        collectionId: any(named: 'collectionId'),
        nextPageCursor: any(named: 'nextPageCursor'),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    when(
      () => ProfileMocks.deleteCollectionUseCase.execute(
        collectionId: any(named: 'collectionId'),
      ),
    ).thenAnswer((invocation) => successFuture(unit));

    when(
      () => ProfileMocks.removeCollectionPostsUseCase.execute(
        collectionId: any(named: 'collectionId'),
        postIds: any(named: 'postIds'),
      ),
    ).thenAnswer((invocation) => successFuture(unit));
    model = CollectionPresentationModel.initial(
      const CollectionInitialParams(collection: Collection.empty()),
      Mocks.userStore,
    );
    navigator = MockCollectionNavigator();
    getPostsInCollectionUseCase = MockGetPostsInCollectionUseCase();
    deleteCollectionUseCase = MockDeleteCollectionUseCase();
    presenter = CollectionPresenter(
      model,
      navigator,
      getPostsInCollectionUseCase,
      deleteCollectionUseCase,
      ProfileMocks.removeCollectionPostsUseCase,
    );
  });
}
