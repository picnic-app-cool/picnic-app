import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_chat_message.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get getCirclesQuery => '''
    query(\$searchQuery: String, \$cursor: CursorInput!) {
        circlesConnection(
          searchQuery: \$searchQuery, 
          cursor: \$cursor,
        ) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().circleWithChat)}
        }
    }
''';

String get getCircleNameByIdQuery => '''
    query(\$searchQuery: String, \$isStrict: Boolean!) {
      circlesConnection(searchQuery: \$searchQuery, isStrict: \$isStrict) {
        edges {
          node { 
            id, name
          }
        }
      }
    }
''';

String get getUserCirclesQuery => '''
    query(\$getUserCircles: GetUserCirclesRequest!) {
        getUserCircles(getUserCircles: \$getUserCircles) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().circleWithChat)}
        }
    }
''';

String get getCircleByIdQuery => '''
    query(\$circleId: ID!) {
        getCircleById(
          getCircleByIdInput: {
            circleId: \$circleId,
          }
        ){
          ${GqlTemplate().circleWithChatId}
        }
    }
''';

String get getBasicCircleByIdQuery => '''
    query(\$circleId: ID!) {
        getCircleById(
          getCircleByIdInput: {
            circleId: \$circleId
          }
        ){
          ${GqlTemplate().basicCircle}
        }
    }
''';

