import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_slice.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get getSlicesQuery => '''
    query(\$circleId: ID!, \$cursor: CursorInput!) {
        slicesConnection(sliceConnectionInput: {
            circleId: \$circleId, 
           }, cursor: \$cursor) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().slice)}
        }
    }
''';

String get approveJoinRequestMutation => '''
    mutation(\$acceptRequestInput: AcceptRequestInput!) {
        accept(acceptRequestInput: \$acceptRequestInput) {
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().slice)}
        }
    }
''';

String get joinSliceMutation => '''
  mutation(\$sliceId: ID!) {
    joinSlices(
      joinSlicesInput: {
        sliceId: \$sliceId
      }
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';

String get leaveSliceMutation => '''
  mutation(\$sliceId: ID!) {
    leaveSlice(
      leaveSliceInput: {
        sliceId: \$sliceId
      }
    ){
      ${GqlTemplate().successPayload}
    }
  }
''';
