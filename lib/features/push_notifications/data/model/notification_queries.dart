import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String saveDeviceTokenMutation = '''
mutation notificationSaveDeviceToken(\$token: String!, \$platform: Platform!) {
    notificationSaveDeviceToken(token:\$token, platform: \$platform) {
        ${GqlTemplate().successPayload}
    }
}
''';
