//ignore_for_file: unused-code, unused-files
import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_user.dart';

const String fullUserFragment = """
fragment FullUserFragment on PublicProfile {
    id
    username
    fullName
    bio
    followers
    likes
    views
    isVerified
    profileImage
    createdAt
    isFollowing
    followsMe
    isBlocked
    shareLink
}
""";

const String getUserByIdQuery = """
query(\$id: ID!) {
  user(id: \$id) {
      ...FullUserFragment
  }
}

$fullUserFragment
""";

const String getUserByUsernameQuery = """
query(\$userName: String!) {
  profileGetUserIDByName(userName: \$userName) {
      userId
  }
}
""";

const String getProfileStatsQuery = """
query(\$userID: String!) {
  contentStatsForProfile(userID: \$userID) {
    likes
    views
    followers
  }
}
""";

String getMyProfileQuery = """
query() {
  myProfile {
    ${GqlTemplate().user}
    followers
    melonsAmount
    likes
    views
    languages
    age
    phone
    email
    meta {
      pendingSteps
    }
  }
}
""";
String joinChatQuery = """
mutation joinChat(\$chatId: ID!) {
  joinChat(chatId: \$chatId) {
       ${GqlTemplate().successPayload}  

  }
}
""";
String editMyProfileMutation = """
mutation updateProfileInfo(\$username: String, \$name: String, \$bio: String, \$age: Int) {
    updateProfileInfo(profile: {
        info: {
            username: \$username,
            bio: \$bio,
            name: \$name,
            age: \$age,
        }
    }) {
       ${GqlTemplate().successPayload}  

    }
}
""";

String get searchUsersQuery => '''
    query(\$searchQuery: String!, \$cursor: CursorInput!) {
        usersConnection(searchQuery: \$searchQuery, cursor: \$cursor) {
            pageInfo{
                firstId
                lastId
                hasNextPage
                hasPreviousPage
            }
            edges{
                cursorId
                node{
                    id,
                    username
                    bio                  
                    profileImage
                    isVerified                
                }
               relations{
                followedBy
                following
               }
            }
        }
    }
''';

String requestDeleteAccountMutation = """
mutation deleteAccountRequest(\$reason: String!){
    deleteAccountRequest(reason: \$reason) {
         ${GqlTemplate().successPayload}  
 
    }
}
""";

String changeFollowStatusMutation = """
mutation changeFollowStatus(\$userId: ID!, \$shouldFollow:Boolean!) {
  changeFollowStatus(userId: \$userId, shouldFollow:  \$shouldFollow ) {
       ${GqlTemplate().successPayload}  

  }
}
""";

String changeBlockStatusMutation = """
mutation changeBlockStatus(\$userId: ID!, \$shouldBlock:Boolean!) {
  changeBlockStatus(userId: \$userId, shouldBlock:  \$shouldBlock ) {
       ${GqlTemplate().successPayload}  

  }
}
""";

String updatePrivacySettingsMutation = """
mutation updatePrivacySettings(\$OnlyDMFromFollowed:Boolean!) {
  updatePrivacySettings(OnlyDMFromFollowed:  \$OnlyDMFromFollowed ) {
       ${GqlTemplate().successPayload}  

  }
}
""";

const String getPrivacySettingsMutation = """
mutation getPrivacySettings() {
  getPrivacySettings() {
      directMessagesFromAccountsYouFollow
  }
}
""";

const String getNotificationSettingsQuery = """
query() {
    getNotificationSettings {
        notificationId
        likes
        comments
        newFollowers
        mentions
        directMessages
        postsFromAccountsYouFollow
        circleChats
        groupChats
        glitterBombs
        commentLikes
        postSaves
        postShares
        seeds
        circleJoins
        circleInvites
    }
}
""";

const String getFollowersQuery = """
query(\$id: ID!, \$searchQuery: String!, \$cursor: CursorInput!) {
    followersConnection(userId: \$id, searchQuery: \$searchQuery, cursor: \$cursor){
        pageInfo{
            firstId
            lastId
            hasNextPage
            hasPreviousPage
            length
        }
        edges{
            cursorId
            node{
                id
                username
                profileImage
                isVerified
            }
            relations{
                followedBy
                following
            }
        }
    }
}
""";

const String getBlockedUsersQuery = """
query(\$cursor: CursorInput!) {
    blockedUsersConnection(cursor: \$cursor) {
        pageInfo{
            hasNextPage
            hasPreviousPage
            firstId
            lastId
            length
        }
        edges{
            cursorId
            node{
                id
                username
                profileImage
            }
        }
    }
}
""";

String updateUserPreferredLanguagesMutation = """
mutation updateUserPreferredLanguages(\$languagesCodes:[String!]) {
  updateUserPreferredLanguages(languagesCodes:  \$languagesCodes) {
 ${GqlTemplate().successPayload}  
 }
}
""";

String upsertNotificationSettingsMutation = """
mutation upsertNotificationSettings(\$settings:NotificationsSettingsInput!) {
    upsertNotificationSettings(settings :\$settings) {
         ${GqlTemplate().successPayload}  

    }
}
""";

const String updatePrivateProfileImage = """
mutation updateProfileImage(\$image: UserProfileImageInput!) {
  updateProfileImage(image: \$image)
}
""";

const String getNotificationsQuery = """
    query(\$cursor: CursorInput!) {
        notificationGet(cursor: \$cursor) {
            pageInfo{
                firstId
                lastId
                hasNextPage
                hasPreviousPage
                length
            }
            edges{
                node{
                    id
                    fromInfo {
                        id
                        type
                        name
                        avatar
                        relation
                    }
                    receiverInfo {
                        id
                        type
                        name
                        avatar
                    }
                    sourceInfo {
                        id
                        type
                        name
                        avatar
                    }
                    subSourceInfo {
                        id
                        type
                        name
                        avatar
                    }
                    action
                    readAt
                    imageURL
                    createdAt

                }
            }
        }
    }
""";

String get getNonMemberUsersQuery => '''
    query searchUsersConnection(\$searchQuery: String!, \$circleID: String!, \$cursor: CursorInput!) {
        searchUsersConnection(searchQuery: \$searchQuery, circleID: \$circleID, cursor: \$cursor) {
            pageInfo{
                firstId
                lastId
                hasNextPage
                hasPreviousPage
                length
            }
            edges{
                cursorId
                node{
                    id
                    username
                    fullName                  
                    profileImage          
                    isVerified     
                }
            }
        }
    }
''';

String glitterbombMutation = """
mutation glitterbombMutation(\$userId: ID!) {
  userGlitterBomb(targetUserID: \$userId) {
       ${GqlTemplate().successPayload}  

  }
}
""";

const String getUnreadNotificationsCountQuery = '''
query() {
  notificationGetUnreadCount() {
      count
  }
}
''';

const String markAllNotificationsAsReadMutation = '''
mutation{
    markAllNotificationsAsRead{
        success
    }   
}
''';
