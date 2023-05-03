import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/core/domain/model/paginated_list.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_navigator.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_page.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';

Future<void> main() async {
  late SeedRecipientsPage page;
  late SeedRecipientsInitialParams initParams;
  late SeedRecipientsPresentationModel model;
  late SeedRecipientsPresenter presenter;
  late SeedRecipientsNavigator navigator;

  void initMvp() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);

    initParams = SeedRecipientsInitialParams(circleId: Stubs.id);
    model = SeedRecipientsPresentationModel.initial(
      initParams,
      Mocks.userStore,
    );
    navigator = SeedRecipientsNavigator(Mocks.appNavigator);
    presenter = SeedRecipientsPresenter(
      model,
      navigator,
      Mocks.debouncer,
      Mocks.searchUsersUseCase,
    );
    page = SeedRecipientsPage(presenter: presenter);

    when(
      () => Mocks.searchUsersUseCase.execute(
        nextPageCursor: any(
          named: 'nextPageCursor',
        ),
        query: '',
        ignoreMyself: any(named: 'ignoreMyself'),
      ),
    ).thenAnswer(
      (_) => successFuture(PaginatedList.singlePage(List.filled(5, Stubs.publicProfile))),
    );
  }

  await screenshotTest(
    "seed_recipients_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    initMvp();
    final page = getIt<SeedRecipientsPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