String get joinCirclesMutation => '''
  mutation(\$circleIds: [ID!]!) {
    joinCircles(
      joinCircleInput: {
        circleIds: \$circleIds
      }
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get removeCustomBLWordsMutation => '''
  mutation(\$circleId: ID!, \$words: [String!]!) {
    removeCustomBLWords(
      removeCustomBLWordInput: {
        circleId: \$circleId,
        words:\$words
      }
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get createCircleCustomRoleMutation => '''
  mutation(\$createCircleCustomRoleInput: CreateCircleCustomRoleInput!) {
    createCircleCustomRole(createCircleCustomRoleInput: \$createCircleCustomRoleInput) {
      roleId
    }
   }
  ''';

String get updateCircleCustomRoleMutation => '''
  mutation(\$updateCircleCustomRoleInput: UpdateCircleCustomRoleInput!) {
    updateCircleCustomRole(updateCircleCustomRoleInput: \$updateCircleCustomRoleInput) {
      roleId
    }
   }
  ''';

String get addCustomBLWordsMutation => '''
  mutation(\$circleId: ID!, \$words: [String!]!) {
    addCustomBLWords(
      addCustomBLWordsInput: {
        circleId: \$circleId,
        words:\$words
      }
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get leaveCirclesMutation => '''
  mutation(\$circleIds: [ID!]!) {
    leaveCircles(
      joinCircleInput: {
        circleIds: \$circleIds
      }
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get banUserInCircleMutation => '''
  mutation(\$circleId: ID!, \$userId: ID!){
       banUserInCircle(banUserInput:{
            userId:\$userId,
            circleId:\$circleId
       }){
         userId,
       }
   }
    ''';

String get updateCircleMemberRoleMutation => '''
 mutation(\$circleId: ID!, \$userId: ID!,  \$role: CircleRole!, \$isModPermissionEnabled: Boolean!) {
       setUsersRoleInCircle(userRoleInCircleInput:{
            roleAssignments: {
                userId: \$userId,
                circleId: \$circleId,
                role: \$role,
                moderatorRoleSettings: {
                    isModerator: \$isModPermissionEnabled
                }
              
            }
       }){
      ${GqlTemplate().successPayload}
       }
   }''';

String get unbanUserInCircleMutation => '''
   mutation(\$circleId: ID!, \$userId: ID!){
       unbanUserInCircle(banUserInput:{
            userId:\$userId,
            circleId:\$circleId
       }){
         userId,
       }
   }
    ''';

String get getCircleMembersQuery => '''
    query(\$circleId: ID!, \$isBanned: Boolean, \$cursor: CursorInput!, \$roles: [CircleRole], \$searchQuery: String) {
       getMembers(getMembersInput:{
            circleId:\$circleId,
            cursor: \$cursor,
            isBanned: \$isBanned,
            roles: \$roles,
            searchQuery: \$searchQuery
       }){
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().circleMembers)}
       }
    }
''';

String get getCircleStatsQuery => '''
query(\$circleID: String!) {
  contentStatsForCircle(circleID: \$circleID) {
    likes
    views
    members
    posts
  }
}
''';

String get updateCircleMutation => '''
mutation updateCircle(\$circleId: ID!, \$circleInput: CirclesInput!) {
    updateCircle(updateCircleInput: { 
      circleId: \$circleId, 
      payload: \$circleInput 
    }) {
      ${GqlTemplate().circleWithChatId}
    }
}
''';

String get inviteUsersToCircleMutation => '''
  mutation inviteUsersToCirclesMutation(\$inviteToCircleInput: InviteToCircleInput!) {
    inviteUsersToCircle(inviteToCircleInput: \$inviteToCircleInput) {
      ${GqlTemplate().circleWithChatId}
    }
  }
''';

String get getCircleReportsConnectionQuery => '''
     query(\$circleId: ID!,  \$cursor: CursorInput!, \$filterBy: CircleReportsFilterBy!){
  circleReportsConnection(
      circleReportsConnectionInput: {
        circleId: \$circleId,
        cursor: \$cursor,
        filterBy: \$filterBy,
    }
  ){
    ${GqlTemplate().connection(nodeTemplate: GqlTemplate().reports)}
    }  
  }
''';

String get resolveReportMutation => '''
   mutation(\$circleId: ID!, \$reportId: ID!, \$fullFill: Boolean!,){
   resolveReport(
      resolveReportInput: {
        circleId: \$circleId,
        reportId: \$reportId,
        fullFill: \$fullFill,
    }
  ){
      ${GqlTemplate().successPayload}
      }
    }
''';

String get blackListedWordsQuery => '''
     query(\$circleId: ID!, \$cursor: CursorInput!,\$searchQuery: String){
   blwConnection(
           cursor: \$cursor,
       blwConnectionInput: {
        circleId: \$circleId,
        searchQuery: \$searchQuery

    }
  ){
           ${GqlTemplate().blackListedWords}
        }
   }
''';

//marginSize = number of messages we want BEFORE and AFTER the reported message with id 'messageId'
String get getRelatedMessagesQuery => '''
   query(\$messageId: ID!, \$marginSize: Int!,){
   getRelatedMessages(
        messageId: \$messageId,
        marginSize: \$marginSize,
  ){
    ${GqlTemplate().chatMessage}
      }
    }
''';

String get listGroupsQuery => '''
    query(\$listGroupsRequest: ListGroupsInput!,) {
      listGroups(
          listGroupsRequest: \$listGroupsRequest,
      ){
          edges {
              node {
              ${GqlTemplate().groupsOfCircles}}
              }
          }
      }
''';

String get onBoardingCirclesConnectionQuery => '''
    query() {
      onBoardingCirclesConnection(){
          edges {
              ${GqlTemplate().onboardingCircles}}
          }
      }
''';

String get deleteCircleCustomRole => """
mutation(\$roleId: ID!, \$circleId: ID!){
    deleteCircleCustomRole(deleteCircleCustomRoleInput:{
        roleId: \$roleId
        circleId: \$circleId
    }){
        ${GqlTemplate().successPayload}
    }
}
""";

String get assignUserRoleMutation => """
mutation(\$circleId: String!, \$roleId: String!, \$userId: String!) {
  addCustomRoleToUserInCircle(
    addCustomRoleToUserInCircleInput: {
      circleId: \$circleId,
      roleId: \$roleId,
      userId: \$userId
    }
  ) {
    ${GqlTemplate().successPayload}
  }
}
""";

String get unAssignUserRoleMutation => """
mutation(\$circleId: String!, \$roleId: String!, \$userId: String!) {
  deleteCustomRoleFromUserInCircle(
    deleteCustomRoleFromUserInCircleInput: {
      circleId: \$circleId,
      roleId: \$roleId,
      userId: \$userId
    }
  ) {
    ${GqlTemplate().successPayload}
  }
}
""";
