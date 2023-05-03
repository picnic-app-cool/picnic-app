import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/features/discord/domain/model/connect_discord_server_failure.dart';
import 'package:picnic_app/features/discord/domain/model/get_discord_config_failure.dart';
import 'package:picnic_app/features/discord/domain/model/revoke_discord_webhook_failure.dart';
import 'package:picnic_app/features/discord/domain/repositories/discord_repository.dart';
import 'package:picnic_app/features/discord/domain/use_cases/connect_discord_server_use_case.dart';
import 'package:picnic_app/features/discord/domain/use_cases/get_discord_config_use_case.dart';
import 'package:picnic_app/features/discord/domain/use_cases/revoke_discord_webhook_use_case.dart';
import 'package:picnic_app/features/discord/link_discord_initial_params.dart';
import 'package:picnic_app/features/discord/link_discord_navigator.dart';
import 'package:picnic_app/features/discord/link_discord_presentation_model.dart';
import 'package:picnic_app/features/discord/link_discord_presenter.dart';

//DO-NOT-REMOVE IMPORTS_MOCK_DEFINITIONS

// MVP

class MockLinkDiscordPresenter extends Mock implements LinkDiscordPresenter {}

class MockLinkDiscordPresentationModel extends Mock implements LinkDiscordPresentationModel {}

class MockLinkDiscordInitialParams extends Mock implements LinkDiscordInitialParams {}

class MockLinkDiscordNavigator extends Mock implements LinkDiscordNavigator {}

//DO-NOT-REMOVE MVP_MOCK_DEFINITION

// USE CASES
class MockConnectDiscordServerFailure extends Mock implements ConnectDiscordServerFailure {}

class MockConnectDiscordServerUseCase extends Mock implements ConnectDiscordServerUseCase {}

class MockGetDiscordConfigFailure extends Mock implements GetDiscordConfigFailure {}

class MockGetDiscordConfigUseCase extends Mock implements GetDiscordConfigUseCase {}

class MockRevokeDiscordWebhookFailure extends Mock implements RevokeDiscordWebhookFailure {}

class MockRevokeDiscordWebhookUseCase extends Mock implements RevokeDiscordWebhookUseCase {}

//DO-NOT-REMOVE USE_CASE_MOCK_DEFINITION

// REPOSITORIES
class MockDiscordRepository extends Mock implements DiscordRepository {}
//DO-NOT-REMOVE REPOSITORIES_MOCK_DEFINITION

// STORES
//DO-NOT-REMOVE STORES_MOCK_DEFINITION
