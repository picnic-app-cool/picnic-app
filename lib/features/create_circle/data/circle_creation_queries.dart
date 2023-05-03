import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_circle.dart';

String get createCircleMutation => '''
mutation createCircle(\$circleInput: CirclesInput!) {
    createCircle(createCircleInput: { payload: \$circleInput }) {
        ${GqlTemplate().circleWithChatId}
    }
}
''';
