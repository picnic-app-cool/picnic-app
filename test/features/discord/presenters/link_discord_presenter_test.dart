import 'package:flutter_test/flutter_test.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_presentation_model.dart';
import 'package:picnic_app/features/discord/link_discord_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../mocks/discord_mock_definitions.dart';
import '../mocks/discord_mocks.dart';

void main() {
  late LinkDiscordPresentationModel model;
  late LinkDiscordPresenter presenter;
  late MockLinkDiscordNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = LinkDiscordPresentationModel.initial(LinkDiscordInitialParams(circleId: Stubs.circle.id));
    navigator = MockLinkDiscordNavigator();
    presenter = LinkDiscordPresenter(
      model,
      Mocks.clipboardManager,
      DiscordMocks.connectDiscordServerUseCase,
      DiscordMocks.getDiscordConfigUseCase,
      DiscordMocks.revokeDiscordWebhookUseCase,
      navigator,
    );
  });
}
