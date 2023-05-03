import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_initial_params.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presentation_model.dart';
import 'package:picnic_app/features/posts/create_new_collection/create_new_collection_presenter.dart';
import 'package:picnic_app/features/profile/domain/model/create_collection_failure.dart';

import '../../../mocks/stubs.dart';
import '../../../test_utils/test_utils.dart';
import '../../profile/mocks/profile_mocks.dart';
import '../mocks/posts_mock_definitions.dart';

void main() {
  late CreateNewCollectionPresentationModel model;
  late CreateNewCollectionPresenter presenter;
  late MockCreateNewCollectionNavigator navigator;

  test(
    'tapping on create should call the use case that creates the collection and then trigger navigation to close the bottom sheet with success',
    () async {
      when(() => ProfileMocks.createCollectionUseCase.execute(any()))
          .thenAnswer((_) => successFuture(Stubs.collection));
      when(() => navigator.closeWithResult(Stubs.collection)).thenAnswer((_) => Future.value(_));

      await presenter.onTapCreate();

      verify(() => ProfileMocks.createCollectionUseCase.execute(any()));
      verify(() => navigator.closeWithResult(Stubs.collection));
    },
  );

  test(
    'tapping on create should call the use case that creates the collection but show an error in case it failed',
    () async {
      when(() => ProfileMocks.createCollectionUseCase.execute(any()))
          .thenAnswer((_) => failFuture(const CreateCollectionFailure.unknown()));
      when(() => navigator.showError(any())).thenAnswer((_) => Future.value());

      await presenter.onTapCreate();

      verify(() => ProfileMocks.createCollectionUseCase.execute(any()));
      verify(() => navigator.showError(any()));
      verifyNever(() => navigator.closeWithResult(any()));
    },
  );

  test(
    'tapping on close should trigger navigator to close the bottom sheet',
    () {
      when(() => navigator.close()).thenAnswer((_) => Future.value());

      presenter.onTapClose();

      verify(() => navigator.close());
    },
  );

  setUp(() {
    model = CreateNewCollectionPresentationModel.initial(const CreateNewCollectionInitialParams());
    navigator = MockCreateNewCollectionNavigator();
    presenter = CreateNewCollectionPresenter(
      model,
      navigator,
      ProfileMocks.createCollectionUseCase,
    );
  });
}
