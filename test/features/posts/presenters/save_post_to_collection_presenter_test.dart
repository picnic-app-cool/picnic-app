import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/collection.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_initial_params.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presentation_model.dart';
import 'package:picnic_app/features/posts/save_post_to_collection/save_post_to_collection_presenter.dart';

import '../../../mocks/mock_definitions.dart';
import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late SavePostToCollectionPresentationModel model;
  late SavePostToCollectionPresenter presenter;
  late MockSavePostToCollectionNavigator navigator;
  late MockGetCollectionsUseCase getPostCollectionsUseCase;

  test(
    'tapping "add collection" should open openCreateNewCollectionBottomSheet',
    () async {
      //GIVEN
      when(
        () => navigator.openCreateNewCollectionBottomSheet(any()),
      ).thenAnswer((_) => Future.value());

      //WHEN
      await presenter.onTapCreateNewCollectionNavigation();

      //THEN
      verify(
        () => navigator.openCreateNewCollectionBottomSheet(any()),
      );
    },
  );

  test(
    'adding a new collection should append to the list of collections',
    () async {
      //GIVEN
      const newCollection = Collection.empty();
      when(
        () => navigator.openCreateNewCollectionBottomSheet(any()),
      ).thenAnswer((_) => Future.value(newCollection));

      //WHEN
      await presenter.onTapCreateNewCollectionNavigation();

      //THEN
      expect(presenter.state.postCollections.items.first, newCollection);
    },
  );

  setUp(() {
    model = SavePostToCollectionPresentationModel.initial(
      SavePostToCollectionInitialParams(userId: Stubs.id, postId: Stubs.id),
    );
    navigator = MockSavePostToCollectionNavigator();
    getPostCollectionsUseCase = MockGetCollectionsUseCase();
    presenter = SavePostToCollectionPresenter(
      model,
      navigator,
      getPostCollectionsUseCase,
      Mocks.addPostToCollectionUseCase,
    );
  });
}
