import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_circle_config.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_circle_permissions.dart';

extension GqlTemplateCircle on GqlTemplate {
  String get basicCircle => '''
id
name
description
image
imageFile
coverImageFile
membersCount
languageCode
rulesText
kind
isBanned
isVerified
iJoined
role
shareLink
visibility
reportsCount
options {
  ${GqlTemplate().circleConfig}
}
permissions {
  ${GqlTemplate().circlePermissions}
}
roles {
  ${GqlTemplate().circleMemberCustomRoles}
}
''';

  String get circleWithChatId => '''
$basicCircle
chat {
    id
}
''';

  String get circleWithChat => '''
$basicCircle
chat {
    $basicChat
}
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

  String get circleMembers => '''
role
user {
  $memberProfile
}
isBanned
roles {
  ${GqlTemplate().circleMemberCustomRoles}
}
''';

  String get voteCandidate => '''
user {
   $memberProfile
}
votesCount
votesPercent
position
margin
''';

  String get reports => '''
reportId 
userId
anyId
reportType
status
reason
comment 
resolvedAt
moderator {
    id
    username
    profileImage
}
reporter {
    id 
    username
    profileImage
}
contentAuthor {
    id
    username
    profileImage
}

''';

  String get blackListedWords => '''
      pageInfo {
            firstId
            lastId
            hasNextPage
            hasPreviousPage
            length
        }
        edges {word}
''';

  String get groupsOfCircles => '''
groupId
name
circles {
  $basicCircle
  group
}
''';

  String get onboardingCircles => '''
name
circles {
  $basicCircle
}
''';

  String get pods => '''
apps
''';

  String get interest => '''
id
name
emoji
''';
}
