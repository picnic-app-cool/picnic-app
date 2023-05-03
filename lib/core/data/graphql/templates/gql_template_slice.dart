import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat.dart';

extension GqlTemplateSlice on GqlTemplate {
  String get slice => '''
id
name
description
image
membersCount
circleId
ownerId
roomsCount
iJoined
iRequestedToJoin
rules
private
discoverable
chat {
  $basicChat
}
''';

  String get sliceMembers => '''
role
user {
  $memberProfile
}
bannedAt
joinedAt
''';

  String get memberProfile => '''
id
username
fullName
bio
followers
likes
views
isVerified
age
profileImage
isBlocked
isFollowing
followsMe
''';
}
