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

  String get fullUser => '''
  id
  username
  fullName
  bio
  email
  age
  phone
  languages
  likes
  views
  languages
  followers
  melonsAmount
  seedsAmount
  isVerified
  profileImage
  createdAt
  shareLink
  meta{
    pendingSteps
  }
  ''';
}
