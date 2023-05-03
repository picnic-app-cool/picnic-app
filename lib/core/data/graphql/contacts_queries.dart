import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get getUserContactsQuery => '''
query(\$searchQuery: String){
 getUserContacts(searchQuery:\$searchQuery){
   contacts{
     id
     name
     phone{
       label
       number
     }
    }
  }
}
''';

String uploadContactsMutation = '''
mutation(\$contacts: [UserContactsInput!]!) {
  addUserContacts(
    userContactsInput: \$contacts
  ) {
    ${GqlTemplate().successPayload}
  }
}
''';

String notifyContactMutation = '''
mutation notifyContact(\$contactID: ID!, \$entityID: ID, \$notifyType: NotifyType!) {
  notifyContact(
    contactID: \$contactID,
    entityID: \$entityID,
    notifyType: \$notifyType
  ){
    ${GqlTemplate().successPayload}
  }
}
''';

String getUserMentionsQuery = '''
query(\$searchQuery: String, \$meta: NotifyMeta){
  userMentionsConnection(searchQuery: \$searchQuery, meta: \$meta){
    edges{
      cursorId
      node{
        avatar
        name
        followersCount
        phoneNumber{
          label
          number
        }
        userType
        id
      }
    }
    pageInfo{
      lastId
      firstId
      length
    }
  }
}
''';
