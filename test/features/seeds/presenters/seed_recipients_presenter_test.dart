import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_initial_params.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presentation_model.dart';
import 'package:picnic_app/features/seeds/seed_recipients/seed_recipients_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/seeds_mock_definitions.dart';

void main() {
  late SeedRecipientsPresentationModel model;
  late SeedRecipientsPresenter presenter;
  late MockSeedRecipientsNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    when(() => Mocks.userStore.privateProfile).thenReturn(Stubs.privateProfile);
    model = SeedRecipientsPresentationModel.initial(SeedRecipientsInitialParams(circleId: Stubs.id), Mocks.userStore);
    navigator = MockSeedRecipientsNavigator();
    presenter = SeedRecipientsPresenter(
      model,
      navigator,
      Mocks.debouncer,
      Mocks.searchUsersUseCase,
    );
  });
}
