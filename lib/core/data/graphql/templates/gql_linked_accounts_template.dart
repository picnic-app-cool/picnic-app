import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlLinkedAccountsTemplate on GqlTemplate {
  String get linkedAccounts => '''
      roblox {
        $roblox
      }
      discord {
        $discord
      }
    ''';

  String get roblox => '''
      name
      nickname
      preferredUsername
      createdAt
      profileURL
      linkedDate
    ''';

  String get discord => '''
      username
      discriminator
      profileURL
      linkedDate
    ''';
}
