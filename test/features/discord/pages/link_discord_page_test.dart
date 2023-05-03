import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/discord/domain/model/discord_config_response.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_navigator.dart';
import 'package:picnic_app/features/discord/link_discord_page.dart';
import 'package:picnic_app/features/discord/link_discord_presentation_model.dart';
import 'package:picnic_app/features/discord/link_discord_presenter.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../mocks/discord_mocks.dart';

Future<void> main() async {
  late LinkDiscordPage page;
  late LinkDiscordInitialParams initParams;
  late LinkDiscordPresentationModel model;
  late LinkDiscordPresenter presenter;
  late LinkDiscordNavigator navigator;

  void initMvp() {
    when(() => DiscordMocks.getDiscordConfigUseCase.execute(circleId: Stubs.circle.id))
        .thenAnswer((invocation) => successFuture(const DiscordConfigResponse.empty()));
    initParams = LinkDiscordInitialParams(circleId: Stubs.circle.id);
    model = LinkDiscordPresentationModel.initial(
      initParams,
    );
    navigator = LinkDiscordNavigator(Mocks.appNavigator);
    presenter = LinkDiscordPresenter(
      model,
      Mocks.clipboardManager,
      DiscordMocks.connectDiscordServerUseCase,
      DiscordMocks.getDiscordConfigUseCase,
      DiscordMocks.revokeDiscordWebhookUseCase,
      navigator,
    );

    getIt.registerFactoryParam<LinkDiscordPresenter, LinkDiscordInitialParams, dynamic>(
      (initialParams, _) => presenter,
    );
    page = LinkDiscordPage(initialParams: initParams);
  }

  await screenshotTest(
    "link_discord_page",
    setUp: () async {
      initMvp();
    },
    pageBuilder: () => page,
  );
}
