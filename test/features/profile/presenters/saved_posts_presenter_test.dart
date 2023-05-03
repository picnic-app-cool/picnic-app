import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/cursor.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_initial_params.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presentation_model.dart';
import 'package:picnic_app/features/profile/saved_posts/saved_posts_presenter.dart';

import '../../../test_utils/test_utils.dart';
import '../mocks/profile_mock_definitions.dart';
import '../mocks/profile_mocks.dart';

void main() {
  late SavedPostsPresentationModel model;
  late SavedPostsPresenter presenter;
  late MockSavedPostsNavigator navigator;

  test(
    "sample test",
    () async {
      expect(presenter, isNotNull);
    },
  );

  setUp(() {
    model = SavedPostsPresentationModel.initial(const SavedPostsInitialParams());
    navigator = MockSavedPostsNavigator();

    when(
      () => ProfileMocks.getSavedPostsUseCase.execute(
        nextPageCursor: const Cursor.firstPage(),
      ),
    ).thenAnswer((invocation) => successFuture(const PaginatedList.empty()));

    presenter = SavedPostsPresenter(
      model,
      navigator,
      ProfileMocks.getSavedPostsUseCase,
    );
  });
}
