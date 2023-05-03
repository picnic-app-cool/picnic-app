import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_circle_member_custom_roles.dart';
import 'package:picnic_app/features/circles/data/graphql/gql_template_custom_role.dart';

String getCircleCustomRoles = """
query(\$circleId: String!){
        getCircleCustomRoles(circleId: \$circleId){
            edges {
                ${GqlTemplate().customRole}
            }
        },
   }
""";

String getUserRolesInCircleQuery = """
query(\$circleId: String!, \$userId: String!){
        getCircleMemberCustomRoles(circleId: \$circleId, userId: \$userId){
           ${GqlTemplate().circleMemberCustomRoles}
        },
   }
""";
