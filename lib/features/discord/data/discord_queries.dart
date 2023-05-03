import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get connectWebhookMutation => '''
  mutation(\$configureDiscordWebhookInput: ConfigureDiscordWebhookInput!) {
    configureDiscordWebhook(
      configureDiscordWebhookInput: \$configureDiscordWebhookInput
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get revokeWebhookMutation => '''
  mutation(\$revokeDiscordWebhookInput: RevokeDiscordWebhookInput!) {
    revokeDiscordWebhook(
      revokeDiscordWebhookInput: \$revokeDiscordWebhookInput
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get getDiscordConfigQuery => '''
  query(\$circleId: String!) {
    getDiscordConfig(
      circleId: \$circleId
    ){
      webhookConfigured
    }
  }
''';
