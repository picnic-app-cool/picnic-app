import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateMinimalPublicProfile on GqlTemplate {
  String get basicPublicProfile => '''
                  isFollowing
                  id
                  username
                  isVerified
                  profileImage
                  
  ''';
}
