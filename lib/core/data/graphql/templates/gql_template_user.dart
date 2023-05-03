import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';

extension GqlTemplateUser on GqlTemplate {
  String get user => '''
id
username
fullName
bio
isVerified
profileImage
createdAt
shareLink
''';
}
