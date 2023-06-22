import 'package:picnic_app/core/data/graphql/templates/gql_linked_accounts_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String getConnectedSocialAccountsQuery = '''
  query () {
    getLinkedAccounts() {
      ${GqlTemplate().linkedAccounts}
    }
  }
''';

String linkDiscordAccountMutation = '''
  mutation (\$request: LinkDiscordAccountInput!) {
    linkDiscordAccount(request: \$request) {
      account {
         ${GqlTemplate().discord}
      }
    }
  }
''';

String linkRobloxAccountMutation = '''
  mutation (\$request: LinkRobloxAccountInput!) {
    linkRobloxAccount(request: \$request) {
      account {
         ${GqlTemplate().roblox}
      }
    }
  }
''';

String unlinkRobloxAccountMutation = '''
  mutation () {
    unlinkRobloxAccount() {
      ${GqlTemplate().successPayload}
    }
  }
''';

String unlinkDiscordAccountMutation = '''
  mutation () {
    unlinkDiscordAccount() {
      ${GqlTemplate().successPayload}
    }
  }
''';
