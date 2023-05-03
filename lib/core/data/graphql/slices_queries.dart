import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_connection.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_slice.dart';

String get getSliceMembersQuery => '''
    query(\$sliceId: ID!, \$roles: [SliceRole],\$cursor: CursorInput!,) {
       slicesMembersConnection(slicesMembersConnectionInput:{
            sliceId:\$sliceId,
            roles: \$roles,
       },
                   cursor: \$cursor,
       ){
            ${GqlTemplate().connection(nodeTemplate: GqlTemplate().sliceMembers)}
       }
    }
''';

String get updateSliceMutation => '''
mutation(\$sliceId: ID!, \$payload: SliceUpdateInput!) {
    updateSlice(updateSliceInput: { 
    sliceId: \$sliceId,
    payload: \$payload
    }) {
        ${GqlTemplate().slice}
    }
}
''';
